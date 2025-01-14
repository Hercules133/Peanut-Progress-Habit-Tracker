import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/utils/get_greeting.dart';
import 'package:clock/clock.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/data/providers/locale_provider.dart';
import 'package:peanutprogress/data/providers/username_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    setupLocator();
  });

  testWidgets('getGreeting returns correct greeting for morning',
      (WidgetTester tester) async {
    Clock mockClock = Clock.fixed(DateTime(2025, 01, 6, 7));
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UsernameProvider>(
            create: (context) => UsernameProvider(),
          ),
          ChangeNotifierProvider<HabitProvider>(
            create: (_) => locator<HabitProvider>(),
          ),
          ChangeNotifierProvider<CategoryProvider>.value(
            value: locator<CategoryProvider>(),
          ),
          ChangeNotifierProvider<LocaleProvider>(
            create: (_) => LocaleProvider(),
          ),
        ],
        child: MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: const Locale('en'),
          home: Builder(
            builder: (context) {
              // final greeting = getGreeting(context);
              withClock(mockClock, () {
                expect(getGreeting(context), 'Good Morning !');
              });
              return Placeholder();
            },
          ),
        ),
      ),
    );
  });

  testWidgets('getGreeting returns correct greeting for afternoon',
      (WidgetTester tester) async {
    Clock mockClock = Clock.fixed(DateTime(2025, 01, 6, 14));
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UsernameProvider>(
            create: (context) => UsernameProvider(),
          ),
          ChangeNotifierProvider<HabitProvider>(
            create: (_) => locator<HabitProvider>(),
          ),
          ChangeNotifierProvider<CategoryProvider>.value(
            value: locator<CategoryProvider>(),
          ),
          ChangeNotifierProvider<LocaleProvider>(
            create: (_) => LocaleProvider(),
          ),
        ],
        child: MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: const Locale('en'),
          home: Builder(
            builder: (context) {
                          withClock(mockClock, () {
                expect(getGreeting(context), 'Hello !');
              });
              return Placeholder();
            },
          ),
        ),
      ),
    );
  });

 testWidgets('getGreeting returns correct greeting for evening',
      (WidgetTester tester) async {
    Clock mockClock = Clock.fixed(DateTime(2025, 01, 18, 20));
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UsernameProvider>(
            create: (context) => UsernameProvider(),
          ),
          ChangeNotifierProvider<HabitProvider>(
            create: (_) => locator<HabitProvider>(),
          ),
          ChangeNotifierProvider<CategoryProvider>.value(
            value: locator<CategoryProvider>(),
          ),
          ChangeNotifierProvider<LocaleProvider>(
            create: (_) => LocaleProvider(),
          ),
        ],
        child: MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: const Locale('en'),
          home: Builder(
            builder: (context) {
             
              withClock(mockClock, () {
                expect(getGreeting(context), 'Good Evening !');
              });
              return Placeholder();
            },
          ),
        ),
      ),
    );
  });

    testWidgets('getGreeting returns correct greeting for night',
      (WidgetTester tester) async {
    Clock mockClock = Clock.fixed(DateTime(2025, 01, 6, 0, 45));
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UsernameProvider>(
            create: (context) => UsernameProvider(),
          ),
          ChangeNotifierProvider<HabitProvider>(
            create: (_) => locator<HabitProvider>(),
          ),
          ChangeNotifierProvider<CategoryProvider>.value(
            value: locator<CategoryProvider>(),
          ),
          ChangeNotifierProvider<LocaleProvider>(
            create: (_) => LocaleProvider(),
          ),
        ],
        child: MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: const Locale('en'),
          home: Builder(
            builder: (context) {
             
              withClock(mockClock, () {
                expect(getGreeting(context), 'Good Night !');
              });
              return Placeholder();
            },
          ),
        ),
      ),
    );
  });
  //    final context = tester.element(find.byType(MyHomePage));
  // final greeting = getGreeting(context); // getGreeting mit dem richtigen Kontext aufrufen

  // // Testen, ob die Begrüßung "Good Morning" zurückgegeben wird
  // expect(greeting, "Good Morning testname!");

//  test('getGreeting returns correct greeting for afternoon', (){
//  final mockClock = Clock.fixed(DateTime(2025, 01, 01, 13));

//     withClock(mockClock, () {
//       expect(getGreeting(), 'Hello!');
//     });
//  });

//  test('getGreeting returns correct greeting for evening', (){
//  final mockClock = Clock.fixed(DateTime(2025, 01, 01, 20));

//     withClock(mockClock, () {
//       expect(getGreeting(), 'Good Evening!');
// });
//  });

//   test('getGreeting returns correct greeting for night', (){
//  final mockClock = Clock.fixed(DateTime(2025, 01, 01, 05));

//     withClock(mockClock, () {
//       expect(getGreeting(), 'Good Night!');
//     });
//  });
}
