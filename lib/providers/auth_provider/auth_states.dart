abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

class AuthLoaded extends AuthState {
  final String idDoctor;
  const AuthLoaded(this.idDoctor);
}