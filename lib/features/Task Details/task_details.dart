// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/cache/category_db.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';
import 'package:todo/core/cache/task_db.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/core/utils/app_images.dart';
import 'package:todo/features/Task%20Details/bloc/task_details_bloc.dart';
import 'package:todo/features/Task%20Details/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../../core/cache/user_db.dart';
import '../../core/utils/componetns.dart';
import '../Settings/settings_provider.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails(this.task, {super.key});
  final TaskDb task;
  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final settingsPro = Provider.of<SettingsProvider>(context);

    final bool today = DateFormat.yMMMd(settingsPro.local.languageCode)
            .format(widget.task.time) ==
        DateFormat.yMMMd(settingsPro.local.languageCode).format(DateTime.now());
    final String date = today
        ? strings.today
        : DateFormat.yMMMd(settingsPro.local.languageCode)
            .format(widget.task.time);
    final String time =
        '$date ${strings.at} ${widget.task.time.hour}:${widget.task.time.minute}';
    final TextEditingController nameController = TextEditingController();
    return BlocProvider(
      create: (context) => TaskDetailsBloc()
        ..add(SetTaskEvent(task: widget.task))
        ..add(GetTaskSteps(id: widget.task.id)),
      child: BlocConsumer<TaskDetailsBloc, TaskDetailsState>(
        listener: (context, state) {
          if (state is UpdateTaskState) {
            setState(() {});
          }
        },
        builder: (context, state) {
          final bloc = TaskDetailsBloc.get(context);
          TextEditingController title =
              TextEditingController(text: bloc.task.title);
          TextEditingController description =
              TextEditingController(text: bloc.task.description);
          final colorss = Theme.of(context).colorScheme;

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  size: 24.r,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    bloc.task.repeat = !bloc.task.repeat;

                    bloc.add(UpdateTaskEvent(task: bloc.task));
                    bloc.add(SetTaskEvent(task: bloc.task));
                  },
                  icon: Icon(
                      bloc.task.repeat
                          ? Icons.repeat_one_rounded
                          : Icons.repeat_rounded,
                      size: 24.r),
                ),
                SizedBox(width: 15.w),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(25.r),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          style:
                              IconButton.styleFrom(fixedSize: Size(16.w, 16.h)),
                          onPressed: () async {
                            if (!bloc.task.done) {
                              bool? isSure = await sure(context);
                              if (isSure ?? false) {
                                completedTaskHelper.add(CompletedTask(
                                    time: bloc.task.time,
                                    name: bloc.task.title));
                                CategoryDb category = categoryDbHelper
                                    .getAll()
                                    .where((element) =>
                                        element.name.trim() ==
                                        bloc.task.categoryName.trim())
                                    .toList()
                                    .first;
                                dynamic catKey = category.key;
                                category.count++;
                                categoryDbHelper.update(catKey, category);
                                if (!bloc.task.repeat) {
                                  for (Stepss step in stepsHelper.getAll()) {
                                    if (step.id == bloc.task.id) {
                                      stepsHelper.delete(step.key);
                                    }
                                  }
                                  taskDbHelper.delete(bloc.task);
                                } else if (bloc.task.repeat) {
                                  bloc.task.done = !bloc.task.done;
                                  bloc.add(UpdateTaskEvent(task: bloc.task));
                                }
                                Navigator.pop(context);
                              }
                            }
                          },
                          icon: Icon(
                              bloc.task.done
                                  ? Icons.radio_button_checked_rounded
                                  : Icons.radio_button_off_rounded,
                              size: 16.r),
                        ),
                        SizedBox(width: 21.w),
                        Text(
                          bloc.task.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        IconButton(
                          style:
                              IconButton.styleFrom(fixedSize: Size(24.w, 24.h)),
                          onPressed: () {
                            showEditTask(title, description, context, () {},
                                categoryDbHelper.getAll(), bloc);
                          },
                          icon: Icon(Icons.edit, size: 24.r),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      bloc.task.description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 45.h),
                    infoRow(AppImages.clock, null, '${strings.tasktime} : ',
                        time, null, context),
                    SizedBox(height: 45.h),
                    infoRow(
                        AppImages.tag,
                        bloc.task.categoryIcon,
                        '${strings.taskcategory} :',
                        bloc.task.categoryName,
                        bloc.task.categoryColor,
                        context),
                    SizedBox(height: 45.h),
                    infoRow(AppImages.flag, null, '${strings.taskpriority} :',
                        bloc.task.priority.toString(), null, context),
                    SizedBox(height: 45.h),
                    InkWell(
                      onTap: () async {
                        String name = await showStepName(nameController);
                        Stepss step =
                            Stepss(id: bloc.task.id, name: name, done: false);
                        stepsHelper.add(step);
                        bloc.add(GetTaskSteps(id: bloc.task.id));
                        debugPrint(bloc.task.id);
                        debugPrint(step.id);
                      },
                      child: infoRow(
                          AppImages.hierarchy,
                          null,
                          '${strings.steps} :',
                          (bloc.steps.length).toString(),
                          null,
                          context),
                    ),
                    SizedBox(height: 25.h),
                    SizedBox(
                      height: ((bloc.steps.length) * 60).h,
                      width: 327.w,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            String name = bloc.steps[index].name;
                            bool done = bloc.steps[index].done;

                            return Container(
                              height: 50.h,
                              width: 300.w,
                              color: colorss.onPrimary,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    SizedBox(width: 25.w),
                                    IconButton(
                                      style: IconButton.styleFrom(
                                          fixedSize: Size(16.w, 16.h)),
                                      onPressed: () {
                                        Stepss step = stepsHelper
                                            .getById(bloc.steps[index].key)!;

                                        step.done = !step.done;
                                        stepsHelper.update(
                                            bloc.steps[index].key, step);
                                        bloc.add(DoneSteps(step: step));
                                      },
                                      icon: Icon(
                                          done
                                              ? Icons
                                                  .radio_button_checked_rounded
                                              : Icons.radio_button_off_rounded,
                                          size: 16.r),
                                    ),
                                    SizedBox(width: 25.w),
                                    Text(name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                    SizedBox(width: 35.w),
                                    IconButton(
                                      style: IconButton.styleFrom(
                                          fixedSize: Size(16.w, 16.h)),
                                      onPressed: () {
                                        stepsHelper
                                            .delete(bloc.steps[index].key);
                                        bloc.add(
                                            GetTaskSteps(id: bloc.task.id));
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Colors.red, size: 16.r),
                                    ),
                                    SizedBox(width: 25.w),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: ((context, index) {
                            return SizedBox(height: 10.h);
                          }),
                          itemCount: bloc.steps.length),
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            bool? isSure = await sure(context);
                            if (isSure ?? false) {
                              if (!bloc.task.done) {
                                pendedTaskHelper.add(PendedTask(
                                    time: bloc.task.time,
                                    name: bloc.task.title));
                              }

                              for (Stepss step in stepsHelper.getAll()) {
                                if (step.id == bloc.task.id) {
                                  stepsHelper.delete(step.key);
                                }
                              }
                              taskDbHelper.delete(bloc.task.key);

                              Navigator.pop(context);
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.delete,
                                  color: AppColors.redColor, size: 24.r),
                              SizedBox(width: 8.w),
                              Text(
                                strings.delete,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: AppColors.redColor),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            bool? isSure = await sure(context);
                            if (isSure ?? false) {
                              for (Stepss step in stepsHelper.getAll()) {
                                if (step.id == bloc.task.id) {
                                  stepsHelper.delete(step.key);
                                }
                              }
                              bloc.add(GetTaskSteps(id: bloc.task.id));
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.delete,
                                  color: AppColors.redColor, size: 24.r),
                              SizedBox(width: 8.w),
                              Text(
                                strings.deleteallsteps,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: AppColors.redColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 45.w),
                    ElevatedButton(
                      onPressed: () {
                        showEditTask(title, description, context, () {},
                            categoryDbHelper.getAll(), bloc);
                      },
                      child: Center(
                        child: Text(strings.edit,
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String> showStepName(TextEditingController name) async {
    Completer<String> completer = Completer<String>();

    await showDialog(
      context: context,
      builder: (context) {
        final strings = AppLocalizations.of(context)!;
        final colorss = Theme.of(context).colorScheme;
        return AlertDialog(
          backgroundColor: colorss.onPrimary,
          surfaceTintColor: colorss.onPrimary,
          content: Components.customTextField(
            context,
            hint: strings.setptitle,
            controller: name,
            onSubmit: () {
              completer.complete(name.text);
              name.clear();
              Navigator.pop(context);
            },
          ),
        );
      },
    );

    return completer.future;
  }
}
