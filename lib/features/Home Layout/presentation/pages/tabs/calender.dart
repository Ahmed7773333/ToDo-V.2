import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/cache/task_db.dart';
import 'package:todo/core/utils/componetns.dart';
import 'package:todo/features/Home%20Layout/presentation/bloc/home_layout_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/cache/hive_helper/helper.dart';
import '../../../../Settings/settings_provider.dart';
import '../../widgets/task.dart';

class CalenderTab extends StatelessWidget {
  const CalenderTab(this.tasks, this.bloc, {super.key});
  final List<TaskDb> tasks;
  final HomeLayoutBloc bloc;
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final settingsPro = Provider.of<SettingsProvider>(context);
    final colors = Theme.of(context).colorScheme;
    List<TaskDb> results =
        bloc.isCompletedTasks ? tasks.where((ele) => ele.done).toList() : tasks;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(strings.calender,
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Column(
        children: [
          Container(
            height: 107.h,
            color: colors.onPrimary,
            child: EasyDateTimeLine(
              locale: settingsPro.local.languageCode,
              initialDate: bloc.initTime,
              onDateChange: (selectedDate) {
                bloc.add(GetAllTasksAtDay(time: selectedDate));
              },
              headerProps: EasyHeaderProps(
                monthPickerType: MonthPickerType.switcher,
                selectedDateFormat: SelectedDateFormat.fullDateDMonthAsStrY,
                monthStyle: Theme.of(context).textTheme.bodyLarge,
                selectedDateStyle: Theme.of(context).textTheme.bodyLarge,
              ),
              dayProps: EasyDayProps(
                dayStructure: DayStructure.dayStrDayNum,
                width: 39.w,
                height: 48.h,
                inactiveDayStyle: DayStyle(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.r)),
                      color: colors.primary),
                  dayNumStyle: Theme.of(context).textTheme.bodyLarge,
                  dayStrStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                activeDayStyle: DayStyle(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff3371FF),
                        Color(0xff8426D6),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 23.h),
          Container(
            width: 326.w,
            height: 80.h,
            decoration: ShapeDecoration(
              color: colors.onPrimary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Components.fillButton(context,
                    color: Colors.transparent,
                    text: strings.today, onPressed: () {
                  bloc.add(GetAllTasksAtDay(time: DateTime.now()));
                }),
                Components.fillButton(context,
                    color: colors.secondary,
                    text: strings.complete, onPressed: () {
                  bloc.add(GetCompletedTask());
                }),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: 327.w,
            height: 400.h,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final bool today =
                      (results[index].time.year == DateTime.now().year &&
                          results[index].time.month == DateTime.now().month &&
                          results[index].time.day == DateTime.now().day);
                  final String date = today
                      ? strings.today
                      : '${results[index].time.year}-${results[index].time.month}-${results[index].time.day}';
                  final String time =
                      '$date ${strings.at} ${results[index].time.hour}:${results[index].time.minute}';
                  final double percent = (StepsHelper.getAll()
                              .where(
                                  (element) => element.id == results[index].id)
                              .toList()
                              .isEmpty &&
                          !results[index].done)
                      ? 0
                      : results[index].done
                          ? 100
                          : ((StepsHelper.getAll()
                                      .where((element) =>
                                          element.id == results[index].id)
                                      .toList()
                                      .where((element) => element.done)
                                      .length) *
                                  100) /
                              (StepsHelper.getAll()
                                  .where((element) =>
                                      element.id == results[index].id)
                                  .length);
                  return taskItem(context, results[index], bloc, time, percent);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16.h);
                },
                itemCount: results.length),
          ),
        ],
      ),
    );
  }
}
