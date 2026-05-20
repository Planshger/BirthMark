import '../repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class Register {
  final AuthRepository repository;
  Register(this.repository);

  Future<void> call(String username, String password) async {
    await repository.register(username, password);
  }
}