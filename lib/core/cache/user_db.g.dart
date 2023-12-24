// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDbAdapter extends TypeAdapter<UserDb> {
  @override
  final int typeId = HiveTypes.userDb;

  @override
  UserDb read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDb(
      name: fields[0] as String,
      image: fields[1] as Uint8List,
      password: fields[2] as String,
      isDark: fields[3] as bool?,
      isEnglish: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDb obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.isDark)
      ..writeByte(4)
      ..write(obj.isEnglish);
  }
}

class PendedTaskAdapter extends TypeAdapter<PendedTask> {
  @override
  final int typeId =
      HiveTypes.pendedTask; // You can choose any positive integer as the typeId

  @override
  PendedTask read(BinaryReader reader) {
    return PendedTask(
      time: reader.read() as DateTime,
      name: reader.read() as String,
    );
  }

  @override
  void write(BinaryWriter writer, PendedTask obj) {
    writer
      ..write(obj.time)
      ..write(obj.name);
  }
}

class CompletedTaskAdapter extends TypeAdapter<CompletedTask> {
  @override
  final int typeId = HiveTypes
      .completedTask; // You can choose any positive integer as the typeId

  @override
  CompletedTask read(BinaryReader reader) {
    return CompletedTask(
      time: reader.read() as DateTime,
      name: reader.read() as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompletedTask obj) {
    writer
      ..write(obj.time)
      ..write(obj.name);
  }
}
