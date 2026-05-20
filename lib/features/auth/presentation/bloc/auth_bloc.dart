import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;
  final AuthRepository authRepository;

  AuthBloc(this.login, this.register, this.authRepository) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<CheckAuthEvent>(_onCheckAuth);
    on<ClearErrorEvent>((event, emit) => emit(AuthInitial()));
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await login(event.username, event.password);
      emit(Authenticated(event.username));
    } catch (e) {
      emit(AuthError('Неправильный логин или пароль'));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await register(event.username, event.password);
      emit(Authenticated(event.username));
    } catch (e) {
      emit(AuthError('Ошибка регистрации, попробуйте позже'));
    }
  }

  Future<void> _onCheckAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    final isLogged = await authRepository.isLoggedIn();
    if (isLogged) {
      final userId = await authRepository.getUserId();
      emit(Authenticated(userId?.toString() ?? 'User'));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(AuthInitial());
  }
}