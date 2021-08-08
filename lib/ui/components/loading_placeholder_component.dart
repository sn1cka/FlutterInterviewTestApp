import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_task/ui/utils/colors.dart';

class LoadingPlaceHolder extends StatelessWidget {
  const LoadingPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(
            color: AppColors.acPrimary,
          ),
        ),
      ),
    );
  }
}
