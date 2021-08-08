part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderFetchingDatesState extends OrderState {}

class OrderFetchedDatesState extends OrderState {
  OrderFetchedDatesState(this.dateList);

  final AvailableDates dateList;

  @override
  List<Object?> get props => [dateList];
}

class OrderFetchingDateErrorState extends OrderState {
  OrderFetchingDateErrorState(this.exception);

  final dynamic exception;

  @override
  List<Object?> get props => [exception];
}

class OrderFetchingTimeState extends OrderState {
  OrderFetchingTimeState(this.day);
  final DateTime day;


  @override
  List<Object?> get props => [day];
}

class OrderFetchedTimeState extends OrderState {
  OrderFetchedTimeState(this.timeList);

  final AvailableTime timeList;

  @override
  List<Object?> get props => [timeList];
}


class OrderConfirmedState extends OrderState {
  OrderConfirmedState(this.dateTime);

  final DateTime dateTime;

  @override
  List<Object?> get props => [dateTime];
}

class OrderFetchingTimeErrorState extends OrderState {
  OrderFetchingTimeErrorState(this.exception);

  final dynamic exception;

  @override
  List<Object?> get props => [exception];
}
