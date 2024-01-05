// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/Settings/settings_provider.dart';
import 'package:todo/features/Task%20Details/bloc/task_details_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/cache/category_db.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/componetns.dart';

Widget infoRow(String? icon, int? iconData, String? name, String text,
    int? color, context) {
  final colorss = Theme.of(context).colorScheme;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Image.asset(icon ?? ''),
          SizedBox(width: 8.w),
          Text(name ?? '', style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: ShapeDecoration(
          color: colorss.onPrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        ),
        child: iconData == null
            ? Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 12.sp),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    IconData(iconData, fontFamily: 'MaterialIcons'),
                    size: 24.r,
                    color: Color(color ?? 0),
                  ),
                  SizedBox(width: 5.w),
                  Text(text,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 12.sp)),
                ],
              ),
      ),
    ],
  );
}

showEditTask(
    TextEditingController title,
    TextEditingController description,
    BuildContext context,
    VoidCallback onTab,
    categories,
    TaskDetailsBloc bloc) {
  final strings = AppLocalizations.of(context)!;
  final colorss = Theme.of(context).colorScheme;

  showDialog(
    context: context,
    builder: (context) => Center(
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 375.w,
          height: 228.h,
          decoration: ShapeDecoration(
            color: colorss.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.r),
              ),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 25.h,
                left: 25.w,
                child: Text(
                  strings.edit,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Positioned(
                top: 69.h,
                left: 24.w,
                child: Components.customTextField(context,
                    hint: strings.title, controller: title, onSubmit: () {
                  bloc.task.title = title.text;
                  bloc.add(UpdateTaskEvent(task: bloc.task));
                }),
              ),
              Positioned(
                top: 125.h,
                left: 24.w,
                child: Components.customTextField(context,
                    hint: strings.description,
                    controller: description, onSubmit: () {
                  bloc.task.description = description.text;
                  bloc.add(UpdateTaskEvent(task: bloc.task));
                }),
              ),
              Positioned(
                top: 187.h,
                left: 327.w,
                child: IconButton(
                  icon: Image.asset(AppImages.send, color: colorss.secondary),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: 187.h,
                left: 136.w,
                child: IconButton(
                  icon: Image.asset(
                    AppImages.flag,
                    color: Theme.of(context).cardColor,
                  ),
                  onPressed: () {
                    showEditPriority(context, bloc);
                  },
                ),
              ),
              Positioned(
                top: 187.h,
                left: 80.w,
                child: IconButton(
                  icon: Image.asset(
                    AppImages.tag,
                    color: Theme.of(context).cardColor,
                  ),
                  onPressed: () {
                    showEditCategory(context, categories, bloc);
                  },
                ),
              ),
              Positioned(
                top: 187.h,
                left: 24.w,
                child: IconButton(
                  icon: Image.asset(
                    AppImages.clock,
                    color: Theme.of(context).cardColor,
                  ),
                  onPressed: () async {
                    DateTime date = await showEditDate(context, bloc.task.time);

                    TimeOfDay hour =
                        await showEditTime(context, bloc.task.time);
                    bloc.task.time =
                        date.copyWith(hour: hour.hour, minute: hour.minute);
                    bloc.add(UpdateTaskEvent(task: bloc.task));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

showEditPriority(BuildContext context, TaskDetailsBloc bloc) {
  final strings = AppLocalizations.of(context)!;
  final colorss = Theme.of(context).colorScheme;

  showDialog(
    context: context,
    builder: (context) => Center(
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 327.w,
          height: 360.h,
          decoration: ShapeDecoration(
            color: colorss.onPrimary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r)),
          ),
          child: Padding(
            padding: EdgeInsets.all(11.r),
            child: Column(
              children: [
                Text(strings.taskpriority,
                    style: Theme.of(context).textTheme.bodyLarge),
                Divider(
                  color: Colors.white,
                  thickness: 1.5.h,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: (64.w / 64.h),
                        crossAxisSpacing: 16.w),
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            bloc.task.priority = index + 1;
                            bloc.add(UpdateTaskEvent(task: bloc.task));

                            Navigator.pop(context);
                            showEditPriority(context, bloc);
                          },
                          child: Container(
                            width: 64.w,
                            height: 64.h,
                            decoration: ShapeDecoration(
                              color: bloc.task.priority == index + 1
                                  ? colorss.secondary
                                  : colorss.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.flag,
                                    color: Theme.of(context).cardColor),
                                Text('${index + 1}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall!),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: 10,
                  ),
                ),
                Row(
                  children: [
                    Components.fillButton(
                      context,
                      color: Colors.transparent,
                      text: strings.cancel,
                      onPressed: () {},
                    ),
                    Components.fillButton(
                      context,
                      color: colorss.secondary,
                      text: strings.save,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Future<DateTime> showEditDate(BuildContext context, DateTime time) async {
  final settingsPro = Provider.of<SettingsProvider>(context);
  return await showDatePicker(
        locale: settingsPro.local,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        initialDate: time,
      ) ??
      time;
}

Future<TimeOfDay> showEditTime(BuildContext context, DateTime time) async {
  return await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: time.hour, minute: time.minute)) ??
      TimeOfDay(hour: time.hour, minute: time.minute);
}

showEditCategory(
    BuildContext context, List<CategoryDb> categories, TaskDetailsBloc bloc) {
  final strings = AppLocalizations.of(context)!;
  final colorss = Theme.of(context).colorScheme;

  showDialog(
    context: context,
    builder: (context) => Center(
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 327.w,
          height: 556.h,
          decoration: ShapeDecoration(
            color: colorss.onPrimary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r)),
          ),
          child: Padding(
            padding: EdgeInsets.all(11.r),
            child: Column(
              children: [
                Text('${strings.category}: ${bloc.task.categoryName}',
                    style: Theme.of(context).textTheme.bodyLarge),
                Divider(
                  color: Colors.white,
                  thickness: 1.5.h,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            bloc.task.categoryName = categories[index].name;
                            bloc.task.categoryColor = categories[index].color;
                            bloc.task.categoryIcon = categories[index].icon;
                            bloc.add(UpdateTaskEvent(task: bloc.task));

                            Navigator.pop(context);
                            showEditCategory(context, categories, bloc);
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 64.w,
                                height: 64.h,
                                decoration: ShapeDecoration(
                                  color: Color(categories[index].color),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.r)),
                                ),
                                child: Center(
                                  child: Icon(
                                      IconData(categories[index].icon,
                                          fontFamily: 'MaterialIcons'),
                                      color: Colors.black,
                                      size: 32.r),
                                ),
                              ),
                              Text(
                                categories[index].name,
                                style: Theme.of(context).textTheme.bodySmall!,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: categories.length,
                  ),
                ),
                Row(
                  children: [
                    Components.fillButton(
                      context,
                      color: Colors.transparent,
                      text: strings.cancel,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Components.fillButton(
                      context,
                      color: colorss.secondary,
                      text: strings.save,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Future<bool?> sure(BuildContext context) async {
  Completer<bool?> completer = Completer<bool?>();
  final strings = AppLocalizations.of(context)!;
  final colorss = Theme.of(context).colorScheme;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: colorss.onPrimary,
        surfaceTintColor: colorss.onPrimary,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.h,
              child: Components.fillButton(context,
                  color: Colors.transparent,
                  text: strings.ignore, onPressed: () {
                Navigator.pop(context);
              }),
            ),
            SizedBox(
              height: 50.h,
              child: Components.fillButton(context,
                  color: Colors.transparent, text: strings.sure, onPressed: () {
                completer.complete(true);
                Navigator.pop(context);
              }),
            ),
          ],
        ),
      );
    },
  );

  return completer.future;
}
