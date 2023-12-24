// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskDbAdapter extends TypeAdapter<TaskDb> {
  @override
  final int typeId = HiveTypes.taskDb;

  @override
  TaskDb read(BinaryReader reader) {
    return TaskDb(
      title: reader.read() as String,
      description: reader.read() as String,
      done: reader.read() as bool,
      priority: reader.read() as int,
      categoryColor: reader.read() as int,
      categoryIcon: reader.read() as int,
      categoryName: reader.read() as String,
      time: reader.read() as DateTime,
      repeat: reader.read() as bool,
      id: reader.read() as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskDb obj) {
    writer
      ..write(obj.title)
      ..write(obj.description)
      ..write(obj.done)
      ..write(obj.priority)
      ..write(obj.categoryColor)
      ..write(obj.categoryIcon)
      ..write(obj.categoryName)
      ..write(obj.time)
      ..write(obj.repeat)
      ..write(obj.id);
  }
}

class StepAdapter extends TypeAdapter<Stepss> {
  @override
  final int typeId =
      HiveTypes.stepss; // You can choose any positive integer as the typeId

  @override
  Stepss read(BinaryReader reader) {
    return Stepss(
      id: reader.read() as String,
      name: reader.read() as String,
      done: reader.read() as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Stepss obj) {
    writer
      ..write(obj.id)
      ..write(obj.name)
      ..write(obj.done);
  }
}
