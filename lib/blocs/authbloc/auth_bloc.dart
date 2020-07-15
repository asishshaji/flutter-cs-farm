import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f2k/repos/UserRepo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({@required UserRepository userRepository})
      : _userRepository = userRepository,
        super(Unauthenticated());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppLoadingEvent) {
      FirebaseUser currentUser = await _userRepository.currentUser();
      if (currentUser != null) {
        yield Authenticated(user: currentUser);
      }
    } else if (event is SignInEvent) {
      FirebaseUser currentUser = await _userRepository.currentUser();
      if (currentUser != null) {
        yield AuthenticationFailure(errorMessage: "Already Signed in");
      } else {
        FirebaseUser _user = await _userRepository.signInUsingGoogle();
        yield Authenticated(user: _user);
      }
    } else if (event is SignOutEvent) {
      await _userRepository.signOut();
      yield Unauthenticated();
    } else if (event is GetCurrentUser) {
      FirebaseUser _user = await _userRepository.currentUser();
      yield Authenticated(user: _user);
    }
  }
}
