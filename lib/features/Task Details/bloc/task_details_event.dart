// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

part of 'task_details_bloc.dart';

abstract class TaskDetailsEvent extends Equatable {
  const TaskDetailsEvent();

  @override
  List<Object> get props => [];
}

class UpdateTaskEvent extends TaskDetailsEvent {
  TaskDb task;

  UpdateTaskEvent({
    required this.task,
  });
}

class SetTaskEvent extends TaskDetailsEvent {
  TaskDb task;
  SetTaskEvent({
    required this.task,
  });
}

class SetRepeatEvent extends TaskDetailsEvent {
  UserDb user;
  SetRepeatEvent({
    required this.user,
  });
}

class GetTaskSteps extends TaskDetailsEvent {
  String id;
  GetTaskSteps({
    required this.id,
  });
}

class DoneSteps extends TaskDetailsEvent {
  Stepss step;
  DoneSteps({
    required this.step,
  });
}
