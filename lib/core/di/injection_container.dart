import 'package:first_flutter_v1/core/network/networkservice/network_services_api.dart';
import 'package:first_flutter_v1/features/auth/data/repositories/login_http_api_repository.dart';
import 'package:first_flutter_v1/features/auth/data/repositories/login_repository.dart';
import 'package:first_flutter_v1/features/auth/data/services/session_controller.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/bloc.dart';
import 'package:first_flutter_v1/features/message/data/repositories/message_http_api_repository.dart';
import 'package:first_flutter_v1/features/message/data/repositories/message_repository.dart';
import 'package:first_flutter_v1/features/message/presentation/bloc/bloc.dart';
import 'package:first_flutter_v1/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:first_flutter_v1/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:first_flutter_v1/features/theme/domain/repositories/theme_repository.dart';
import 'package:first_flutter_v1/features/theme/domain/usecase/get_theme_use_case.dart';
import 'package:first_flutter_v1/features/theme/domain/usecase/save_theme_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/theme/presentation/bloc/theme_bloc.dart';

final sl = GetIt.instance; // Service Locator

Future<void> init() async {
  // --- Features ---

  // Auth Feature
  sl.registerFactory(
    () => LoginBloc(loginRepository: sl(), sessionController: sl()),
  );
  sl.registerLazySingleton<LoginRepository>(
    () => LoginHttpApiRepository(api: sl()),
  );

  // Message Feature
  sl.registerFactory(() => MessageBloc(messageRepository: sl()));
  sl.registerLazySingleton<MessageRepository>(
    () => MessageHttpApiRepository(apiService: sl()),
  );

  // Theme Feature
  sl.registerFactory(
    () => ThemeBloc(getThemeUseCase: sl(), saveThemeUseCase: sl()),
  );
  sl.registerLazySingleton(() => GetThemeUseCase(themeRepository: sl()));
  sl.registerLazySingleton(() => SaveThemeUseCase(themeRepository: sl()));
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(themeLocalDataSource: sl()),
  );
  sl.registerLazySingleton<ThemeLocalDataSource>(() => ThemeLocalDataSource());

  // --- Core ---
  sl.registerLazySingleton(() => NetworkServicesApi());
  sl.registerLazySingleton(
    () => SessionController(),
  ); // Register SessionController

  // --- External ---
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
