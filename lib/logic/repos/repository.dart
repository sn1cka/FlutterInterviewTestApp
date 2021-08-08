import 'dart:io';
import 'dart:math';

import 'package:test_task/logic/models/available_time.dart';
import 'package:test_task/logic/models/calendar_response.dart';

abstract class AppRepository {
  Future<AvailableTime> fetchAvialableTime(DateTime day);

  Future<AvailableDates> fetchAvailableDates();

  Future<String> uploadOrder(
      List<File> images, DateTime dateTime, String description, String address);
}

class FakeAppRepository implements AppRepository {
  @override
  Future<AvailableTime> fetchAvialableTime(DateTime day) async {
    await Future.delayed(Duration(milliseconds: 1700));
    _simulateError();
    return AvailableTime(List.generate(Random().nextInt(8) + 1,
        (index) => day.add(Duration(minutes: 30 * index))));
  }

  @override
  Future<AvailableDates> fetchAvailableDates() async {
    var today = DateTime.now();

    await Future.delayed(Duration(milliseconds: 1700));
    _simulateError();
    return AvailableDates(
        firstDay: today.add(Duration(days: 1)),
        lastDay: today.add(Duration(days: 75)),
        disabledDays:
            List.generate(15, (index) => today.add(Duration(days: index * 5))));
  }

  void _simulateError() {
    if (Random().nextBool()) {
      throw Exception('Симуляция ошибки');
    }
  }

  @override
  Future<String> uploadOrder(List<File> images, DateTime dateTime,
      String description, String address) async {
    await Future.delayed(Duration(milliseconds: 1700));
    return 'OK';
  }
}

class TestRepo implements AppRepository {
  @override
  Future<AvailableTime> fetchAvialableTime(DateTime day) async {
    await Future.delayed(Duration(milliseconds: 1700));
    return AvailableTime(List.generate(Random().nextInt(8) + 1,
        (index) => day.add(Duration(minutes: 30 * index))));
  }

  @override
  Future<AvailableDates> fetchAvailableDates() async {
    var day = DateTime.utc(2021);

    await Future.delayed(Duration(milliseconds: 1700));
    return AvailableDates(
        firstDay: day.add(Duration(days: 1)),
        lastDay: day.add(Duration(days: 75)),
        disabledDays:
            List.generate(15, (index) => day.add(Duration(days: index * 5))));
  }

  @override
  Future<String> uploadOrder(List<File> images, DateTime dateTime,
      String description, String address) async {
    await Future.delayed(Duration(milliseconds: 1700));
    return 'OK';
  }
}
