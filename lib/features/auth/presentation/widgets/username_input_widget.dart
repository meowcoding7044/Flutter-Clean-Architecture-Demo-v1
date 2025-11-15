import 'package:first_flutter_v1/core/utils/extensions/validations_extension.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameInputWidget extends StatefulWidget {
  const UsernameInputWidget({super.key});

  @override
  State<UsernameInputWidget> createState() => _UsernameInputWidgetState();
}

class _UsernameInputWidgetState extends State<UsernameInputWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    const initialTestValue = 'next@gmail.com';
    _controller = TextEditingController(text: initialTestValue);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LoginBloc>().add(EmailChanged(initialTestValue));
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
    // Use BlocListener to handle side effects like updating a controller,
    // which should not be done inside the build method.
    return BlocListener<LoginBloc, LoginStates>(
      // Listen only when the email state changes.
      listenWhen: (previous, current) => previous.email != current.email,
      listener: (context, state) {
        // Safely update the controller's text if it doesn't match the state.
        if (_controller.text != state.email) {
          _controller.text = state.email;
        }
      },
      // BlocBuilder is now only responsible for building the UI.
      child: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.emailAddress,
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
      ),
    );
  }
}
