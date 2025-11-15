import 'package:bloc/bloc.dart';
import 'package:first_flutter_v1/core/utils/enums.dart';
import 'package:first_flutter_v1/features/auth/data/repositories/login_repository.dart';
import 'package:first_flutter_v1/features/auth/data/services/session_controller.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/login_event.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final LoginRepository loginRepository;
  final SessionController sessionController;

  LoginBloc({required this.loginRepository, required this.sessionController})
    : super(const LoginStates()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_onLoginApi);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginStates> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginStates> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginApi(LoginApi event, Emitter<LoginStates> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    final result = await loginRepository.loginApi({
      'email': state.email,
      'password': state.password,
    });

    // Use if-else with .isRight() to handle async operations safely.
    if (result.isRight()) {
      final user = result.getOrElse(
        (l) => throw Exception('Should not happen'),
      );
      await sessionController.saveUserInPreference(user);
      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.success,
          message: 'Login successful',
        ),
      );
    } else {
      final failure = result.swap().getOrElse(
        (r) => throw Exception('Should not happen'),
      );
      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.error,
          message: failure.message,
        ),
      );
    }
  }
}
