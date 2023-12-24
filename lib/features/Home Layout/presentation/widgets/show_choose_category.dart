import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/features/Home%20Layout/presentation/bloc/home_layout_bloc.dart';

import '../../../../core/cache/category_db.dart';
import '../../../../core/utils/app_animations.dart';
import '../../../../core/utils/componetns.dart';
import '../../../add_category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showChooseCategory(
    BuildContext context, List<CategoryDb> categories, HomeLayoutBloc bloc) {
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
                Text('${strings.category}: ${bloc.categoryName}',
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
                            bloc.add(ChooseCategoryEvent(
                                categoryDb: CategoryDb(
                                    name: categories[index].name,
                                    color: categories[index].color,
                                    icon: categories[index].icon,
                                    count: categories[index].count)));
                            Navigator.pop(context);
                            showChooseCategory(context, categories, bloc);
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
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: categories.length,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, TopRouting(AddCategory(bloc)));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 64.w,
                        height: 64.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF7FFFD1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r)),
                        ),
                        child: Center(
                          child: Icon(Icons.add, size: 32.r),
                        ),
                      ),
                      Text(
                        strings.create,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
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
