part of 'task_details_bloc.dart';

abstract class TaskDetailsState extends Equatable {
  const TaskDetailsState();

  @override
  List<Object> get props => [];
}

class TaskDetailsInitial extends TaskDetailsState {}

class UpdateTaskState extends TaskDetailsState {}

class TaskSettedState extends TaskDetailsState {}

class SetRepeatState extends TaskDetailsState {}

class GetTaskStepsState extends TaskDetailsState {}

class DoneStepsState extends TaskDetailsState {}
