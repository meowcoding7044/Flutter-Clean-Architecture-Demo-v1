import 'package:first_flutter_v1/core/di/injection_container.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/bloc.dart';
import 'package:first_flutter_v1/features/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => sl<LoginBloc>(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const UsernameInputWidget(),
                const SizedBox(height: 20.0),
                const PasswordInputWidget(),
                const SizedBox(height: 40.0),
                LoginButton(formKey: _formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
