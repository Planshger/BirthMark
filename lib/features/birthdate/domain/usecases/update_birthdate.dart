import 'package:birthmark/features/birthdate/domain/entities/birthdate.dart';
import 'package:birthmark/features/birthdate/domain/repositories/birthdate_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateBirthDate {
  final BirthDateRepository _repository;

  UpdateBirthDate(this._repository);

  Future<void> call(BirthDate birthDate) async => _repository.updateBirthDate(birthDate);
}   