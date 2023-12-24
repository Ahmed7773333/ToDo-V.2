import 'package:todo/core/cache/category_db.dart';
import 'package:todo/features/Home%20Layout/domain/repositories/home_repo.dart';

class AddCateoryUseCase {
  HomeRepo repo;
  AddCateoryUseCase(this.repo);

  void call(CategoryDb category) => repo.addCategory(category);
}
