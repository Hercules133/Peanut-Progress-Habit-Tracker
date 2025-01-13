/// Returns a greeting message based on the current time.
///
/// The greeting depends on the current time:
/// . between 6 AM and 12 PM: 'Good Morning!'
/// - between 12 PM and 6 PM: 'Hello!'
/// - between 6 PM and 10 PM: 'Good Evening!'
/// - between 10 PM and 6 AM: 'Good Night!'
///
/// Returns a [String] with the greeting message.
String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour >= 6 && hour < 12) {
    return 'Good Morning!';
  } else if (hour >= 12 && hour < 18) {
    return 'Hello!';
  } else if (hour >= 18 && hour < 22) {
    return 'Good Evening!';
  } else {
    return 'Good Night!';
  }
}
