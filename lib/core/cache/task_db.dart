import 'package:hive/hive.dart';

import 'hive_helper/fields/task_db_fields.dart';
import 'hive_helper/hive_adapters.dart';
import 'hive_helper/hive_types.dart';

part 'task_db.g.dart';

@HiveType(typeId: HiveTypes.taskDb, adapterName: HiveAdapters.taskDb)
class TaskDb extends HiveObject {
  TaskDb(
      {required this.title,
      required this.description,
      required this.done,
      required this.priority,
      required this.categoryColor,
      required this.categoryIcon,
      required this.categoryName,
      required this.time,
      required this.repeat,
      required this.id});
  @HiveField(TaskDbFields.title)
  String title;
  @HiveField(TaskDbFields.description)
  String description;
  @HiveField(TaskDbFields.done)
  bool done;
  @HiveField(TaskDbFields.priority)
  int priority;
  @HiveField(TaskDbFields.categoryColor)
  int categoryColor;
  @HiveField(TaskDbFields.categoryIcon)
  int categoryIcon;
  @HiveField(TaskDbFields.categoryName)
  String categoryName;
  @HiveField(TaskDbFields.time)
  DateTime time;
  @HiveField(TaskDbFields.repeat)
  bool repeat;
  @HiveField(TaskDbFields.id)
  String id;
}

@HiveType(typeId: HiveTypes.stepss, adapterName: HiveAdapters.steps)
class Stepss extends HiveObject {
  Stepss({
    required this.id,
    required this.name,
    required this.done,
  });
  @HiveField(TaskDbFields.title)
  String id;
  @HiveField(TaskDbFields.description)
  String name;
  @HiveField(TaskDbFields.done)
  bool done;
}
