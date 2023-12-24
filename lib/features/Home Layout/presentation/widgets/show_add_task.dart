// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/app_images.dart';
import 'package:todo/core/utils/componetns.dart';
import 'package:todo/features/Home%20Layout/presentation/widgets/show_choose_category.dart';
import 'package:todo/features/Home%20Layout/presentation/widgets/show_choose_priority.dart';
import 'package:todo/features/Home%20Layout/presentation/widgets/show_choose_time.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/home_layout_bloc.dart';

showAddTask(
    TextEditingController title,
    TextEditingController description,
    BuildContext context,
    VoidCallback onTab,
    categories,
    HomeLayoutBloc bloc,
    local) {
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
                  strings.add,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Positioned(
                top: 69.h,
                left: 24.w,
                child: Components.customTextField(context,
                    hint: strings.title, controller: title),
              ),
              Positioned(
                top: 125.h,
                left: 24.w,
                child: Components.customTextField(context,
                    hint: strings.description, controller: description),
              ),
              Positioned(
                top: 187.h,
                left: 327.w,
                child: IconButton(
                  icon: Image.asset(
                    AppImages.send,
                    color: colorss.secondary,
                    filterQuality: FilterQuality.high,
                  ),
                  onPressed: onTab,
                ),
              ),
              Positioned(
                top: 187.h,
                left: 136.w,
                child: IconButton(
                  icon: Image.asset(
                    AppImages.flag,
                    color: Theme.of(context).cardColor,
                    filterQuality: FilterQuality.high,
                  ),
                  onPressed: () {
                    showChoosePriority(context, bloc);
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
                    filterQuality: FilterQuality.high,
                  ),
                  onPressed: () {
                    showChooseCategory(context, categories, bloc);
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
                    filterQuality: FilterQuality.high,
                  ),
                  onPressed: () async {
                    DateTime date = await showChooseDate(context, local);

                    TimeOfDay hour = await showChooseTime(context);
                    bloc.add(ChooseTimeEvent(
                        time: date.copyWith(
                            hour: hour.hour, minute: hour.minute)));
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
