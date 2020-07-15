part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

// show login screen here
class Unauthenticated extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final FirebaseUser user;

  Authenticated({@required this.user});
  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthenticationFailure extends AuthState {
  final String errorMessage;

  AuthenticationFailure({@required this.errorMessage});
  @override
  // TODO: implement props
  List<Object> get props => [errorMessage];
}
