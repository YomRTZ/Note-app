

class AuthState {}
class AuthStateInital extends AuthState {}
class AuthStateLoading extends AuthState {}
class AuthStateSucess extends AuthState {}
class AuthStateFailure extends AuthState {
  String message;
  AuthStateFailure({required this.message});
}
