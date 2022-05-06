import 'package:bloc_course/bloc/bloc_actions.dart';
import 'package:bloc_course/bloc/person.dart';
import 'package:bloc_course/bloc/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPersons1 = [
  Person(
    name: 'Foo',
    age: 20,
  ),
  Person(
    name: 'Bar',
    age: 30,
  )
];

const mockedPersons2 = [
  Person(
    name: 'Foo',
    age: 20,
  ),
  Person(
    name: 'Bar',
    age: 30,
  )
];

Future<Iterable<Person>> mockGetPersons1(String url) =>
    Future.value(mockedPersons1);

Future<Iterable<Person>> mockGetPersons2(String url) =>
    Future.value(mockedPersons2);

void main() {
  group('Testing bloc', () {
    late PersonsBloc bloc;

    setUp(() {
      bloc = PersonsBloc();
    });

    blocTest<PersonsBloc, FetchResult?>(
      'The initial state of the bloc should be null',
      build: () => bloc,
      verify: (bloc) => expect(bloc.state, null),
    );

    blocTest<PersonsBloc, FetchResult?>(
      'Should retrive persons from first iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(
            personLoader: mockGetPersons1,
            url: 'dummy url',
          ),
        );

        bloc.add(
          const LoadPersonsAction(
            personLoader: mockGetPersons1,
            url: 'dummy url',
          ),
        );
      },
      expect: () => [
        const FetchResult(
          persons: mockedPersons1,
          isRetrivedFromCache: false,
        ),
        const FetchResult(
          persons: mockedPersons1,
          isRetrivedFromCache: true,
        ),
      ],
    );

    blocTest<PersonsBloc, FetchResult?>(
      'Should retrive persons from second iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(
            personLoader: mockGetPersons2,
            url: 'dummy url 2',
          ),
        );

        bloc.add(
          const LoadPersonsAction(
            personLoader: mockGetPersons2,
            url: 'dummy url 2',
          ),
        );
      },
      expect: () => [
        const FetchResult(
          persons: mockedPersons2,
          isRetrivedFromCache: false,
        ),
        const FetchResult(
          persons: mockedPersons2,
          isRetrivedFromCache: true,
        ),
      ],
    );
  });
}
