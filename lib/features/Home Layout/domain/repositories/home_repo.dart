import 'package:todo/core/cache/category_db.dart';
import 'package:todo/core/cache/task_db.dart';

abstract class HomeRepo {
  void addTask(TaskDb task);
  void addCategory(CategoryDb category);
}
