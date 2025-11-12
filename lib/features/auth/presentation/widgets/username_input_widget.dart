import 'package:first_flutter_v1/core/utils/extensions/validations_extension.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/login_bloc.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/login_event.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameInputWidget extends StatelessWidget {
  const UsernameInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          // Improved UX: Validate only after the user interacts with the field.
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: "Username or Email",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChanged(value));
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter username";
            }
            if (!value.emailValidator()) {
              return 'Email format is not correct';
            }
            return null;
          },
        );
      },
    );
  }
}
