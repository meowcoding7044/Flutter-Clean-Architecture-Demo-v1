import 'dart:convert';

import 'package:first_flutter_v1/core/storage/local_storage.dart';
import 'package:first_flutter_v1/features/auth/data/models/user_model.dart';

class SessionController {
  static final SessionController _session = SessionController._internal();

  final LocalStorage localStorage = LocalStorage();
  UserModel userModel = const UserModel(); // Use const constructor
  bool? isLogin;

  SessionController._internal() {
    isLogin = false;
  }

  factory SessionController() {
    return _session;
  }

  Future<void> saveUserInPreference(UserModel user) async {
    // Use the model's toJson method, which is safer.
    localStorage.setValue("token", jsonEncode(user.toJson()));
    localStorage.setValue("isLogin", 'true');
    await getUserFromPreference();
  }

  Future<void> getUserFromPreference() async {
    try {
      var userJson = await localStorage.getValue("token");
      var isLoginVal = await localStorage.getValue("isLogin");

      // Safely check for null or empty string before decoding.
      if (userJson != null && userJson.isNotEmpty) {
        userModel = UserModel.fromJson(jsonDecode(userJson));
      }

      isLogin = isLoginVal == 'true'; // Simplified boolean conversion
    } catch (e) {
      print(e.toString());
      // Ensure state is reset on error
      userModel = const UserModel();
      isLogin = false;
    }
  }

  Future<void> clearSession() async {
    await localStorage.removeValue("token");
    await localStorage.removeValue("isLogin");
    userModel = const UserModel();
    isLogin = false;
  }
}
