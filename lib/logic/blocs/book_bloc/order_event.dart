part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  List<Object?> get props => [];
}

class OrderFetchTimeEvent extends OrderEvent {
  OrderFetchTimeEvent(this.day);

  final DateTime day;

  @override
  List<Object?> get props => [day];
}

class OrderFetchDatesEvent extends OrderEvent {}

class OrderConfirmEvent extends OrderEvent {
  OrderConfirmEvent(this.dateTime);

  final DateTime dateTime;

  @override
  List<Object?> get props => [dateTime];

}
