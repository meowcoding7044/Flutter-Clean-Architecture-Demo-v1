import 'package:first_flutter_v1/core/config/routes.dart';
import 'package:first_flutter_v1/core/config/routes_name.dart';
import 'package:first_flutter_v1/core/di/injection_container.dart' as di;
import 'package:first_flutter_v1/core/theme/app_theme_data.dart';
import 'package:first_flutter_v1/features/theme/domain/model/theme_model.dart';
import 'package:first_flutter_v1/features/theme/presentation/bloc/theme_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/theme/presentation/bloc/theme_bloc.dart';
import 'features/theme/presentation/bloc/theme_events.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: kReleaseMode ? ".env" : ".env.dev");

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ThemeBloc>()..add(GetThemeEvent()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Production App',
            theme: AppThemeData.getTheme(
              state.themeModel?.themeType == ThemeType.dark,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: RoutesName.splashScreen,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    );
  }
}
