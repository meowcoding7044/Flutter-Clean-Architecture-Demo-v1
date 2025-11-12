import 'dart:convert';
import 'package:first_flutter_v1/core/storage/local_storage.dart';
import 'package:first_flutter_v1/features/auth/data/models/user_model.dart';

class SessionController {
  static final SessionController _session = SessionController._internal();

  final LocalStorage localStorage = LocalStorage();
  UserModel userModel = UserModel();
  bool? isLogin;

  SessionController._internal() {
    isLogin = false;
  }

  factory SessionController() {
    return _session;
  }

  Future<void> saveUserInPreference(dynamic user) async {
    localStorage.setValue("token", jsonEncode(user));
    localStorage.setValue("isLogin", 'true');
    await getUserFromPreference(); // Update in-memory state right after saving
  }

  Future<void> getUserFromPreference() async {
    try {
      var user = await localStorage.getValue("token");
      var isLoginVal = await localStorage.getValue("isLogin");

      if (user.isNotEmpty) {
        userModel = UserModel.fromJson(jsonDecode(user));
      } else {
        userModel = UserModel(); // Clear in-memory user
      }
      isLogin = isLoginVal == 'true' ? true : false;
    } catch (e) {
      print(e.toString());
      userModel = UserModel(); // Clear on error
      isLogin = false;
    }
  }

  Future<void> clearSession() async {
    await localStorage.removeValue("token");
    await localStorage.removeValue("isLogin");
    userModel = UserModel(); // Clear in-memory user model
    isLogin = false; // Reset login status
  }
}
