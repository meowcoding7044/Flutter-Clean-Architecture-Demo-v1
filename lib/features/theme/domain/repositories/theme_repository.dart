
import 'package:first_flutter_v1/features/theme/domain/model/theme_model.dart';

abstract class ThemeRepository{
  Future<ThemeModel> getTheme();
  Future<void> setTheme(ThemeModel theme);
}