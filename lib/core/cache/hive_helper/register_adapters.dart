import 'package:hive/hive.dart';
import 'package:todo/core/cache/task_db.dart';
import 'package:todo/core/cache/category_db.dart';

import '../user_db.dart';

void registerAdapters() {
  Hive.registerAdapter(TaskDbAdapter());
  Hive.registerAdapter(CategoryDbAdapter());
  Hive.registerAdapter(UserDbAdapter());
}
