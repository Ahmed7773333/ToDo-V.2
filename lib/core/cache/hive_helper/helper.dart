import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/core/cache/task_db.dart';

import '../category_db.dart';
import '../user_db.dart';

class DbHelper<T> {
  final String boxName;

  DbHelper(this.boxName);

  void add(T item) {
    Box<T> box = Hive.box(boxName);
    box.add(item);
  }

  void update(dynamic id, T item) {
    Box<T> box = Hive.box(boxName);
    box.put(id, item);
  }

  List<T> getAll() {
    Box<T> box = Hive.box(boxName);
    return box.values.toList().cast<T>();
  }

  T? getById(int id) {
    Box<T> box = Hive.box(boxName);
    return box.get(id);
  }

  void delete(dynamic id) {
    Box<T> box = Hive.box(boxName);
    box.delete(id);
  }

  void deleteAll(List<dynamic> ids) {
    Box<T> box = Hive.box(boxName);
    box.deleteAll(ids);
  }

  void clear() {
    Box<T> box = Hive.box(boxName);
    box.clear();
  }

  void deleteFromDisk() {
    Box<T> box = Hive.box(boxName);
    box.deleteFromDisk();
  }
}

var taskDbHelper = DbHelper<TaskDb>('TaskDbBox');
var categoryDbHelper = DbHelper<CategoryDb>('CategoryDbBox');
var userDbHelper = DbHelper<UserDb>('UserDbHelper');
var pendedTaskHelper = DbHelper<PendedTask>('PendedTaskHelper');
var completedTaskHelper = DbHelper<CompletedTask>('CompletedTaskHelper');
var stepsHelper = DbHelper<Stepss>('StepsHelper');

registsHive() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CategoryDbAdapter());
  await Hive.openBox<CategoryDb>(categoryDbHelper.boxName);
  Hive.registerAdapter(TaskDbAdapter());
  await Hive.openBox<TaskDb>(taskDbHelper.boxName);
  Hive.registerAdapter(PendedTaskAdapter());
  await Hive.openBox<PendedTask>(pendedTaskHelper.boxName);
  Hive.registerAdapter(CompletedTaskAdapter());
  await Hive.openBox<CompletedTask>(completedTaskHelper.boxName);
  Hive.registerAdapter(UserDbAdapter());
  await Hive.openBox<UserDb>(userDbHelper.boxName);
  Hive.registerAdapter(StepAdapter());
  await Hive.openBox<Stepss>(stepsHelper.boxName);
}

checkEveryDay() {
  for (TaskDb task in taskDbHelper.getAll()) {
    if (task.time
        .isBefore(DateTime.now().copyWith(hour: 0, minute: 0, second: 0))) {
      if (task.repeat) {
        if (!task.done) {
          pendedTaskHelper.add(PendedTask(time: task.time, name: task.title));
        }
        task.done = false;
        task.time = DateTime.now()
            .copyWith(hour: task.time.hour, minute: task.time.minute);
        for (Stepss step in stepsHelper.getAll()) {
          if (step.id == task.id) {
            step.done = false;
            stepsHelper.update(step.key, step);
          }
        }
        taskDbHelper.update(task.key, task);
      } else {
        pendedTaskHelper.add(PendedTask(time: task.time, name: task.title));
        for (Stepss step in stepsHelper.getAll()) {
          if (step.id == task.id) {
            stepsHelper.delete(step.key);
          }
        }
        taskDbHelper.delete(task.key);
      }
    }
  }
}
