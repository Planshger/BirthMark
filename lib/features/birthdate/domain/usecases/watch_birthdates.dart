import 'package:birthmark/features/birthdate/domain/entities/birthdate.dart';
import 'package:birthmark/features/birthdate/domain/repositories/birthdate_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchBirthDates {
  final BirthDateRepository _repository;

  WatchBirthDates(this._repository);

  Stream<List<BirthDate>> call() => _repository.watchBirthDates();
}