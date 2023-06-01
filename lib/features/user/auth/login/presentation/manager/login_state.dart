import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  @override
  List<Object> get props => [];
}

class CheckPhoneError extends LoginState {
  @override
  List<Object> get props => [];
}

class CheckPhoneLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class CheckPhoneSuccess extends LoginState {
  @override
  List<Object> get props => [];
}
