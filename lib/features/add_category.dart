// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/cache/category_db.dart';
import 'package:todo/core/utils/componetns.dart';
import 'package:todo/features/Home%20Layout/presentation/bloc/home_layout_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCategory extends StatefulWidget {
  const AddCategory(this.bloc, {super.key});
  final HomeLayoutBloc bloc;
  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController controller = TextEditingController();
  Icon? _icon;

  final List<Color?> colors = [
    Colors.pink[300],
    Colors.purple,
    Colors.red,
    Colors.blue,
    Colors.teal[400],
    Colors.green,
    Colors.yellow,
    const Color(0xFF9C0D38),
    const Color(0xFF003366),
    const Color(0xFF004225),
    const Color(0xFF8C7000),
    const Color(0xFF4C1130),
    const Color(0xFF8C5400),
    const Color(0xFF004D4D),
    const Color(0xFF8C0058),
    const Color(0xFF331A00),
    const Color(0xFF333333),
    const Color(0xFF005C5C),
    const Color(0xFF2D882D),
    const Color(0xFF001F3F),
    const Color(0xFF8C7300),
    const Color(0xFF2E0854),
  ];
  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    _icon = Icon(icon, color: Theme.of(context).canvasColor);
    setState(() {});
  }

  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final colorss = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 25.h, left: 25.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(strings.createnewcategory,
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 20.h),
              Text('${strings.categoryname} :',
                  style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 10.h),
              Card(
                color: Colors.transparent,
                elevation: 0,
                child: Components.customTextField(context,
                    hint: strings.categoryname,
                    controller: controller, onChange: () {
                  setState(() {});
                }),
              ),
              SizedBox(height: 32.h),
              Text('${strings.categoryicon} :',
                  style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 16.h),
              _icon == null
                  ? FilledButton(
                      onPressed: _pickIcon,
                      child: Center(
                        child: Text(
                          strings.chooseiconfromlibrary,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    )
                  : IconButton(onPressed: _pickIcon, icon: _icon!),
              SizedBox(height: 20.h),
              Text('${strings.categorycolor} :',
                  style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 16.h),
              SizedBox(
                height: 36.h,
                width: 351.w,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            color = colors[index] ?? Colors.white;
                            setState(() {});
                          },
                          child: Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: ShapeDecoration(
                              color: colors[index],
                              shape: const OvalBorder(),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 12.w);
                    },
                    itemCount: colors.length),
              ),
              SizedBox(height: 50.h),
              Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: ShapeDecoration(
                    color: color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _icon ??
                          Icon(
                            Icons.question_mark_rounded,
                            size: 24.r,
                          ),
                      SizedBox(width: 5.w),
                      Text(controller.text,
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 300.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Components.fillButton(context,
                      color: Colors.transparent,
                      text: strings.cancel, onPressed: () {
                    Navigator.pop(context);
                  }),
                  Components.fillButton(context,
                      color: colorss.secondary,
                      text: strings.create, onPressed: () {
                    CategoryDb category = CategoryDb(
                        name: controller.text,
                        icon: _icon!.icon!.codePoint,
                        color: color.value,
                        count: 0);
                    widget.bloc.add(AddCategoryEvent(category: category));
                    controller.clear();
                    widget.bloc.add(GetAllCategoriesEvent());
                    widget.bloc.add(ChooseCategoryEvent(categoryDb: category));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
