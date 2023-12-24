import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/app_images.dart';
import 'package:todo/core/utils/componetns.dart';
import 'package:todo/features/Home%20Layout/presentation/bloc/home_layout_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showChoosePriority(BuildContext context, HomeLayoutBloc bloc) {
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
                            bloc.add(ChoosepreiortyEvent(priority: index + 1));
                            Navigator.pop(context);
                            showChoosePriority(context, bloc);
                          },
                          child: Container(
                            width: 64.w,
                            height: 64.h,
                            decoration: ShapeDecoration(
                              color: bloc.priority == index + 1
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
                                        Theme.of(context).textTheme.bodySmall),
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
                      onPressed: () {
                        bloc.add(ChoosepreiortyEvent(priority: 0));
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
