import 'package:equatable/equatable.dart';
import 'package:first_flutter_v1/core/utils/enums.dart';

// Represents the state of the Login feature.
class LoginStates extends Equatable {
  // The initial state should represent a clean, empty form.
  const LoginStates({
    this.email = '',
    this.password = '',
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String email;
  final String password;
  final String message;
  final PostApiStatus postApiStatus;

  LoginStates copyWith({
    String? email,
    String? password,
    String? message,
    PostApiStatus? postApiStatus,
  }) {
    return LoginStates(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object> get props => [email, password, message, postApiStatus];
}
