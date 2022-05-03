import 'package:bloc/bloc.dart';
import 'package:bloc_course/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'bloc_actions.dart';

extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) {
    return length == other.length &&
        {...this}.intersection({...other}).length == length;
  }
}

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonsAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        final _cachedPersons = _cache[url]!;
        final result = FetchResult(
          persons: _cachedPersons,
          isRetrivedFromCache: true,
        );

        emit(result);
      } else {
        final loader = event.personLoader;
        final persons = await loader(url);
        _cache[url] = persons;

        final result = FetchResult(
          persons: persons,
          isRetrivedFromCache: false,
        );

        emit(result);
      }
    });
  }
}

//BLOC OUTPUT

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrivedFromCache;

  const FetchResult({
    required this.persons,
    required this.isRetrivedFromCache,
  });

  @override
  String toString() =>
      'FetchResult (isRetrivedFromCache $isRetrivedFromCache, person = $persons)';

  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEqualToIgnoringOrdering(other.persons) &&
      isRetrivedFromCache == other.isRetrivedFromCache;

  @override
  int get hashCode => Object.hash(
        persons,
        isRetrivedFromCache,
      );
}
