import 'package:bloc_course/models.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();

  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle});
}

class NotesApi implements NotesApiProtocol {
  @override
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle}) {
    final foo = Future.delayed(
      const Duration(seconds: 2),
      () => loginHandle == const LoginHandle.foobar() ? mockNotes : null,
    );

    return foo;
  }
}
