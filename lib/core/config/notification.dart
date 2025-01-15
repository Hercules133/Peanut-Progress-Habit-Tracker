import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

/// A service class for managing local notifications in the application.
///
/// This class provides methods to initialize the notification service,
/// handle notification responses, and schedule notifications.
///
/// ### Usage
/// To use this service, call the `init` method to initialize the notification
/// settings and then use other methods to schedule or manage notifications.
///
///
class NotificationService {
  /// The instance of [FlutterLocalNotificationsPlugin] used to manage notifications.
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Handles notification responses when a notification is received.
  ///
  /// This method is called when a notification is tapped or interacted with.
  ///
  /// [notificationResponse] - The response received from the notification.
  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {}
  // Handle the notification response here.

  /// Initializes the notification service with platform-specific settings.
  ///
  /// This method sets up the notification settings for Android, iOS, macOS,
  /// and Linux platforms. It should be called once during the app initialization.
  ///
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  /// Shows an instant notification with the specified title and body.
  ///
  /// This method displays a notification immediately with the given title and body content.
  /// The notification is configured with platform-specific settings for Android and iOS.
  ///
  /// ### Parameters:
  /// - [title]: The title of the notification.
  /// - [body]: The body content of the notification.
  ///
  static Future<void> showInstantNotification(String title, String body) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_notification_channel_id',
          'Instant Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'instant_notification',
    );
  }

  /// Schedules a notification to be shown at a specified time.
  ///
  /// [id] - The unique identifier for the notification.
  /// [title] - The title of the notification.
  /// [body] - The body content of the notification.
  /// [scheduledTime] - The time at which the notification should be shown.
  ///
  static Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledTime) async {
    if (!Platform.isLinux && !Platform.isWindows) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        const NotificationDetails(
          iOS: DarwinNotificationDetails(),
          android: AndroidNotificationDetails(
            'reminder_channel',
            'Reminder Channel',
            importance: Importance.high,
            priority: Priority.high,
          ),
          macOS: DarwinNotificationDetails(),
          linux: LinuxNotificationDetails(),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }
}
