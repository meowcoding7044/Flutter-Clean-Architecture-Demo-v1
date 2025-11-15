import 'package:first_flutter_v1/features/theme/domain/model/theme_model.dart';

enum ThemeStatus { initial, loading, success, error }

class ThemeState {
  final ThemeStatus status;
  final String? errorMessage;
  final ThemeModel? themeModel;

  ThemeState._({required this.status, this.errorMessage, this.themeModel});

  factory ThemeState.initial() => ThemeState._(status: ThemeStatus.initial);

  ThemeState copyWith({
    ThemeStatus? status,
    String? errorMessage,
    ThemeModel? themeModel,
  }) => ThemeState._(
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    themeModel: themeModel ?? this.themeModel,
  );
}
