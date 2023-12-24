// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'home_layout_bloc.dart';

abstract class HomeLayoutEvent extends Equatable {
  const HomeLayoutEvent();

  @override
  List<Object> get props => [];
}

class ShowAddTaskEvent extends HomeLayoutEvent {}

class FilterTasksEvent extends HomeLayoutEvent {
  String? categoryName;
  int? priorty;

  FilterTasksEvent({this.categoryName, this.priorty});
}

class GetAllTasksEvent extends HomeLayoutEvent {}

class GetAllTasksAtDay extends HomeLayoutEvent {
  DateTime time;
  GetAllTasksAtDay({
    required this.time,
  });
}

class GetAllCategoriesEvent extends HomeLayoutEvent {}

class GetUserEvent extends HomeLayoutEvent {}

class ChangePageEvent extends HomeLayoutEvent {
  int index;
  ChangePageEvent({
    required this.index,
  });
}

class ChooseCategoryEvent extends HomeLayoutEvent {
  ChooseCategoryEvent({required this.categoryDb});
  CategoryDb categoryDb;
}

class ChoosepreiortyEvent extends HomeLayoutEvent {
  ChoosepreiortyEvent({required this.priority});
  int priority;
}

class FilterCategoryEvent extends HomeLayoutEvent {
  FilterCategoryEvent({required this.categoryDb});
  String categoryDb;
}

class FilterpreiortyEvent extends HomeLayoutEvent {
  FilterpreiortyEvent({required this.priority});
  int priority;
}

class ChooseTimeEvent extends HomeLayoutEvent {
  ChooseTimeEvent({required this.time});
  DateTime time;
}

class AddTaskEvent extends HomeLayoutEvent {
  TaskDb task;

  AddTaskEvent({
    required this.task,
  });
}

class ChangeDoneEvent extends HomeLayoutEvent {
  TaskDb task;

  ChangeDoneEvent({
    required this.task,
  });
}

class AddCategoryEvent extends HomeLayoutEvent {
  CategoryDb category;

  AddCategoryEvent({
    required this.category,
  });
}

class UpdateUserEvent extends HomeLayoutEvent {
  UserDb user;

  UpdateUserEvent({
    required this.user,
  });
}

class GetCompletedTask extends HomeLayoutEvent {}
