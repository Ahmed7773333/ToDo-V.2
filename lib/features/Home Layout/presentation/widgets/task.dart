import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';
import 'package:todo/core/cache/task_db.dart';
import 'package:todo/core/cache/user_db.dart';
import 'package:todo/core/utils/app_animations.dart';
import 'package:todo/core/utils/app_images.dart';
import 'package:todo/features/Home%20Layout/presentation/bloc/home_layout_bloc.dart';
import 'package:todo/features/Task%20Details/task_details.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo/features/Task%20Details/widgets.dart';

import '../../../../core/cache/category_db.dart';

Widget taskItem(
    context, TaskDb task, HomeLayoutBloc bloc, time, double percent) {
  final colorss = Theme.of(context).colorScheme;

  return InkWell(
    onTap: () async {
      await Navigator.push(context, TopRouting(TaskDetails(task)));
      bloc.add(GetAllTasksEvent());
      bloc.add(GetAllTasksAtDay(time: task.time));
    },
    child: Container(
      width: 327.w,
      height: 72.h,
      decoration: ShapeDecoration(
        color: colorss.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12.h,
            left: 38.w,
            child: Text(
              task.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Positioned(
            top: 39.h,
            left: 38.w,
            child: Text(
              time,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
              style: IconButton.styleFrom(fixedSize: Size(16.w, 16.h)),
              onPressed: () async {
                DateTime t = task.time.copyWith(hour: 0, minute: 0);
                if (!task.done) {
                  bool? isSure = await sure(context);
                  if (isSure ?? false) {
                    completedTaskHelper
                        .add(CompletedTask(time: task.time, name: task.title));
                    CategoryDb category = categoryDbHelper
                        .getAll()
                        .where((element) =>
                            element.name.trim() == task.categoryName.trim())
                        .toList()
                        .first;
                    dynamic catKey = category.key;
                    category.count++;
                    categoryDbHelper.update(catKey, category);
                    if (task.repeat == false) {
                      for (Stepss step in stepsHelper.getAll()) {
                        if (step.id == task.id) {
                          stepsHelper.delete(step.key);
                        }
                      }
                      taskDbHelper.delete(task);
                    } else if (task.repeat) {
                      bloc.add(ChangeDoneEvent(
                        task: task,
                      ));
                    }
                    bloc.add(GetAllTasksEvent());
                    bloc.add(GetAllTasksAtDay(time: t));
                  }
                }
              },
              icon: Icon(
                  task.done
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off_rounded,
                  size: 16.r),
            ),
          ),
          Positioned(
            top: 12.h,
            left: 150.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: ShapeDecoration(
                color: Color(task.categoryColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(IconData(task.categoryIcon, fontFamily: 'MaterialIcons'),
                      size: 14.r),
                  SizedBox(width: 5.w),
                  Text(
                    task.categoryName,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 39.h,
            left: 150.w,
            child: Container(
              width: 42.w,
              height: 29.h,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF8687E7)),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.flag,
                      height: 14.h,
                      width: 14.w,
                      color: Theme.of(context).cardColor),
                  SizedBox(width: 5.w),
                  Text(
                    task.priority.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 4.h,
            right: 10.w,
            child: CircularPercentIndicator(
              radius: 31.0,
              animationDuration: 1000,
              percent: percent / 100,
              animation: true, // Change this value to set the percentage
              center: Text(
                "${percent.toStringAsFixed(1)}%", // Display the percentage as text
                style: Theme.of(context).textTheme.bodySmall,
              ),
              progressColor: colorss.secondary,
            ),
          )
        ],
      ),
    ),
  );
}
