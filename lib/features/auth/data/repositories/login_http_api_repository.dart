import 'package:first_flutter_v1/core/error/failures.dart';
import 'package:first_flutter_v1/core/network/exceptions/app_exceptions.dart';
import 'package:first_flutter_v1/features/auth/data/models/user_model.dart';
import 'package:first_flutter_v1/features/auth/data/repositories/login_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/config/app_url.dart';
import '../../../../core/network/networkservice/network_services_api.dart';

class LoginHttpApiRepository implements LoginRepository {
  final NetworkServicesApi _api;

  LoginHttpApiRepository({required NetworkServicesApi api}) : _api = api;

  @override
  Future<Either<Failure, UserModel>> loginApi(dynamic data) async {
    try {
      final response = await _api.postApi(AppUrl.loginApi, data);
      final userModel = UserModel.fromJson(response);
      return Right(userModel);
    } on BadRequestException catch (e) {
      // Use toString() which is now correctly formatted in the exception class.
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on NoInternetException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
