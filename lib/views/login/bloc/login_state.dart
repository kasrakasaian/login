part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class ServicesInitState extends LoginState {
  @override

  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {
   final String? error;

  const LoginInitialState({this.error});
  @override
  List<Object> get props => [error??''];
}

class SuccessfulLoginState extends LoginState {
  final String username;

  const SuccessfulLoginState(this.username);
  @override
  List<Object?> get props => [username];
}
