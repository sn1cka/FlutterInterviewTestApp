import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/ui/utils/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      required this.onPress,
      this.isLeadingButton = true,
      this.text = ''})
      : super(key: key);

  final VoidCallback? onPress;
  final bool isLeadingButton;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 40.h,
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.w),
                side: BorderSide(
                    color:
                        isLeadingButton ? Colors.transparent : Colors.grey))),
            backgroundColor: MaterialStateProperty.all(
                isLeadingButton ? AppColors.acPrimary : Colors.transparent)),
        onPressed: onPress,
        child: Container(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: isLeadingButton ? Colors.white : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
