import 'package:first_flutter_v1/core/error/failures.dart';
import 'package:first_flutter_v1/features/auth/data/models/user_model.dart';
import 'package:first_flutter_v1/features/auth/data/repositories/login_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginMockApiRepository implements LoginRepository {
  @override
  Future<Either<Failure, UserModel>> loginApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    // To simulate a failure for testing, you could uncomment the line below:
    // return const Left(ServerFailure("Mock server error: Invalid credentials"));

    // Simulate a successful API response
    final response = {
      "accessToken": "mock_access_token_123",
      "refreshToken": "mock_refresh_token_456",
    };

    // When the mock request is successful, return the UserModel wrapped in a 'Right'.
    return Right(UserModel.fromJson(response));
  }
}
