import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial());

  @override
  void onTransition(Transition<DetailsEvent, DetailsState> transition) {
    super.onTransition(transition);
    print(transition.toString());
  }

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event,) async* {
    if (event is DetailsUpdateDescriptionEvent) {
      yield DetailsUpdatedDescription(event.description);
    }
    if (event is DetailsAddImageEvent) {
      yield DetailsImageAdding();
      yield DetailsImageAddedState(event.image);
    }
    if (event is DetailsUpdateAddressEvent) {
      yield DetailUpdatedAddress(event.address);
    }
    if (event is DetailsConfirmOrderEvent) {
      yield DetailsUploadedState();
    }
  }
}
