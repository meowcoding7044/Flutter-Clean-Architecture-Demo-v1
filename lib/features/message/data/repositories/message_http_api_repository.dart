import 'package:first_flutter_v1/core/config/app_url.dart';

import 'package:first_flutter_v1/features/message/data/models/message_model.dart';
import 'package:first_flutter_v1/features/message/data/repositories/message_repository.dart';

import '../../../../core/network/networkservice/network_services_api.dart';

class MessageHttpApiRepository implements MessageRepository {
  final NetworkServicesApi _apiService;

  MessageHttpApiRepository({required NetworkServicesApi apiService})
    : _apiService = apiService;

  @override
  Future<MessageModel> fetchMessages() async {
    final response = await _apiService.getApi(AppUrl.messagesGetApi);
    return MessageModel.fromJson(response);
  }
}
