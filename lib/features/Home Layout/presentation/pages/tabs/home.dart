import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';
import 'package:todo/core/cache/task_db.dart';
import 'package:todo/core/cache/user_db.dart';
import 'package:todo/core/utils/app_images.dart';
import 'package:todo/features/Home%20Layout/presentation/widgets/task.dart';

import '../../bloc/home_layout_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTab extends StatelessWidget {
  const HomeTab(this.bloc, this.tasks, this.user, {super.key});
  final HomeLayoutBloc bloc;
  final List<TaskDb> tasks;
  final UserDb user;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    List<TaskDb> taskss =
        bloc.filteredTask.isNotEmpty ? bloc.filteredTask : tasks;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showFilter(bloc, context);
          },
          icon: Icon(Icons.sort_rounded, size: 24.r),
        ),
        title: Text(
          strings.index,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          Container(
            width: 42.w,
            height: 42.h,
            decoration: ShapeDecoration(
              shape: const OvalBorder(),
              image: DecorationImage(
                image: MemoryImage(user.image),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
      ),
      body: taskss.isEmpty
          ? SizedBox(
              width: 375.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.emptyHome),
                  SizedBox(height: 10.h),
                  Text(
                    strings.empty,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            )
          : Center(
              child: SizedBox(
                width: 327.w,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final bool today = (taskss[index].time.year ==
                              DateTime.now().year &&
                          taskss[index].time.month == DateTime.now().month &&
                          taskss[index].time.day == DateTime.now().day);
                      final String date = today
                          ? strings.today
                          : '${taskss[index].time.year}-${taskss[index].time.month}-${taskss[index].time.day}';
                      final String time =
                          '$date ${strings.at} ${taskss[index].time.hour}:${taskss[index].time.minute}';
                      final double percent = (stepsHelper
                                  .getAll()
                                  .where((element) =>
                                      element.id == taskss[index].id)
                                  .toList()
                                  .isEmpty &&
                              !taskss[index].done)
                          ? 0
                          : taskss[index].done
                              ? 100
                              : ((stepsHelper
                                          .getAll()
                                          .where((element) =>
                                              element.id == taskss[index].id)
                                          .toList()
                                          .where((element) => element.done)
                                          .length) *
                                      100) /
                                  (stepsHelper
                                      .getAll()
                                      .where((element) =>
                                          element.id == taskss[index].id)
                                      .length);
                      return taskItem(
                          context, taskss[index], bloc, time, percent);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16.h);
                    },
                    itemCount: taskss.length),
              ),
            ),
    );
  }

  showFilter(HomeLayoutBloc bloc, context) {
    final colorss = Theme.of(context).colorScheme;
    final strings = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        String categoryNameFilter = bloc.categoryNameFilter;
        int pri = bloc.priorityFilter;
        return AlertDialog(
          backgroundColor: colorss.onPrimary,
          surfaceTintColor: colorss.onPrimary,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(strings.categoryname),
              SizedBox(
                height: 50.h,
                width: 200.w, // Adjust the height as needed
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryDbHelper
                      .getAll()
                      .length, // Replace with the actual number of categories
                  separatorBuilder: (context, index) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (categoryNameFilter ==
                          categoryDbHelper.getAll()[index].name) {
                        categoryNameFilter = 'None';
                        bloc.add(FilterCategoryEvent(
                            categoryDb: categoryNameFilter));
                        Navigator.pop(context);
                        bloc.add(FilterTasksEvent(
                            categoryName: 'None',
                            priorty: bloc.priorityFilter));
                        showFilter(bloc, context);
                      } else {
                        categoryNameFilter =
                            categoryDbHelper.getAll()[index].name;
                        bloc.add(FilterCategoryEvent(
                            categoryDb: categoryNameFilter));
                        Navigator.pop(context);
                        bloc.add(FilterTasksEvent(
                            categoryName: categoryDbHelper.getAll()[index].name,
                            priorty: bloc.priorityFilter));
                        showFilter(bloc, context);
                      }
                    },
                    child: Chip(
                        backgroundColor: categoryNameFilter ==
                                categoryDbHelper.getAll()[index].name
                            ? Theme.of(context).cardColor
                            : Colors.transparent,
                        label: Text(categoryDbHelper.getAll()[index].name)),
                  ),
                  // Replace with your category logic
                ),
              ),
              SizedBox(height: 16.h),
              const Text('Priorities:'),
              SizedBox(
                height: 50.h,
                width: 200.w, // Adjust the height as needed
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (context, index) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (pri == index + 1) {
                        pri = 0;
                        bloc.add(FilterpreiortyEvent(priority: pri));
                        Navigator.pop(context);
                        bloc.add(FilterTasksEvent(
                            categoryName: bloc.categoryNameFilter,
                            priorty: pri));
                        showFilter(bloc, context);
                      } else {
                        pri = index + 1;
                        bloc.add(FilterpreiortyEvent(priority: pri));
                        Navigator.pop(context);
                        bloc.add(FilterTasksEvent(
                            categoryName: bloc.categoryNameFilter,
                            priorty: pri));
                        showFilter(bloc, context);
                      }
                    },
                    child: Chip(
                        backgroundColor: pri == index + 1
                            ? Theme.of(context).cardColor
                            : Colors.transparent,
                        label: Text('${index + 1}')),
                    // Replace with your priority logic
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(strings.save),
            ),
          ],
        );
      },
    );
  }
}
