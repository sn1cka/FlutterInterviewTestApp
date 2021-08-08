part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object?> get props => [];
}

class DetailsUpdateAddressEvent extends DetailsEvent {
  DetailsUpdateAddressEvent(this.address);

  final String address;

  @override
  List<Object?> get props => [address];
}

class DetailsUpdateDescriptionEvent extends DetailsEvent {
  DetailsUpdateDescriptionEvent(this.description);

  final String description;

  @override
  List<Object?> get props => [description];
}

class DetailsAddImageEvent extends DetailsEvent {
  DetailsAddImageEvent(this.image);

  final File image;

  @override
  List<Object?> get props => [image];
}

class DetailsConfirmOrderEvent extends DetailsEvent {
  DetailsConfirmOrderEvent(
      this.images, this.description, this.address, this.dateTime);

  final List<File> images;
  final String description;
  final String address;
  final DateTime dateTime;

  @override
  List<Object?> get props => [images, description, address, dateTime];
}
