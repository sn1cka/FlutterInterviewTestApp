import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_task/ui/utils/colors.dart';

class AppCalendar extends StatefulWidget {
  AppCalendar(
      {Key? key,
      required this.lastDate,
      required this.firstDate,
      required this.selectedDate,
      this.disabledDates = const [],
      this.onSelectedDateChanged})
      : super(key: key);

  final DateTime? selectedDate;
  final DateTime lastDate;
  final DateTime firstDate;
  final List<DateTime> disabledDates;

  final Function(DateTime day)? onSelectedDateChanged;

  @override
  _AppCalendarState createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  late DateTime _focusedDate;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _focusedDate = widget.selectedDate ?? widget.firstDate;
    _selectedDate = widget.selectedDate ?? widget.firstDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        children: [
          _buildCalendarHeader(),
          _buildCalendar(),
        ],
      ),
    );
  }

  Row _buildCalendarHeader() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 3),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              child: Text(
                DateFormat.yMMM('ru_RUS').format(_focusedDate).toUpperCase(),
                style: TextStyle(
                    color: AppColors.elPrimary, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () => setFocusedDateOneMonthBefore(),
            icon: Icon(Icons.chevron_left_outlined)),
        IconButton(
            onPressed: () => setFocusedDateOneMonthAfter(),
            icon: Icon(Icons.chevron_right_outlined))
      ],
    );
  }

  void setFocusedDateOneMonthAfter() {
    var newTime = DateTime(_focusedDate.year, _focusedDate.month + 1);
    setState(() {
      if (newTime.isBefore(widget.lastDate))
        _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1);
      else
        _focusedDate = widget.lastDate;
    });
  }

  void setFocusedDateOneMonthBefore() {
    var newTime = DateTime(_focusedDate.year, _focusedDate.month - 1);
    setState(() {
      if (newTime.isAfter(widget.firstDate))
        _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1);
      else
        _focusedDate = widget.firstDate;
    });
  }

  _buildCalendar() => TableCalendar(
        availableGestures: AvailableGestures.horizontalSwipe,
        locale: 'ru_RUS',
        daysOfWeekStyle: _getDaysOfWeekStyle(),
        calendarStyle: _getCalendarStyle(),
        calendarBuilders: _getBuilders(),
        headerVisible: false,
        daysOfWeekHeight: 48,
        rowHeight: 44,
        firstDay: widget.firstDate,
        lastDay: widget.lastDate,
        focusedDay: _focusedDate,
        selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
        onDaySelected: (selectedDay, focusedDay) {
          if (!_isDayDisabled(selectedDay)) {
            if (widget.onSelectedDateChanged != null) {
              _selectedDate = selectedDay;
              widget.onSelectedDateChanged!(_selectedDate);
            }
          }
          setState(() {});
        },
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDate = focusedDay;
          });
        },
      );

  _getCalendarStyle() => CalendarStyle(
        outsideDaysVisible: false,
        disabledTextStyle: TextStyle(fontWeight: FontWeight.bold, color: AppColors.elSecondary),
        markerMargin: EdgeInsets.zero,
        cellMargin: EdgeInsets.all(5),
        isTodayHighlighted: false,
        selectedTextStyle:
            TextStyle(color: AppColors.elPrimary, fontWeight: FontWeight.bold),
        selectedDecoration: BoxDecoration(
          color: AppColors.bgTertiary,
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(color: AppColors.acPrimary),
        ),
      );

  _getDaysOfWeekStyle() => DaysOfWeekStyle(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.dividerColor))));

  _getBuilders() => CalendarBuilders(
        dowBuilder: (context, day) {
          var formattedDay = DateFormat('EEE', 'ru_RUS').format(day);
          formattedDay =
              formattedDay[0].toUpperCase() + formattedDay.substring(1);
          return Center(
              child: Text(
            formattedDay,
            style: TextStyle(color: AppColors.elSecondary,
                fontWeight: FontWeight.bold),
          ));
        },
        defaultBuilder: (context, day, focusedDay) {
          if (_isDayDisabled(day)) {
            return _getDisabledDate(day);
          } else
            return Center(
                child: Text(
              day.day.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
        },
      );

  bool _isDayDisabled(DateTime day) {
    for (var disabledDate in widget.disabledDates) {
      if (isSameDay(day, disabledDate)) {
        return true;
      }
    }
    return false;
  }

  _getDisabledDate(DateTime day) => Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Center(
              child: Text(
                day.day.toString(),
                style: TextStyle(
                    color: AppColors.elSecondary, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Transform.rotate(
                angle: pi / -4,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Divider(
                    thickness: 1.w,
                    color: AppColors.elSecondary,
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
