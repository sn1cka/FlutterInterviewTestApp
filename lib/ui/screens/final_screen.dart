import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinalScreen extends StatelessWidget {
  const FinalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/success.png'),
              Text('Ваш заказ принят', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp, ),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('В ближайшее время с вами\nсвяжется наш мастер', textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
