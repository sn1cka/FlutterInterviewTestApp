import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/logic/repos/repository.dart';
import 'package:test_task/ui/screens/order_screen.dart';
import 'package:test_task/ui/utils/colors.dart';

import 'logic/blocs/book_bloc/order_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('ru', ''),
          ],
          title: 'Sn1cKa Flutter test app ',
          theme: ThemeData(
            accentColor: AppColors.acPrimary,
            primarySwatch: Colors.blue,
          ),
          home: BlocProvider(
            create: (context) => OrderBloc(FakeAppRepository()),
            child: OrderScreen(),
          )),
    );
  }
}
