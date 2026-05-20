import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl(this.apiClient, this.secureStorage);

  @override
  Future<User> login(String username, String password) async {
    final response = await apiClient.dio.post('/auth/login', data: {
      'username': username,
      'password': password,
    });
    final data = response.data;
    final token = data['token'];
    final userData = data['user'];
    await _saveToken(token);
    await _saveUserId(userData['id']);
    return User(id: userData['id'], username: userData['username']);
  }

  @override
  Future<User> register(String username, String password) async {
    final response = await apiClient.dio.post('/auth/register', data: {
      'username': username,
      'password': password,
    });
    final data = response.data;
    final token = data['token'];
    final userData = data['user'];
    await _saveToken(token);
    await _saveUserId(userData['id']);
    return User(id: userData['id'], username: userData['username']);
  }

  Future<void> _saveToken(String token) async {
    await secureStorage.write(key: 'jwt_token', value: token);
  }

  Future<void> _saveUserId(int userId) async {
    await secureStorage.write(key: 'user_id', value: userId.toString());
  }

  @override
  Future<void> logout() async {
    await secureStorage.delete(key: 'jwt_token');
    await secureStorage.delete(key: 'user_id');
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await secureStorage.read(key: 'jwt_token');
    return token != null;
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: 'jwt_token');
  }

  @override
  Future<int?> getUserId() async {
    final id = await secureStorage.read(key: 'user_id');
    return id != null ? int.tryParse(id) : null;
  }
}