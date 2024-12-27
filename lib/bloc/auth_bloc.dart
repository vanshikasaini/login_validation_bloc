import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginrequested>(_authLoginRequested);

    on<AuthLogoutRequested>(_authLogoutRequested);
  }
  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    debugPrint("On Change AuthBloc => $change");
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    // can check on which event we get that state change
    super.onTransition(transition);
    debugPrint("On Transition occur  AuthBloc => $transition");
  }

  void _authLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2), () {
        return emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure(errorMsg: e.toString()));
    }
  }

  void _authLoginRequested(
      AuthLoginrequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final email = event.email;
      final password = event.password;
      // email validation using regx
      if (password.length < 6) {
        return emit(
            AuthFailure(errorMsg: 'password cannot be less than 6 characters'));
      }

      await Future.delayed(const Duration(seconds: 2), () {
        return emit(AuthSuccess(uId: '$email-$password'));
      });
    } catch (e) {
      return emit(AuthFailure(errorMsg: e.toString()));
    }
  }
}
