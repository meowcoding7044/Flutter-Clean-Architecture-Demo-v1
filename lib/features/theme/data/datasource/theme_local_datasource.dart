import 'package:first_flutter_v1/features/theme/domain/model/theme_model.dart';

import '../../../../core/storage/local_storage.dart';

class ThemeLocalDataSource {
  final LocalStorage localStorage = LocalStorage();

  Future saveTheme(ThemeModel theme) async {
    var themeValue = theme.themeType == ThemeType.dark ? 'dark' : 'light';
    await localStorage.setValue('theme', themeValue);
  }

  Future<ThemeModel> getTheme() async {
    var themeValue = await localStorage.getValue('theme');
    if (themeValue == 'dark') {
      return ThemeModel(themeType: ThemeType.dark);
    }
    return ThemeModel(themeType: ThemeType.light);
  }
}
