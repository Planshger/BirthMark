import 'package:birthmark/features/birthdate/domain/entities/birthdate.dart';
import 'package:birthmark/features/birthdate/domain/repositories/birthdate_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBirthDates {
  final BirthDateRepository _repository;

  GetBirthDates(this._repository);

  Future<List<BirthDate>> call() async => _repository.getBirthDates();
}