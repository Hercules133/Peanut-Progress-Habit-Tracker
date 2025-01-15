/// Returns a [DateTime] object representing only the date part of the given [date].
///
/// The time part (hour, minute, second, millisecond, microsecond) is set to zero.
///
/// Example:
/// ```dart
/// DateTime fullDate = DateTime.now();
/// DateTime dateOnly = dateOnly(fullDate);
/// print(dateOnly); // Output: YYYY-MM-DD 00:00:00.000
/// ```
DateTime dateOnly(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}
