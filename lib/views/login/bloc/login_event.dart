part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}
class ServicesInitEvent extends LoginEvent{

  @override
  List<Object?> get props => [];
}

class LoginButtonEvent extends LoginEvent{
  final String username;
  final String pass;
  const LoginButtonEvent(this.username, this.pass);

  @override
  List<Object?> get props => [username, pass];
}

class SignUpButtonEvent extends LoginEvent{
  final String username;
  final String pass;
  const SignUpButtonEvent(this.username, this.pass);

  @override
  List<Object?> get props => [username, pass];
}
