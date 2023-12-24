import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/core/cache/task_db.dart';

import '../category_db.dart';
import '../user_db.dart';

class TaskDbHelper {
  static const String boxName = 'TaskDbBox';

  static add(TaskDb category) {
    Box<TaskDb> categoryBox = Hive.box(boxName);
    categoryBox.add(category);
  }

  static update(dynamic id, TaskDb category) {
    Box<TaskDb> categoryBox = Hive.box(boxName);
    categoryBox.put(id, category);
  }

  static List<TaskDb> getAll() {
    Box<TaskDb> categoryBox = Hive.box(boxName);
    return categoryBox.values.toList().cast<TaskDb>();
  }

  static TaskDb? getById(int id) {
    Box<TaskDb> categoryBox = Hive.box(boxName);
    return categoryBox.getAt(id);
  }

  static delete(TaskDb element) {
    Box<TaskDb> categoryBox = Hive.box(boxName);
    categoryBox.delete(element.key);
  }

  static cler() {
    Box<TaskDb> categoryBox = Hive.box(boxName);
    categoryBox.clear();
  }
}

class CategoryDbHelper {
  static const String boxName = 'CategoryDbBox';

  static add(CategoryDb category) {
    Box<CategoryDb> categoryBox = Hive.box(boxName);
    categoryBox.add(category);
  }

  static List<CategoryDb> getAll() {
    Box<CategoryDb> categoryBox = Hive.box(boxName);
    return categoryBox.values.toList().cast<CategoryDb>();
  }

  static update(dynamic id, CategoryDb category) {
    Box<CategoryDb> categoryBox = Hive.box(boxName);
    categoryBox.put(id, category);
  }

  static CategoryDb? getById(int id) {
    Box<CategoryDb> categoryBox = Hive.box(boxName);
    return categoryBox.getAt(id);
  }

  static delete(int id) {
    Box<CategoryDb> categoryBox = Hive.box(boxName);
    categoryBox.deleteAt(id);
  }

  static cler() {
    Box<CategoryDb> categoryBox = Hive.box(boxName);
    categoryBox.clear();
  }
}

class UserDbHelper {
  static const String boxName = 'UserDbHelper';

  static add(UserDb category) {
    Box<UserDb> categoryBox = Hive.box(boxName);
    categoryBox.add(category);
  }

  static List<UserDb> getAll() {
    Box<UserDb> categoryBox = Hive.box(boxName);
    return categoryBox.values.toList().cast<UserDb>();
  }

  static UserDb? getById(int id) {
    Box<UserDb> categoryBox = Hive.box(boxName);
    return categoryBox.getAt(id);
  }

  static delete(int id) {
    Box<UserDb> categoryBox = Hive.box(boxName);
    categoryBox.deleteAt(id);
  }

  static cler() {
    Box<UserDb> categoryBox = Hive.box(boxName);
    categoryBox.clear();
  }

  static update(dynamic id, UserDb category) {
    Box<UserDb> categoryBox = Hive.box(boxName);
    categoryBox.put(id, category);
  }
}

clearFromDisk() {
  Box<UserDb> categoryBox = Hive.box(UserDbHelper.boxName);
  Box<CategoryDb> yBox = Hive.box(CategoryDbHelper.boxName);
  Box<TaskDb> task = Hive.box(TaskDbHelper.boxName);
  categoryBox.deleteFromDisk();
  yBox.deleteFromDisk();
  task.deleteFromDisk();
}

class PendedTaskHelper {
  static const String boxName = 'PendedTaskHelper';

  static add(PendedTask category) {
    Box<PendedTask> categoryBox = Hive.box(boxName);
    categoryBox.add(category);
  }

  static update(dynamic id, PendedTask category) {
    Box<PendedTask> categoryBox = Hive.box(boxName);
    categoryBox.put(id, category);
  }

  static List<PendedTask> getAll() {
    Box<PendedTask> categoryBox = Hive.box(boxName);
    return categoryBox.values.toList().cast<PendedTask>();
  }

  static PendedTask? getById(int id) {
    Box<PendedTask> categoryBox = Hive.box(boxName);
    return categoryBox.getAt(id);
  }

  static delete(List id) {
    Box<PendedTask> categoryBox = Hive.box(boxName);
    categoryBox.deleteAll(id);
  }

  static cler() {
    Box<PendedTask> categoryBox = Hive.box(boxName);
    categoryBox.clear();
  }
}

class CompletedTaskHelper {
  static const String boxName = 'CompletedTaskHelper';

  static add(CompletedTask category) {
    Box<CompletedTask> categoryBox = Hive.box(boxName);
    categoryBox.add(category);
  }

  static update(dynamic id, CompletedTask category) {
    Box<CompletedTask> categoryBox = Hive.box(boxName);
    categoryBox.put(id, category);
  }

  static List<CompletedTask> getAll() {
    Box<CompletedTask> categoryBox = Hive.box(boxName);
    return categoryBox.values.toList().cast<CompletedTask>();
  }

  static CompletedTask? getById(int id) {
    Box<CompletedTask> categoryBox = Hive.box(boxName);
    return categoryBox.getAt(id);
  }

  static delete(List id) {
    Box<CompletedTask> categoryBox = Hive.box(boxName);
    categoryBox.deleteAll(id);
  }

  static cler() {
    Box<CompletedTask> categoryBox = Hive.box(boxName);
    categoryBox.clear();
  }
}

class StepsHelper {
  static const String boxName = 'StepsHelper';

  static add(Stepss category) {
    Box<Stepss> categoryBox = Hive.box(boxName);
    categoryBox.add(category);
  }

  static update(dynamic id, Stepss category) {
    Box<Stepss> categoryBox = Hive.box(boxName);
    categoryBox.put(id, category);
  }

  static List<Stepss> getAll() {
    Box<Stepss> categoryBox = Hive.box(boxName);
    return categoryBox.values.toList().cast<Stepss>();
  }

  static Stepss? getById(id) {
    Box<Stepss> categoryBox = Hive.box(boxName);
    return categoryBox.get(id);
  }

  static delete(dynamic id) {
    Box<Stepss> categoryBox = Hive.box(boxName);
    categoryBox.delete(id);
  }

  static cler() {
    Box<Stepss> categoryBox = Hive.box(boxName);
    categoryBox.clear();
  }
}

registsHive() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CategoryDbAdapter());
  await Hive.openBox<CategoryDb>(CategoryDbHelper.boxName);
  Hive.registerAdapter(TaskDbAdapter());
  await Hive.openBox<TaskDb>(TaskDbHelper.boxName);
  Hive.registerAdapter(PendedTaskAdapter());
  await Hive.openBox<PendedTask>(PendedTaskHelper.boxName);
  Hive.registerAdapter(CompletedTaskAdapter());
  await Hive.openBox<CompletedTask>(CompletedTaskHelper.boxName);
  Hive.registerAdapter(UserDbAdapter());
  await Hive.openBox<UserDb>(UserDbHelper.boxName);
  Hive.registerAdapter(StepAdapter());
  await Hive.openBox<Stepss>(StepsHelper.boxName);
}

checkEveryDay() {
  for (TaskDb task in TaskDbHelper.getAll()) {
    if (task.time
        .isBefore(DateTime.now().copyWith(hour: 0, minute: 0, second: 0))) {
      if (task.repeat) {
        if (!task.done) {
          PendedTaskHelper.add(PendedTask(time: task.time, name: task.title));
        }
        task.done = false;
        task.time = DateTime.now()
            .copyWith(hour: task.time.hour, minute: task.time.minute);
        for (Stepss step in StepsHelper.getAll()) {
          if (step.id == task.id) {
            step.done = false;
            StepsHelper.update(step.key, step);
          }
        }
        TaskDbHelper.update(task.key, task);
      } else {
        PendedTaskHelper.add(PendedTask(time: task.time, name: task.title));
        for (Stepss step in StepsHelper.getAll()) {
          if (step.id == task.id) {
            StepsHelper.delete(step.key);
          }
        }
        TaskDbHelper.delete(task.key);
      }
    }
  }
}
