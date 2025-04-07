import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/repository/login/login_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      try {
        emit(LoginLoading());

        final isAuthenticated = await loginRepository.login(
          username: event.username,
          password: event.password,
        );

        if (isAuthenticated) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(errorMessage: 'Usuário ou senha inválidos!'));
        }
      } catch (_) {
        emit(LoginFailure(errorMessage: 'Erro ao tentar fazer o login'));
      }
    });
  }
}
