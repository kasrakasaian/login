import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/global_enums.dart';
import '../../../services/authentication_service.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService _authService;

  LoginBloc(this._authService)
      : super(ServicesInitState()) {

    /// Load hive objects.
    on<ServicesInitEvent>((event, emit) async {
      await _authService.init();
      emit(const LoginInitialState());
    });

    /// Login button event handler.
    on<LoginButtonEvent>((event, emit) async {
      AuthenticationEnum result =
          await _authService.authenticateUser(event.username, event.pass);

      switch (result) {
        case AuthenticationEnum.registered:
          emit(SuccessfulLoginState(event.username));
          emit(const LoginInitialState());
          break;
        case AuthenticationEnum.notRegistered:
          emit(LoginInitialState(error: 'wrong username or password'));
          break;
        case AuthenticationEnum.connectionError:
          emit(LoginInitialState(error: ' an error occurred.'));
          break;
      }
    });

    /// signup button event handler.
    on<SignUpButtonEvent>((event, emit) async {
      SignUpEnum result =
          await _authService.addUser(event.username, event.pass);
      switch (result) {
        case SignUpEnum.successful:
          emit(SuccessfulLoginState(event.username));
          emit(const LoginInitialState());
          break;
        case SignUpEnum.uniqueUserError:
          emit(LoginInitialState(
              error: 'user with this username is '
                  'already exist'));
          break;
        case SignUpEnum.connectionError:
          emit(LoginInitialState(error: ' an error occurred.'));
          break;
      }
    });
  }
}
