import 'package:bloc/bloc.dart';
import 'package:bloc_course/apis/bloc/actions.dart';
import 'package:bloc_course/apis/bloc/app_states.dart';
import 'package:bloc_course/apis/logins_api.dart';
import 'package:bloc_course/apis/notes_api.dart';
import 'package:bloc_course/models.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesAPi;

  AppBloc({
    required this.loginApi,
    required this.notesAPi,
  }) : super(const AppState.empty()) {
    on<LoginAction>((event, emit) async {
      //start loading
      emit(
        const AppState(
          isLoading: true,
          loginErrors: null,
          loginHandle: null,
          fetchedNotes: null,
        ),
      );

      //log the user in
      final loginHandle =
          await loginApi.login(email: event.email, password: event.password);

      emit(
        AppState(
          isLoading: false,
          loginErrors: loginHandle == null ? LoginErrors.invalidHandle : null,
          loginHandle: loginHandle,
          fetchedNotes: null,
        ),
      );
    });

    on<LoadNotesAction>((event, emit) async {
      emit(
        AppState(
          isLoading: true,
          loginErrors: null,
          loginHandle: state.loginHandle,
          fetchedNotes: null,
        ),
      );

      //get the login handle
      final loginHandle = state.loginHandle;
      if (loginHandle != const LoginHandle.foobar()) {
        //invalid login handle cannot fetch any notes
        emit(
          AppState(
            isLoading: false,
            loginErrors: LoginErrors.invalidHandle,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
        return;
      }

      //we have a valid login handle and want to fetch notes

      final notes = await notesAPi.getNotes(
        loginHandle: loginHandle!,
      );

      emit(
        AppState(
          isLoading: false,
          loginErrors: null,
          loginHandle: loginHandle,
          fetchedNotes: notes,
        ),
      );
    });
  }
}
