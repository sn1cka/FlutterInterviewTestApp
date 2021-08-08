import 'dart:io';

class CreateOrderRequest {

  const CreateOrderRequest(
      {required this.dateTime,
      this.imageList = const [],
      required this.address,
      this.desription = ''});

  final String desription;

  final String dateTime;

  final List<File> imageList;

  final String address;
}
