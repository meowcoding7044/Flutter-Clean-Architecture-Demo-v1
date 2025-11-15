import 'package:first_flutter_v1/core/config/app_url.dart';
import 'package:first_flutter_v1/core/error/failures.dart';
import 'package:first_flutter_v1/core/network/networkservice/network_services_api.dart';
import 'package:first_flutter_v1/features/message/data/models/message_model.dart';
import 'package:first_flutter_v1/features/message/data/repositories/message_repository.dart';
import 'package:fpdart/fpdart.dart';

class MessageHttpApiRepository implements MessageRepository {
  final NetworkServicesApi _apiService;

  MessageHttpApiRepository({required NetworkServicesApi apiService})
      : _apiService = apiService;

  @override
  Future<Either<Failure, MessageModel>> fetchMessages() async {
    try {
      final response = await _apiService.getApi(AppUrl.messagesGetApi);
      final messageModel = MessageModel.fromJson(response);
      return Right(messageModel);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
