import 'package:bloc/bloc.dart';
import 'package:first_flutter_v1/features/message/data/repositories/message_repository.dart';
import 'package:first_flutter_v1/features/message/presentation/bloc/bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;

  MessageBloc({required this.messageRepository}) : super(const MessageState()) {
    on<MessagesFetch>(_fetchMessage);
  }

  Future<void> _fetchMessage(
    MessagesFetch event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(status: MessageStatus.loading));

    final result = await messageRepository.fetchMessages();

    result.fold(
      (failure) => emit(state.copyWith(
        status: MessageStatus.failure,
        errorMessage: failure.message,
      )),
      (messageModel) => emit(state.copyWith(
        status: MessageStatus.success,
        messages: messageModel.data ?? [],
      )),
    );
  }
}
