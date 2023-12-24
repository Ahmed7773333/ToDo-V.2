// ignore_for_file: must_be_immutable

part of 'home_layout_bloc.dart';

enum ScreenStatus {
  init,
  homeLoading,
  searchLoading,
  addTaskState,
  taskAdded,
  categoryAdded,
  getTasks,
  getCategories,
  chooseCategory,
  choosePriority,
  chooseTime,
  taskAtDay,
  getUser,
  changePage,
  changeDone,
  updateUser,
  filteredTask,
  filterCategory,
  filterPriority,
  getCompletedTasks,
}

@immutable
class HomeLayoutState {
  ScreenStatus? status;
  Failures? failures;
  List<TaskDb>? tasks;
  List<TaskDb>? tasksAtDay;
  List<TaskDb>? completedTasks;

  UserDb? user;
  List<CategoryDb>? categories;

  HomeLayoutState(
      {this.status,
      this.tasks,
      this.tasksAtDay,
      this.user,
      this.categories,
      this.failures,
      this.completedTasks});

  HomeLayoutState copWith(
      {ScreenStatus? status,
      List<TaskDb>? tasks,
      List<TaskDb>? tasksAtDay,
      List<CategoryDb>? categories,
      List<TaskDb>? completedTasks,
      UserDb? user,
      Failures? failures}) {
    return HomeLayoutState(
      failures: failures ?? this.failures,
      tasks: tasks ?? this.tasks,
      tasksAtDay: tasksAtDay ?? this.tasksAtDay,
      status: status ?? this.status,
      categories: categories ?? this.categories,
      user: user ?? this.user,
      completedTasks: completedTasks ?? this.completedTasks,
    );
  }
}

class HomeLayoutInitial extends HomeLayoutState {
  HomeLayoutInitial() : super(status: ScreenStatus.init);
}
