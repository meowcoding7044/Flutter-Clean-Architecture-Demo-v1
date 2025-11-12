import 'package:first_flutter_v1/features/auth/data/models/user_model.dart';

abstract class LoginRepository {
  Future<UserModel> loginApi(dynamic data);
}

