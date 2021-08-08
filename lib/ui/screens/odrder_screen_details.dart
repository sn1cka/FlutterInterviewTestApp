import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:test_task/logic/blocs/book_details/details_bloc.dart';
import 'package:test_task/ui/components/app_button_component.dart';
import 'package:test_task/ui/components/image_carousel_component.dart';
import 'package:test_task/ui/components/line_component.dart';
import 'package:test_task/ui/utils/colors.dart';

import 'final_screen.dart';

class OrderScreenDetails extends StatefulWidget {
  const OrderScreenDetails({Key? key, required this.dateTime})
      : super(key: key);
  final DateTime dateTime;

  @override
  _OrderScreenDetailsState createState() => _OrderScreenDetailsState();
}

class _OrderScreenDetailsState extends State<OrderScreenDetails> {
  var _images = <File>[];
  final _dateFormatter = DateFormat('dd MMM yyyy г.', 'ru_RUS');
  final _timeFormatter = DateFormat('HH:mm', 'ru_RUS');
  var _address = '';
  var _description = '';
  final _bloc = DetailsBloc();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer(
          bloc: _bloc,
          buildWhen: (previous, current) {
            return !(current is DetailsUpdatedDescription) &&
                !(current is DetailUpdatedAddress);
          },
          listener: (context, state){
            if (state is DetailsUploadedState) {
              _navigateToFinalScreen();
            }
            if (state is DetailsUpdatedDescription) {
              _description = state.description;
            }
            if (state is DetailUpdatedAddress) {
              _address = state.address;
            }
            if (state is DetailsImageAddedState) {
              _images.add(state.image);
            }
          },
          builder: (context, state) => SingleChildScrollView(
              child: Column(
                children: [
                  AppBar(
                    title: Text(
                      'Обзор вашего заказа',
                      style: TextStyle(color: AppColors.elPrimary),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    iconTheme: IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                  ),
                  ImageCarouselComponent(
                    images: _images,
                    onImageAdded: (addedImage) {
                      _addEvent(DetailsAddImageEvent(addedImage));
                    },
                  ),
                  LineComponent(
                    primaryIcon: Image.asset('assets/pen_ic.png'),
                    child: TextField(
                      onChanged: (value) =>
                          _addEvent(DetailsUpdateDescriptionEvent(value)),
                      controller: TextEditingController(text: _description),
                      minLines: 2,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Добавьте краткое описание',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                    secondaryIcon: Icon(Icons.chevron_right),
                  ),
                  Divider(),
                  LineComponent(
                    primaryIcon: Image.asset('assets/pin.png'),
                    child: Container(
                      child: TextField(
                        onChanged: (value) =>
                            _addEvent(DetailsUpdateAddressEvent(value)),
                        controller: TextEditingController(text: _address),
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: 'Адрес',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    secondaryIcon: Image.asset('assets/edit.png'),
                  ),
                  Divider(),
                  LineComponent(
                    primaryIcon: Image.asset('assets/calendar.png'),
                    child: Text(_dateFormatter.format(widget.dateTime)),
                    secondaryIcon: Image.asset('assets/edit.png'),
                  ),
                  LineComponent(
                    primaryIcon: Image.asset('assets/clock.png'),
                    child: Text(_timeFormatter.format(widget.dateTime)),
                    secondaryIcon: Container(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        AppButton(
                          onPress: () {
                            _addEvent(DetailsConfirmOrderEvent(_images,
                                _description, _address, widget.dateTime));
                          },
                          text: 'Далее',
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        AppButton(
                          onPress: () {
                            Navigator.of(context).pop();
                          },
                          isLeadingButton: false,
                          text: 'Отмена',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }

  void _addEvent(DetailsEvent event) {
    _bloc.add(event);
  }

  void _navigateToFinalScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FinalScreen(),
    ));
  }
}
