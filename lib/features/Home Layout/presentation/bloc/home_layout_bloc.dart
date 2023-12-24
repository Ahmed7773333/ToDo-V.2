import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/cache/category_db.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';
import 'package:todo/core/cache/task_db.dart';
import 'package:todo/core/cache/user_db.dart';
import 'package:todo/features/Home%20Layout/domain/usecases/add_category.dart';
import 'package:todo/features/Home%20Layout/domain/usecases/add_task.dart';

import '../../../../core/eror/failuers.dart';

part 'home_layout_event.dart';
part 'home_layout_state.dart';

class HomeLayoutBloc extends Bloc<HomeLayoutEvent, HomeLayoutState> {
  static HomeLayoutBloc get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  DateTime initTime = DateTime.now();
  PageController pageController = PageController(initialPage: 0);
  int priority = 0;
  int priorityFilter = 0;
  bool done = false;
  DateTime time = DateTime.now();
  int categoryColor = Colors.black.value;
  int categoryIcon = Icons.question_mark_rounded.codePoint;
  String categoryName = 'None';
  String categoryNameFilter = 'None';
  AddCateoryUseCase addCateoryUseCase;
  AddTaskUseCase addTaskUseCase;
  List<TaskDb> filteredTask = [];
  bool isCompletedTasks = false;
  HomeLayoutBloc(this.addCateoryUseCase, this.addTaskUseCase)
      : super(HomeLayoutInitial()) {
    on<HomeLayoutEvent>((event, emit) {
      if (event is ShowAddTaskEvent) {
        emit(state.copWith(status: ScreenStatus.addTaskState));
      } else if (event is AddTaskEvent) {
        TaskDb task = event.task;
        addTaskUseCase(task);
        emit(state.copWith(status: ScreenStatus.taskAdded));
      } else if (event is AddCategoryEvent) {
        emit(state.copWith(status: ScreenStatus.homeLoading));
        CategoryDb category = event.category;
        addCateoryUseCase(category);
        emit(state.copWith(status: ScreenStatus.categoryAdded));
      } else if (event is ChooseCategoryEvent) {
        emit(state.copWith(status: ScreenStatus.homeLoading));
        categoryName = event.categoryDb.name;
        categoryColor = event.categoryDb.color;
        categoryIcon = event.categoryDb.icon;

        emit(state.copWith(status: ScreenStatus.chooseCategory));
      } else if (event is ChoosepreiortyEvent) {
        priority = event.priority;

        emit(state.copWith(status: ScreenStatus.choosePriority));
      } else if (event is ChooseTimeEvent) {
        time = event.time;

        emit(state.copWith(status: ScreenStatus.chooseTime));
      } else if (event is GetAllCategoriesEvent) {
        emit(state.copWith(status: ScreenStatus.homeLoading));
        emit(
          state.copWith(
              status: ScreenStatus.getCategories,
              categories: CategoryDbHelper.getAll()),
        );
      } else if (event is GetAllTasksEvent) {
        emit(state.copWith(status: ScreenStatus.homeLoading));
        emit(
          state.copWith(
              status: ScreenStatus.getTasks, tasks: TaskDbHelper.getAll()),
        );
      } else if (event is FilterTasksEvent) {
        emit(state.copWith(status: ScreenStatus.homeLoading));
        if (event.categoryName != 'None' && event.priorty != 0) {
          filteredTask = TaskDbHelper.getAll()
              .where((element) => (element.categoryName == event.categoryName &&
                  element.priority == event.priorty))
              .toList();
        } else if (event.categoryName == 'None' && event.priorty != 0) {
          filteredTask = TaskDbHelper.getAll()
              .where((element) => (element.priority == event.priorty))
              .toList();
        } else if (event.categoryName != 'None' && event.priorty == 0) {
          filteredTask = TaskDbHelper.getAll()
              .where((element) => (element.categoryName == event.categoryName))
              .toList();
        } else {
          filteredTask = [];
        }
        emit(
          state.copWith(status: ScreenStatus.filteredTask),
        );
      } else if (event is GetAllTasksAtDay) {
        emit(state.copWith(status: ScreenStatus.homeLoading));
        isCompletedTasks = false;
        DateTime filterDate = event.time;
        initTime = filterDate;
        emit(
          state.copWith(
              status: ScreenStatus.taskAtDay,
              tasksAtDay: TaskDbHelper.getAll().where((task) {
                return task.time.year == filterDate.year &&
                    task.time.month == filterDate.month &&
                    task.time.day == filterDate.day;
              }).toList()),
        );
      } else if (event is GetCompletedTask) {
        emit(state.copWith(status: ScreenStatus.homeLoading));
        isCompletedTasks = true;
        emit(
          state.copWith(
              status: ScreenStatus.getCompletedTasks,
              completedTasks: TaskDbHelper.getAll()
                  .where((element) => element.done)
                  .toList()),
        );
      } else if (event is GetUserEvent) {
        emit(state.copWith(status: ScreenStatus.homeLoading));

        emit(state.copWith(
          status: ScreenStatus.getUser,
          user: UserDbHelper.getById(0),
        ));
      } else if (event is ChangePageEvent) {
        // currentIndex = event.index;
        pageController = PageController(initialPage: event.index);
        emit(state.copWith(status: ScreenStatus.changePage));
      } else if (event is ChangeDoneEvent) {
        // currentIndex = event.index;

        event.task.done = !event.task.done;
        TaskDbHelper.update(event.task.key, event.task);
        emit(state.copWith(status: ScreenStatus.changeDone));
      } else if (event is UpdateUserEvent) {
        emit(state.copWith(status: ScreenStatus.init));

        UserDbHelper.update(event.user.key, event.user);
        emit(state.copWith(status: ScreenStatus.updateUser));
      } else if (event is FilterpreiortyEvent) {
        emit(state.copWith(status: ScreenStatus.homeLoading));

        priorityFilter = event.priority;

        emit(state.copWith(status: ScreenStatus.filterPriority));
      } else if (event is FilterCategoryEvent) {
        emit(state.copWith(status: ScreenStatus.homeLoading));

        categoryNameFilter = event.categoryDb;

        emit(state.copWith(status: ScreenStatus.filterCategory));
      }
    });
  }
}
