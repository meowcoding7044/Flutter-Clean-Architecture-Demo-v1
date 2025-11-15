import 'package:first_flutter_v1/features/theme/domain/model/theme_model.dart';
import 'package:first_flutter_v1/features/theme/domain/repositories/theme_repository.dart';

class GetThemeUseCase {
  final ThemeRepository themeRepository;

  GetThemeUseCase({required this.themeRepository});
  Future<ThemeModel> call() async {
    return await themeRepository.getTheme();
  }
}
