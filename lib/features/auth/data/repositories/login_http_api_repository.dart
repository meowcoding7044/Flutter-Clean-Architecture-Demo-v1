import 'package:first_flutter_v1/features/auth/data/models/user_model.dart';
import 'package:first_flutter_v1/features/auth/data/repositories/login_repository.dart';

import '../../../../core/config/app_url.dart';
import '../../../../core/network/networkservice/network_services_api.dart';

class LoginHttpApiRepository implements LoginRepository {
  final NetworkServicesApi _api;

  LoginHttpApiRepository({required NetworkServicesApi api}) : _api = api;

  @override
  Future<UserModel> loginApi(dynamic data) async {
    final response = await _api.postApi(AppUrl.loginApi, data);
    return UserModel.fromJson(response);
  }
}
