import 'package:bloc_course/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

const person1 = 'http://192.168.204.156:5500/api/persons1.json';
const person2 = 'http://192.168.204.156:5500/api/persons2.json';

typedef PersonLoader = Future<Iterable<Person>> Function(String url);

//BLOC INPUT
@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonLoader personLoader;

  const LoadPersonsAction({
    required this.personLoader,
    required this.url,
  }) : super();
}
