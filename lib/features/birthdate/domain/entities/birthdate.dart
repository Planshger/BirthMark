import 'package:uuid/uuid.dart';

class BirthDate {
  final String id;
  final String name;
  final DateTime birthDate;
  final String gift;

  BirthDate({
    String? id,
    required this.name,
    required this.birthDate,
    required this.gift,
  }) : id = id ?? const Uuid().v4();

  BirthDate copyWith({
    String? id,
    String? name,
    DateTime? birthDate,
    String? gift,
  }) {
    return BirthDate(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      gift: gift ?? this.gift,
    );
  }


}
