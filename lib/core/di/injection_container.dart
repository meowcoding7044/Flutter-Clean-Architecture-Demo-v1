import 'package:first_flutter_v1/features/auth/data/repositories/login_http_api_repository.dart';
import 'package:first_flutter_v1/features/auth/data/repositories/login_repository.dart';
import 'package:first_flutter_v1/features/auth/data/services/session_controller.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/login_bloc.dart';
import 'package:first_flutter_v1/features/message/data/repositories/message_http_api_repository.dart';
import 'package:first_flutter_v1/features/message/data/repositories/message_repository.dart';
import 'package:first_flutter_v1/features/message/presentation/bloc/message_bloc.dart';
import 'package:get_it/get_it.dart';

import '../network/networkservice/network_services_api.dart';

final sl = GetIt.instance; // Service Locator

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => LoginBloc(loginRepository: sl()));
  sl.registerFactory(() => MessageBloc(messageRepository: sl()));

  // Repositories
  sl.registerLazySingleton<LoginRepository>(
    () => LoginHttpApiRepository(api: sl()),
  );
  sl.registerLazySingleton<MessageRepository>(
    () => MessageHttpApiRepository(apiService: sl()),
  );

  // Services & Core
  sl.registerLazySingleton(() => NetworkServicesApi());
  sl.registerLazySingleton(() => SessionController());
  // You can also register LocalStorage here if needed
  // sl.registerLazySingleton(() => LocalStorage());
}
