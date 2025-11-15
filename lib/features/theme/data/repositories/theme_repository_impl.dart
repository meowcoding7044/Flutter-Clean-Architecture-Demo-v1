
import 'package:first_flutter_v1/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:first_flutter_v1/features/theme/domain/model/theme_model.dart';
import 'package:first_flutter_v1/features/theme/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository{

  final ThemeLocalDataSource themeLocalDataSource;
  ThemeRepositoryImpl({required this.themeLocalDataSource});

  @override
  Future<ThemeModel> getTheme() async {
    return await themeLocalDataSource.getTheme();
  }

  @override
  Future<void> setTheme(ThemeModel theme) async{
    return await themeLocalDataSource.saveTheme(theme);
  }

}