// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryDbAdapter extends TypeAdapter<CategoryDb> {
  @override
  final int typeId = HiveTypes.categoryDb;

  @override
  CategoryDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryDb(
      name: fields[CategoryDbFields.name] as String,
      color: fields[CategoryDbFields.color] as int,
      icon: fields[CategoryDbFields.icon] as int,
      count: fields[CategoryDbFields.count] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryDb obj) {
    writer
      ..writeByte(4)
      ..writeByte(CategoryDbFields.name)
      ..write(obj.name)
      ..writeByte(CategoryDbFields.color)
      ..write(obj.color)
      ..writeByte(CategoryDbFields.icon)
      ..write(obj.icon)
      ..writeByte(CategoryDbFields.count)
      ..write(obj.count);
  }
}
