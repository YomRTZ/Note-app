import 'package:flutter_ecommerc/src/data/domain/login_repository.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/login/login_event.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginRepository loginRepository;
  AuthBloc({required this.loginRepository}) : super(AuthStateInital()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        try {
          emit(AuthStateLoading());
          final response = await loginRepository.login(event.user);
          if (response.token.isNotEmpty) {
            emit(AuthStateSucess());
          } else {
            emit(AuthStateFailure(message: "Failed to login"));
          }
        } catch (e) {
          emit(AuthStateFailure(message: "Failed to login"));
        }
      }
    });
  }
}

