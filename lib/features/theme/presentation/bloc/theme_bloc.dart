import 'package:bloc/bloc.dart';
import 'package:first_flutter_v1/features/theme/domain/model/theme_model.dart';
import 'package:first_flutter_v1/features/theme/domain/usecase/get_theme_use_case.dart';
import 'package:first_flutter_v1/features/theme/presentation/bloc/theme_events.dart';
import 'package:first_flutter_v1/features/theme/presentation/bloc/theme_state.dart';

import '../../domain/usecase/save_theme_use_case.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;

  ThemeBloc({required this.getThemeUseCase, required this.saveThemeUseCase})
    : super(ThemeState.initial()) {
    on<GetThemeEvent>(_onGetThemeEvent);
    on<ToggleThemeEvent>(_onToggleThemeEvent);
  }

  Future<void> _onGetThemeEvent(
    GetThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(status: ThemeStatus.loading));
    try {
      final theme = await getThemeUseCase();
      emit(state.copyWith(status: ThemeStatus.success, themeModel: theme));
    } catch (e) {
      emit(
        state.copyWith(status: ThemeStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onToggleThemeEvent(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    if (state.themeModel != null) {
      var newThemeType = state.themeModel!.themeType == ThemeType.light
          ? ThemeType.dark
          : ThemeType.light;
      var newTheme = ThemeModel(themeType: newThemeType);
      try {
        await saveThemeUseCase(newTheme);
        emit(state.copyWith(status: ThemeStatus.success, themeModel: newTheme));
      } catch (e) {
        emit(
          state.copyWith(status: ThemeStatus.error, errorMessage: e.toString()),
        );
      }
    }
  }
}
