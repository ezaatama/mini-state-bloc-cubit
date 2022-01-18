part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends AuthEvent{}

class LoginButtonPressed extends AuthEvent{
  final String? username;
  final String? password;

  LoginButtonPressed({
    this.username,
    this.password
  });

}