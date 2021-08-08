import 'package:equatable/equatable.dart';

class AvailableDates extends Equatable {
  const AvailableDates(
      {required this.firstDay,
      required this.lastDay,
      this.disabledDays = const []});

  final DateTime firstDay;
  final DateTime lastDay;
  final List<DateTime> disabledDays;

  @override
  List<Object?> get props => [firstDay,lastDay,disabledDays];
}
