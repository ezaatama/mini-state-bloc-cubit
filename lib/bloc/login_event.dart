part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginEvent{}

class LoginUsernameChanged extends LoginEvent{
  final String? username;

  LoginUsernameChanged({this.username});
}

class LoginPasswordChanged extends LoginEvent{
  final String? password;

  LoginPasswordChanged({this.password});
}

class LoggedIn extends LoginEvent{
   final String? username;
  final String? password;

  LoggedIn({
    this.username,
    this.password
  });
}

class LoggedOut extends LoginEvent{}

