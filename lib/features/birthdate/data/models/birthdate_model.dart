import 'package:birthmark/features/birthdate/domain/entities/birthdate.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
 
part 'birthdate_model.g.dart';

@HiveType(typeId: 0)
class BirthDateModel extends HiveObject {

  @HiveField(0)
  late final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime birthDate;

  @HiveField(3)
  final String gift;

  BirthDateModel({
    required this.name,
    required this.birthDate,
    required this.gift,
    String? id,
  }) : id = id ?? const Uuid().v4();

  BirthDate toEntity() {
    return BirthDate(
      id: id,
      name: name,
      birthDate: birthDate,
      gift: gift,
    );
  }

  factory BirthDateModel.toModel(BirthDate birthDate) {
    return BirthDateModel(
      id: birthDate.id,
      name: birthDate.name,
      birthDate: birthDate.birthDate,
      gift: birthDate.gift,
    );
  }
}
