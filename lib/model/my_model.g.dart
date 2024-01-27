// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyModelAdapter extends TypeAdapter<MyModel> {
  @override
  final int typeId = 1;

  @override
  MyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyModel(
      title: fields[1] as String,
      description: fields[2] as String,
      date: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
