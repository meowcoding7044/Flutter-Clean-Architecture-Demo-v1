import 'package:bloc/bloc.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/login_event.dart';
import 'package:first_flutter_v1/features/auth/presentation/bloc/login_states.dart';
import 'package:first_flutter_v1/features/auth/data/repositories/login_repository.dart';
import 'package:first_flutter_v1/features/auth/data/services/session_controller.dart';
import 'package:first_flutter_v1/core/utils/enums.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(const LoginStates()) {
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

  void _onLoginApi(LoginApi event, Emitter<LoginStates> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    Map<String, String> data = {
      "email": state.email,
      "password": state.password,
    };

    try {
      final value = await loginRepository.loginApi(data);
      if (value.error != null) {
        print(value);
        emit(
          state.copyWith(
            postApiStatus: PostApiStatus.error,
            message: value.message.toString(),
          ),
        );
      } else {
        await SessionController().saveUserInPreference(value);
        await SessionController().getUserFromPreference();

        emit(
          state.copyWith(
            postApiStatus: PostApiStatus.success,
            message: "Login successful",
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.error,
          message: error.toString(),
        ),
      );
    }
  }
}
