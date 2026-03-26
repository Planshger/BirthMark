import 'package:birthmark/features/birthdate/domain/entities/birthdate.dart';

abstract class BirthdateEvent {}

class LoadBirthDatesEvent extends BirthdateEvent {}

class AddBirthDateEvent extends BirthdateEvent {
  final String name;
  final DateTime birthDate;
  final String gift;

  AddBirthDateEvent({ required this.name, required this.birthDate, this.gift = ''});
}

class DeleteBirthDateEvent extends BirthdateEvent {
  final String id;

  DeleteBirthDateEvent({ required this.id});
}

class UpdateBirthDateEvent extends BirthdateEvent {
  final BirthDate birthDate;

  UpdateBirthDateEvent({required this.birthDate});
}

