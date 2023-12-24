import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:todo/core/cache/hive_helper/fields/user_db_fields.dart';

import 'hive_helper/hive_adapters.dart';
import 'hive_helper/hive_types.dart';

part 'user_db.g.dart';

@HiveType(typeId: HiveTypes.userDb, adapterName: HiveAdapters.userDb)
class UserDb extends HiveObject {
  UserDb({
    required this.name,
    required this.image,
    required this.password,
    this.isDark,
    this.isEnglish,
  });
  @HiveField(UserDbFields.name)
  String name;
  @HiveField(UserDbFields.image)
  Uint8List image;
  @HiveField(UserDbFields.password)
  String password;
  @HiveField(UserDbFields.isDark)
  bool? isDark;
  @HiveField(UserDbFields.isEnglish)
  String? isEnglish;
}

@HiveType(typeId: HiveTypes.pendedTask, adapterName: HiveAdapters.pendedTask)
class PendedTask extends HiveObject {
  PendedTask({required this.time, required this.name});
  @HiveField(0)
  DateTime time;
  @HiveField(1)
  String name;
}

@HiveType(
    typeId: HiveTypes.completedTask, adapterName: HiveAdapters.completedTask)
class CompletedTask extends HiveObject {
  CompletedTask({required this.time, required this.name});
  @HiveField(0)
  DateTime time;
  @HiveField(1)
  String name;
}
