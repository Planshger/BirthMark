// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishModelAdapter extends TypeAdapter<WishModel> {
  @override
  final typeId = 1;

  @override
  WishModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishModel(
      id: (fields[0] as num?)?.toInt(),
      title: fields[1] as String,
      price: (fields[2] as num?)?.toDouble(),
      link: fields[3] as String?,
      categoryId: (fields[4] as num?)?.toInt(),
      occasionId: (fields[5] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, WishModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.link)
      ..writeByte(4)
      ..write(obj.categoryId)
      ..writeByte(5)
      ..write(obj.occasionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
