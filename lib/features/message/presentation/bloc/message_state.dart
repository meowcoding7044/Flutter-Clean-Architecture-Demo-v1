import 'package:equatable/equatable.dart';
import 'package:first_flutter_v1/features/message/data/models/message_model.dart';

// Enum to represent the specific states of the message feature.
// This is more explicit and clearer than a generic status.
enum MessageStatus { initial, loading, success, failure }

class MessageState extends Equatable {
  const MessageState({
    this.status = MessageStatus.initial,
    this.messages = const <Data>[], // Store the list of messages directly.
    this.errorMessage = '', // Store the error message directly.
  });

  final MessageStatus status;
  final List<Data> messages;
  final String errorMessage;

  // copyWith is updated to handle the new properties.
  MessageState copyWith({
    MessageStatus? status,
    List<Data>? messages,
    String? errorMessage,
  }) {
    return MessageState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, messages, errorMessage];
}
