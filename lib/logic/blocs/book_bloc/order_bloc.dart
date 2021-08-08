import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_task/logic/models/available_time.dart';
import 'package:test_task/logic/models/calendar_response.dart';
import 'package:test_task/logic/repos/repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this.repo) : super(OrderInitial());
  AppRepository repo;

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is OrderFetchDatesEvent) {
      try {
        yield OrderFetchingDatesState();
        var result = await repo.fetchAvailableDates();
        yield OrderFetchedDatesState(result);
      } catch (e, stack) {
        debugPrintStack(stackTrace: stack, label: 'OrderBloc exception');
        yield OrderFetchingDateErrorState(e);
      }
    }

    if (event is OrderFetchTimeEvent) {
      try {
        yield OrderFetchingTimeState(event.day);
        var result = await repo.fetchAvialableTime(event.day);
        yield OrderFetchedTimeState(result);
      } catch (e, stack) {
        debugPrintStack(stackTrace: stack, label: 'OrderBloc exception');
        yield OrderFetchingTimeErrorState(e);
      }
    }

    if(event is OrderConfirmEvent){
      yield OrderConfirmedState(event.dateTime);
    }
  }

  @override
  void onTransition(Transition<OrderEvent, OrderState> transition) {
    super.onTransition(transition);
    print(transition.toString());
  }
}
