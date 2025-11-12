import 'package:bloc/bloc.dart';
import 'package:first_flutter_v1/features/message/data/repositories/message_repository.dart';
import 'package:first_flutter_v1/features/message/presentation/bloc/message_event.dart';
import 'package:first_flutter_v1/features/message/presentation/bloc/message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;

  MessageBloc({required this.messageRepository}) : super(const MessageState()) {
    on<MessagesFetch>(_fetchMessage);
  }

  Future<void> _fetchMessage(
    MessagesFetch event,
    Emitter<MessageState> emit,
  ) async {
    // Emit loading state
    emit(state.copyWith(status: MessageStatus.loading));
    try {
      final messageModel = await messageRepository.fetchMessages();
      // On success, emit success state with the list of messages
      emit(
        state.copyWith(
          status: MessageStatus.success,
          messages: messageModel.data ?? [],
        ),
      );
    } catch (error) {
      // On failure, emit failure state with the error message
      emit(
        state.copyWith(
          status: MessageStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
