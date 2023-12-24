// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todo/core/cache/hive_helper/helper.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class History extends StatefulWidget {
  const History(this.isCompleted, {super.key});
  final bool isCompleted;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> ls = widget.isCompleted
        ? CompletedTaskHelper.getAll()
        : PendedTaskHelper.getAll();
    Map<String, int> counter = {};
    List<String> lss = [];
    for (var ele in ls) {
      lss.add(ele.name);
    }
    lss.sort();
    int count = 1;
    for (var ele in lss) {
      if (!counter.containsKey(ele)) {
        count = 1;
        counter.addAll({ele: count});
      } else if (counter.containsKey(ele)) {
        count++;
        counter.addAll({ele: count});
      }
    }

    final strings = AppLocalizations.of(context)!;

    final String title =
        widget.isCompleted ? strings.completedtasks : strings.pendedtasks;
    final colorss = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            style: IconButton.styleFrom(fixedSize: Size(28.w, 28.h)),
            onPressed: () {
              if (widget.isCompleted) {
                CompletedTaskHelper.cler();
              } else {
                PendedTaskHelper.cler();
              }

              setState(() {});
            },
            icon: Icon(Icons.delete, color: Colors.red, size: 28.r),
          ),
          SizedBox(width: 25.w),
        ],
      ),
      body: Center(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final String name = counter.keys.toList()[index];
            return Container(
              height: 50.h,
              width: 300.w,
              color: colorss.onPrimary,
              child: Row(
                children: [
                  SizedBox(width: 25.w),
                  Text(name, style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  Text('(${counter[name]} ${strings.times})',
                      style: Theme.of(context).textTheme.titleMedium),
                  IconButton(
                    style: IconButton.styleFrom(fixedSize: Size(16.w, 16.h)),
                    onPressed: () {
                      List keysToDelete = [];

                      if (widget.isCompleted) {
                        CompletedTaskHelper.getAll().forEach((element) {
                          if (element.name == name) {
                            keysToDelete.add(element.key);
                          }
                        });

                        CompletedTaskHelper.delete(keysToDelete);
                      }

                      PendedTaskHelper.getAll().forEach((element) {
                        if (element.name == name) {
                          keysToDelete.add(element.key);
                        }
                      });

                      PendedTaskHelper.delete(keysToDelete);

                      setState(() {});
                    },
                    icon: Icon(Icons.delete, color: Colors.red, size: 16.r),
                  ),
                  SizedBox(width: 25.w),
                ],
              ),
            );
          },
          separatorBuilder: ((context, index) {
            return SizedBox(height: 10.h);
          }),
          itemCount: counter.length,
        ),
      ),
    );
  }
}
