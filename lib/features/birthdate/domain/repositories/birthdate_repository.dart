import 'package:birthmark/features/birthdate/domain/entities/birthdate.dart';

abstract class BirthDateRepository {
  Stream<List<BirthDate>> watchBirthDates();
  Future<List<BirthDate>> getBirthDates();
  Future<void> addBirthDate(BirthDate birthDate);
  Future<void> deleteBirthDate(String id);
  Future<void> updateBirthDate(BirthDate birthDate); 
  void dispose();
}
