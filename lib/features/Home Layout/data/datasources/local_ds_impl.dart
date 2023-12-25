import 'package:todo/core/cache/category_db.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';
import 'package:todo/core/cache/task_db.dart';
import 'package:todo/features/Home%20Layout/data/datasources/local_ds.dart';

class LocalDsImpl implements LocalDs {
  @override
  void addCategory(CategoryDb category) {
    categoryDbHelper.add(category);
  }

  @override
  void addTask(TaskDb task) {
    taskDbHelper.add(task);
  }
}
