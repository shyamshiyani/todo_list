// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDataModelAdapter extends TypeAdapter<HiveDataModel> {
  @override
  final int typeId = 0;

  @override
  HiveDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDataModel(
      name: fields[0] as String,
      description: fields[1] as String,
      date: fields[2] as DateTime,
      time: fields[3] as String,
      priority: fields[4] as int,
      status: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDataModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.priority)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
