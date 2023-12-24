import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/cache/user_db.dart';

import '../../../core/cache/hive_helper/helper.dart';
import '../../../core/cache/task_db.dart';

part 'task_details_event.dart';
part 'task_details_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {
  static TaskDetailsBloc get(context) => BlocProvider.of(context);
  TaskDb task = TaskDb(
    title: 'title',
    description: 'description',
    done: false,
    priority: 0,
    categoryColor: 0,
    categoryIcon: 0,
    categoryName: 'categoryName',
    time: DateTime.now(),
    repeat: false,
    id: 'k',
  );
  List<Stepss> steps = [];
  UserDb user = UserDbHelper.getById(0)!;
  TaskDetailsBloc() : super(TaskDetailsInitial()) {
    on<TaskDetailsEvent>((event, emit) {
      if (event is UpdateTaskEvent) {
        emit(TaskDetailsInitial());

        TaskDbHelper.update(event.task.key, event.task);
        emit(UpdateTaskState());
      } else if (event is SetTaskEvent) {
        emit(TaskDetailsInitial());
        task = event.task;
        emit(TaskSettedState());
      } else if (event is SetRepeatEvent) {
        emit(TaskDetailsInitial());
        user = event.user;
        emit(SetRepeatState());
      } else if (event is GetTaskSteps) {
        emit(TaskDetailsInitial());
        steps = StepsHelper.getAll()
            .where((element) => element.id == event.id)
            .toList();
        emit(GetTaskStepsState());
      } else if (event is DoneSteps) {
        emit(TaskDetailsInitial());
        emit(DoneStepsState());
      }
    });
  }
}
