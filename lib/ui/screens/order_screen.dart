import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/logic/blocs/book_bloc/order_bloc.dart';
import 'package:test_task/logic/models/available_time.dart';
import 'package:test_task/logic/models/calendar_response.dart';
import 'package:test_task/ui/components/app_button_component.dart';
import 'package:test_task/ui/components/avialable_time_component.dart';
import 'package:test_task/ui/components/calendar_component.dart';
import 'package:test_task/ui/components/header_datetime_component.dart';
import 'package:test_task/ui/components/loading_placeholder_component.dart';
import 'package:test_task/ui/screens/odrder_screen_details.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  DateTime? _selectedDate;
  DateTime? _selectedTime;

  AvailableTime? _availableTime;
  AvailableDates? _availableDates;

  Widget? _calendar;
  Widget? _timePicker;

  void _navigateToDetails() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => OrderScreenDetails(dateTime: _selectedTime!,),
    ));
  }

  @override
  void initState() {
    super.initState();
    _addEvent(OrderFetchDatesEvent());
  }

  void _addEvent(OrderEvent event) {
    BlocProvider.of<OrderBloc>(context).add(event);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocConsumer(
        bloc: BlocProvider.of<OrderBloc>(context),
        listener: (context, state) {
          if (state is OrderFetchingTimeState) {
            _selectedDate = state.day;
            _selectedTime = null;
          }

          if (state is OrderFetchedDatesState) {
            _availableDates = state.dateList;
            _selectedDate = _availableDates!.firstDay;
            _selectedTime = null;
          }

          if (state is OrderFetchedTimeState) {
            _availableTime = state.timeList;
            _selectedTime = null;
          }

          if (state is OrderConfirmedState) {
            _selectedTime = state.dateTime;
            _selectedDate = state.dateTime;
          }
        },
        builder: (context, state) {
          var items = <Widget>[];

          if (state is OrderFetchingDatesState) {
            _calendar = LoadingPlaceHolder();
          }

          if (state is OrderFetchedDatesState) {
            _calendar = AppCalendar(
                selectedDate: _selectedDate,
                onSelectedDateChanged: (day) =>
                    _addEvent(OrderFetchTimeEvent(day)),
                firstDate: _availableDates!.firstDay,
                disabledDates: _availableDates!.disabledDays,
                lastDate: _availableDates!.lastDay);
          }
          if (state is OrderFetchingDateErrorState) {
            _calendar = AppButton(
              text: 'Повторить',
              onPress: () {
                _addEvent(OrderFetchDatesEvent());
              },
            );
          }

          if (state is OrderFetchingTimeState) {
            _timePicker = LoadingPlaceHolder();
          }
          if (state is OrderFetchedTimeState) {
            _timePicker = AvailableTimeComponent(
                onSelectedTimeChanged: (dateTime) =>
                    _addEvent(OrderConfirmEvent(dateTime)),
                timeList: _availableTime!.availableTimeList);
          }
          if (state is OrderFetchingTimeErrorState) {
            _timePicker = AppButton(
              text: 'Повторить',
              onPress: () {
                _addEvent(OrderFetchTimeEvent(_selectedDate!));
              },
            );
          }

          items.add(
            HeaderDateTimeComponent(
              dateTime: _selectedDate,
              timeEnabled: _selectedTime != null,
            ),
          );

          if (_calendar != null) {
            items.add(Padding(
              padding: EdgeInsets.all(16.w),
              child: _calendar!,
            ));
          }
          if (_timePicker != null) {
            items.add(Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _timePicker!));
          }
          if (_selectedTime != null) {
            items.add(Focus(
                child: Padding(
              padding: EdgeInsets.all(16.w),
              child: AppButton(onPress: _navigateToDetails, text: 'Далее'),
            )));
          }

          return SingleChildScrollView(
            child: Column(
              children: items,
            ),
          );
        },
      )),
    );
  }
}
