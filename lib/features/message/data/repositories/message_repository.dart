import 'package:first_flutter_v1/core/error/failures.dart';
import 'package:first_flutter_v1/features/message/data/models/message_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class MessageRepository {
  Future<Either<Failure, MessageModel>> fetchMessages();
}
