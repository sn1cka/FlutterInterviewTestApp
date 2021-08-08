import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task/logic/blocs/book_bloc/order_bloc.dart';
import 'package:test_task/logic/blocs/book_details/details_bloc.dart';
import 'package:test_task/logic/models/calendar_response.dart';
import 'package:test_task/logic/repos/repository.dart';


void main() {
  group('OrderBloc test', () {
    late OrderBloc orderBloc;
    late DetailsBloc detailsBloc;
    late AppRepository mockRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      mockRepo = TestRepo();
      orderBloc = OrderBloc(mockRepo);
      detailsBloc = DetailsBloc();
    });

    blocTest<OrderBloc, OrderState>(
      'emits fetching dates and checking queue of states',
      build: () => orderBloc,
      act: (bloc) => bloc.add(OrderFetchDatesEvent()),
      expect: () {
        var day = DateTime.utc(2021);
        return [
          OrderFetchingDatesState(),
          OrderFetchedDatesState(AvailableDates(
              firstDay: day.add(Duration(days: 1)),
              lastDay: day.add(Duration(days: 75)),
              disabledDays: List.generate(
                  15, (index) => day.add(Duration(days: index * 5))))),
        ];
      },
    );

    blocTest<DetailsBloc, DetailsState>(
      'emits fetching dates and checking queue of states',
      build: () => detailsBloc,
      act: (bloc) => bloc.add(DetailsUpdateAddressEvent('Generating new test address')),
      expect: () => [DetailUpdatedAddress('Generating new test address')],
    );

    tearDown(() {
      orderBloc.close();
    });
  });
}
