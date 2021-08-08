part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailsInitial extends DetailsState {}

class DetailsUploadingState extends DetailsState {}

class DetailsUploadedState extends DetailsState {}

class DetailsUpdatedDescription extends DetailsState {
  DetailsUpdatedDescription(this.description);

  final String description;

  @override
  List<Object?> get props => [description];
}

class DetailUpdatedAddress extends DetailsState {
  DetailUpdatedAddress(this.address);

  final String address;

  @override
  List<Object?> get props => [address];


}


class DetailsImageAdding extends DetailsState {
  @override
  List<Object?> get props => [];
}

class DetailsImageAddedState extends DetailsState {
  final File image;

  DetailsImageAddedState(this.image);

  @override
  List<Object?> get props => [];
}

class DetailsUploadedError extends DetailsState {
  DetailsUploadedError(this.exception);

  final dynamic exception;

  @override
  List<Object?> get props => [exception];
}
