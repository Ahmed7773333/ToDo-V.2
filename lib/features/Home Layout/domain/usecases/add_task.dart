import 'package:todo/core/cache/task_db.dart';
import 'package:todo/features/Home%20Layout/domain/repositories/home_repo.dart';

class AddTaskUseCase {
  HomeRepo repo;
  AddTaskUseCase(this.repo);

  void call(TaskDb task) => repo.addTask(task);
}
