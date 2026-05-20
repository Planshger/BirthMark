import 'package:birthmark/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<User> register(String username, String password);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<String?> getToken();
  Future<int?> getUserId();
}