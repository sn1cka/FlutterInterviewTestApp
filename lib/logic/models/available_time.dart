import 'package:test_task/utils/date_util.dart';

class AvailableTime {
  AvailableTime(List<DateTime> avialableTimeList)
      : this.availableTimeList = avialableTimeList
            .map((e) => DateTimeFlatter.flatAfterMinutes(e))
            .toList();

  final List<DateTime> availableTimeList;
}
