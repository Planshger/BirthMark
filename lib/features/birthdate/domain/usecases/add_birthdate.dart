import 'package:birthmark/features/birthdate/domain/entities/birthdate.dart';
import 'package:birthmark/features/birthdate/domain/repositories/birthdate_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddBirthDate {
  final BirthDateRepository _repository;

  AddBirthDate(this._repository);

  Future<void> call(BirthDate birthDate) async => _repository.addBirthDate(birthDate);
}
