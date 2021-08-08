 abstract class DateTimeFlatter {
  static DateTime flatAfterDay(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day, 0, 0, 0, 0, 0);
  }

  static DateTime flatAfterHours(DateTime time) {
    return DateTime.utc(time.year, time.month, time.day, time.hour, 0, 0, 0, 0);
  }

  static DateTime flatAfterMinutes(DateTime time) {
    return DateTime.utc(time.year, time.month, time.day, time.hour, time.minute, 0, 0, 0);
  }
}
