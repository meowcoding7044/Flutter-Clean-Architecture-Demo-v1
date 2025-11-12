import 'package:first_flutter_v1/features/auth/presentation/bloc/login_bloc.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/login_event.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({super.key});

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool _isObscured = true; // State to manage password visibility

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          obscureText: _isObscured, // Use the state variable
          autovalidateMode: AutovalidateMode.onUserInteraction, // Improved UX
          decoration: InputDecoration(
            hintText: "Password",
            border: const OutlineInputBorder(),
            // Add the show/hide password icon button
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(value));
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter password";
            }
            if (value.length < 3) {
              return 'Password must be at least 3 characters';
            }
            return null;
          },
        );
      },
    );
  }
}
