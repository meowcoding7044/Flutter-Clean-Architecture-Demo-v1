import 'package:first_flutter_v1/features/auth/presentation/bloc/login_bloc.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/login_event.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/login_states.dart';
import 'package:first_flutter_v1/core/config/routes_name.dart';
import 'package:first_flutter_v1/core/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:first_flutter_v1/core/utils/enums.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginButton({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStates>(
      listenWhen: (current, previous) =>
          current.postApiStatus != previous.postApiStatus,
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.error) {
          FlushBarHelper.flushBarErrorMessage(
            state.message.toString(),
            context,
          );
        }
        if (state.postApiStatus == PostApiStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.homeScreen,
            (route) => false,
          );
          FlushBarHelper.flushBarSuccessMessage(
            state.message.toString(),
            context,
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginStates>(
        buildWhen: (current, previous) =>
            current.postApiStatus != previous.postApiStatus,
        builder: (context, state) {
          if (state.postApiStatus == PostApiStatus.loading) {
            return const CircularProgressIndicator();
          }
          return ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginApi());
              }
            },
            child: const Text("Login"),
          );
        },
      ),
    );
  }
}
