import 'package:birthmark/features/birthdate/domain/repositories/birthdate_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteBirthDate {
  final BirthDateRepository _repository;

  DeleteBirthDate(this._repository);

  Future<void> call(String id) async => _repository.deleteBirthDate(id);
}