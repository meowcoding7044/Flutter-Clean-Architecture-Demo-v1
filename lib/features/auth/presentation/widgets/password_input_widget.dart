import 'package:first_flutter_v1/features/auth/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({super.key});

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  late final TextEditingController _controller;
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    const initialTestValue = '12345';
    _controller = TextEditingController(text: initialTestValue);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LoginBloc>().add(PasswordChanged(initialTestValue));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStates>(
      listenWhen: (previous, current) => previous.password != current.password,
      listener: (context, state) {
        if (_controller.text != state.password) {
          _controller.text = state.password;
        }
      },
      child: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.text,
        obscureText: _isObscured,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: "Password",
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
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
      ),
    );
  }
}
