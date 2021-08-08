import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:test_task/ui/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableTimeComponent extends StatefulWidget {
  const AvailableTimeComponent(
      {Key? key, this.timeList = const [], required this.onSelectedTimeChanged})
      : super(key: key);

  final Function(DateTime) onSelectedTimeChanged;
  final List<DateTime> timeList;

  @override
  _AvailableTimeComponentState createState() => _AvailableTimeComponentState();
}

class _AvailableTimeComponentState extends State<AvailableTimeComponent> {
  final _dtf = DateFormat('HH:mm');
  DateTime? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Доступное время',
            ),
          ),
          Wrap(
              children: widget.timeList.map((e) {
            var isSelected = _selectedTime != null ? _selectedTime == e : false;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  widget.onSelectedTimeChanged(e);
                  setState(() {
                    _selectedTime = e;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  color: isSelected ? AppColors.acPrimary : AppColors.bgPrimary,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 22),
                    child: Text(
                      _dtf.format(e),
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
