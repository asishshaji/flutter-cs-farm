part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class SignInEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AppLoadingEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignOutEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetCurrentUser extends AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
