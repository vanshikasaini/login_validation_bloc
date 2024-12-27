import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_validation_bloc/bloc/auth_bloc.dart';
import 'package:login_validation_bloc/login_screen_with_builder_nd_listener.dart';
import 'package:login_validation_bloc/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final authState = context.watch<AuthBloc>().state as AuthSuccess;
          return Column(children: [
            Center(
              child: Text(authState.uId),
            ),
            GradientButton(onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            })
          ]);
        },
      ),
    );
  }
}
