import 'package:first_flutter_v1/core/di/injection_container.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/bloc.dart';
import 'package:first_flutter_v1/features/auth/presentation/widgets/widgets.dart';
import 'package:first_flutter_v1/features/theme/domain/model/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../theme/presentation/bloc/theme_events.dart';
import '../../../theme/presentation/bloc/theme_state.dart';

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
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.themeModel?.themeType == ThemeType.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: () {
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
              );
            },
          ),
        ],
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
