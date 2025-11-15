import 'package:first_flutter_v1/features/theme/domain/model/theme_model.dart';

import '../repositories/theme_repository.dart';

class SaveThemeUseCase {
  final ThemeRepository themeRepository;

  SaveThemeUseCase({required this.themeRepository});

  Future<void> call(ThemeModel theme) async {
    await themeRepository.setTheme(theme);
  }
}
