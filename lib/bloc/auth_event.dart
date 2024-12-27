part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginrequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginrequested({required this.email, required this.password});
}

final class AuthLogoutRequested extends AuthEvent {}
