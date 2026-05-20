import '../repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class Login {
  final AuthRepository repository;
  Login(this.repository);

  Future<void> call(String username, String password) async {
    await repository.login(username, password);
  }
}