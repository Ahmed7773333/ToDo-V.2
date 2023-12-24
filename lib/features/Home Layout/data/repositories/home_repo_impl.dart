import 'package:todo/core/cache/category_db.dart';
import 'package:todo/core/cache/task_db.dart';
import 'package:todo/features/Home%20Layout/data/datasources/local_ds_impl.dart';

import '../../domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  LocalDsImpl localDsImpl;
  HomeRepoImpl(this.localDsImpl);

  @override
  void addCategory(CategoryDb category) {
    localDsImpl.addCategory(category);
  }

  @override
  void addTask(TaskDb task) {
    localDsImpl.addTask(task);
  }
}
