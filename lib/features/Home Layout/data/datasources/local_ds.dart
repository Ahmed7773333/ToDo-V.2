import '../../../../core/cache/category_db.dart';
import '../../../../core/cache/task_db.dart';

abstract class LocalDs {
  void addTask(TaskDb task);
  void addCategory(CategoryDb category);
}
