import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_snkrs_clone/features/authentication/bloc/authentication_bloc.dart';
import 'package:nike_snkrs_clone/welcome_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nike SNKRS Clone',
      home: BlocNavigate(),
    );
  }
}

class BlocNavigate extends StatelessWidget {
  const BlocNavigate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return Scaffold(
            backgroundColor: Colors.green,
          );
        } else {
          return WelcomeView();
        }
      },
    );
  }
}
