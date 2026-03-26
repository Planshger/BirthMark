// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'birthdate_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BirthDateModelAdapter extends TypeAdapter<BirthDateModel> {
  @override
  final typeId = 0;

  @override
  BirthDateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BirthDateModel(
      name: fields[1] as String,
      birthDate: fields[2] as DateTime,
      gift: fields[3] as String,
      id: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BirthDateModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.birthDate)
      ..writeByte(3)
      ..write(obj.gift);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BirthDateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
