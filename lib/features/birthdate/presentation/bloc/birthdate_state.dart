import 'package:birthmark/features/birthdate/domain/entities/birthdate.dart';

abstract class BirthdateState {}

class BirthdateInitial extends BirthdateState {}

class BirthdateLoading extends BirthdateState {}

class BirthdateLoaded extends BirthdateState {
  final List<BirthDate> birthdates;

  BirthdateLoaded(this.birthdates);
}

class BirthdateError extends BirthdateState {
  final String error;

  BirthdateError(this.error);
}