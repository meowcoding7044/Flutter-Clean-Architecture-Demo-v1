import 'package:first_flutter_v1/features/auth/data/models/user_model.dart';
import 'package:first_flutter_v1/features/auth/data/repositories/login_repository.dart';

class LoginMockApiRepository implements LoginRepository {
  @override
  Future<UserModel> loginApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 3));
    final response = {
      "accessToken": "accessToken",
      "refreshToken": "refreshToken",
    };
    return UserModel.fromJson(response);
  }
}
