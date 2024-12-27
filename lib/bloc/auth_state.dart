part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  final String uId;

  AuthSuccess({required this.uId}); //userModel in case of complex data
}

final class AuthFailure extends AuthState {
  final String errorMsg;

  AuthFailure({required this.errorMsg});
}

final class AuthLoading extends AuthState {}
