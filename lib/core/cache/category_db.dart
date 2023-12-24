import 'package:hive/hive.dart';

import 'hive_helper/fields/category_db_fields.dart';
import 'hive_helper/hive_adapters.dart';
import 'hive_helper/hive_types.dart';

part 'category_db.g.dart';

@HiveType(typeId: HiveTypes.categoryDb, adapterName: HiveAdapters.categoryDb)
class CategoryDb extends HiveObject {
  CategoryDb(
      {required this.name,
      required this.color,
      required this.icon,
      required this.count});
  @HiveField(CategoryDbFields.name)
  String name;
  @HiveField(CategoryDbFields.color)
  int color;
  @HiveField(CategoryDbFields.icon)
  int icon;
  @HiveField(CategoryDbFields.count)
  int count;
}
