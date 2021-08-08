import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LineComponent extends StatelessWidget {
  const LineComponent(
      {Key? key,
        required this.primaryIcon,
        required this.child,
        required this.secondaryIcon})
      : super(key: key);

  final Widget  secondaryIcon;
  final Widget primaryIcon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            SizedBox(width: 24.w, height: 24.w, child: primaryIcon),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(19.w),
                child: child,
              ),
            ),
            SizedBox(width: 24.w, height: 24.w, child: secondaryIcon),
          ],
        ),
      ),
    );
  }
}
