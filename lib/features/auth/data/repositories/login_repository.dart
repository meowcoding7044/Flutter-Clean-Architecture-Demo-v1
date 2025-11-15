import 'package:fpdart/fpdart.dart';
import 'package:first_flutter_v1/core/error/failures.dart';
import 'package:first_flutter_v1/features/auth/data/models/user_model.dart';

// The repository now returns an Either type, which represents a value that can be
// either a Failure or a successful UserModel.
abstract class LoginRepository {
  Future<Either<Failure, UserModel>> loginApi(dynamic data);
}
