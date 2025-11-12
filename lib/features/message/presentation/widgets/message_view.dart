import 'package:first_flutter_v1/core/widgets/internet_exception_widget.dart';
import 'package:first_flutter_v1/features/message/presentation/bloc/bloc.dart'; // Barrel file import
import 'package:first_flutter_v1/features/message/presentation/widgets/widgets.dart'; // Barrel file import
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        switch (state.status) {
          case MessageStatus.loading:
          case MessageStatus.initial:
            return const Center(child: CircularProgressIndicator());

          case MessageStatus.failure:
            final isNetworkError = state.errorMessage.contains('NoInternetException');
            if (isNetworkError) {
              return InternetExceptionWidget(
                onPress: () => context.read<MessageBloc>().add(MessagesFetch()),
              );
            }
            return Center(child: Text(state.errorMessage));

          case MessageStatus.success:
            if (state.messages.isEmpty) {
              return const EmptyStateWidget();
            }
            return RefreshIndicator(
              onRefresh: () async => context.read<MessageBloc>().add(MessagesFetch()),
              child: ListView.builder(
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  return MessageListItem(message: state.messages[index]);
                },
              ),
            );
        }
      },
    );
  }
}
