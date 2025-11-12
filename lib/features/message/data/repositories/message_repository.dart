import 'package:first_flutter_v1/features/message/data/models/message_model.dart';

abstract class MessageRepository {
  Future<MessageModel> fetchMessages();
}
