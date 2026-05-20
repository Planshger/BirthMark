abstract class AuthEvent {}

class CheckAuthEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class ClearErrorEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  LoginEvent(this.username, this.password);
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;
  RegisterEvent(this.username, this.password);
}
