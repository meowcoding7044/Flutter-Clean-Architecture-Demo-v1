import 'package:first_flutter_v1/core/widgets/internet_exception_widget.dart';
import 'package:first_flutter_v1/features/message/presentation/bloc/bloc.dart';
import 'package:first_flutter_v1/features/message/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/routes_name.dart';
import '../../../../core/di/injection_container.dart';
import '../../../auth/data/services/session_controller.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Use BlocListener to handle side effects like navigation and showing dialogs.
    return BlocListener<MessageBloc, MessageState>(
      // Only listen when the status is failure to avoid unnecessary checks.
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == MessageStatus.failure,
      listener: (context, state) {
        // Check if the error is due to an unauthorized status.
        if (state.errorMessage.contains('Unauthorized') ||
            state.errorMessage.contains('401')) {
          // Perform the logout and navigation.
          _handleUnauthorizedError(context);
        }
      },
      child: BlocBuilder<MessageBloc, MessageState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          switch (state.status) {
            case MessageStatus.loading:
            case MessageStatus.initial:
              return const Center(child: CircularProgressIndicator());

            case MessageStatus.failure:
              // For network errors, show a specific widget.
              if (state.errorMessage.contains('NoInternetException')) {
                return InternetExceptionWidget(
                  onPress: () =>
                      context.read<MessageBloc>().add(MessagesFetch()),
                );
              }
              // For other errors (like Unauthorized), show the message while the listener handles navigation.
              return Center(child: Text(state.errorMessage));

            case MessageStatus.success:
              if (state.messages.isEmpty) {
                return const EmptyStateWidget();
              }
              return RefreshIndicator(
                onRefresh: () async =>
                    context.read<MessageBloc>().add(MessagesFetch()),
                child: ListView.builder(
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    return MessageListItem(message: state.messages[index]);
                  },
                ),
              );
          }
        },
      ),
    );
  }

  // Helper method to keep the listener clean.
  void _handleUnauthorizedError(BuildContext context) async {
    // Clear the session data (token, login status).
    await sl<SessionController>().clearSession();

    // Ensure the widget is still mounted before navigating.
    if (!context.mounted) return;

    // Navigate to the login screen and remove all previous routes.
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.loginScreen,
      (route) => false,
    );

    // Optionally, show a message to the user.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Your session has expired. Please log in again.'),
          backgroundColor: Colors.orange,
        ),
      );
  }
}
