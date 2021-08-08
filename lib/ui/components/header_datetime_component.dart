import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:test_task/ui/utils/colors.dart';

class HeaderDateTimeComponent extends StatelessWidget {
  HeaderDateTimeComponent({Key? key, this.dateTime, this.timeEnabled = false})
      : super(key: key);

  final DateTime? dateTime;
  final bool timeEnabled;

  final onlyDateFormat = DateFormat('dd MMM yyyy г.', 'ru_RUS');
  final fullFormat = DateFormat('dd MMM yyyy г. HH:mm', 'ru_RUS');

  @override
  Widget build(BuildContext context) {
    var items = <Widget>[];

    if (dateTime == null) {
      items = [Text('Выбрите дату и время')];
    }
    if (!timeEnabled && dateTime != null) {
      items = [
        Text( onlyDateFormat.format(dateTime!),
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Выбрите время', style: TextStyle(fontWeight: FontWeight.bold))
      ];
    } if (timeEnabled && dateTime != null) {
      items = [
        Text(fullFormat.format(dateTime!),
            style: TextStyle(fontWeight: FontWeight.bold))
      ];
    }

    return Container(
      height: 100.h,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.dividerColor))),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: items,
        ),
      ),
    );
  }
}
