import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgressTab extends StatefulWidget {
  const ProgressTab({super.key});

  @override
  State<ProgressTab> createState() => _ProgressTabState();
}

class _ProgressTabState extends State<ProgressTab> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  int totalTasks = max(
      pendedTaskHelper.getAll().length, completedTaskHelper.getAll().length);
  @override
  void initState() {
    super.initState();

    final barGroup4 = makeGroupData(
        3,
        pendedTaskHelper.getAll().length.toDouble(),
        completedTaskHelper.getAll().length.toDouble());

    final items = [
      barGroup4,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    int touchedIndex = -1;
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.progress,
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 207.h,
                width: 306.w,
                child: BarChart(
                  BarChartData(
                    maxY: totalTasks.toDouble() + 10,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.grey,
                        getTooltipItem: (a, b, c, d) => null,
                      ),
                      touchCallback: (FlTouchEvent event, response) {
                        if (response == null || response.spot == null) {
                          setState(() {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                          });
                          return;
                        }

                        touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                        setState(() {
                          if (!event.isInterestedForInteractions) {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                            return;
                          }
                          showingBarGroups = List.of(rawBarGroups);
                          if (touchedGroupIndex != -1) {
                            var sum = 0.0;
                            for (final rod
                                in showingBarGroups[touchedGroupIndex]
                                    .barRods) {
                              sum += rod.toY;
                            }
                            final avg = sum /
                                showingBarGroups[touchedGroupIndex]
                                    .barRods
                                    .length;

                            showingBarGroups[touchedGroupIndex] =
                                showingBarGroups[touchedGroupIndex].copyWith(
                              barRods: showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .map((rod) {
                                return rod.copyWith(
                                    toY: avg, color: Colors.purple);
                              }).toList(),
                            );
                          }
                        });
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                          reservedSize: 42,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: 1,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: const FlGridData(show: false),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(height: 25.h, width: 25.w, color: Colors.red),
                  SizedBox(width: 5.w),
                  Text(
                    ': ${strings.pendedtasks} (${pendedTaskHelper.getAll().length})',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              Row(
                children: [
                  Container(height: 25.h, width: 25.w, color: Colors.blue),
                  SizedBox(width: 5.w),
                  Text(
                    ': ${strings.completedtasks} (${completedTaskHelper.getAll().length})',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              Row(
                children: [
                  Container(height: 25.h, width: 25.w, color: Colors.purple),
                  SizedBox(width: 5.w),
                  Text(
                    ': ${strings.average} (${((pendedTaskHelper.getAll().length + completedTaskHelper.getAll().length) / 2).toStringAsFixed(1)})',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              Divider(
                thickness: 2,
                color: Theme.of(context).cardColor,
              ),
              SizedBox(
                height: 300.h,
                width: 375.w,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    startDegreeOffset: 180,
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 1,
                    centerSpaceRadius: 0,
                    sections: showingSections(touchedIndex),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(touchedIndex) {
    return categoryDbHelper
        .getAll()
        .where((element) => element.count >= 3)
        .map((e) {
      final isTouched = e == touchedIndex;
      final int maxValue = completedTaskHelper.getAll().length;
      return PieChartSectionData(
        color: Color(e.color),
        value: e.count.toDouble(),
        title: e.name,
        radius: 150.r,
        badgeWidget: Text(
          '${((e.count.toDouble() / maxValue) * 100).toStringAsFixed(1)}%\n(${e.count})',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        titleStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.black),
        titlePositionPercentageOffset: 0.75,
        badgePositionPercentageOffset: 0.39,
        borderSide: isTouched
            ? BorderSide(color: Colors.white, width: 6.w)
            : BorderSide(color: Colors.white.withOpacity(0)),
      );
    }).toList();
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    if (value % (totalTasks ~/ 6) == 0) {
      int index = (value ~/ (totalTasks ~/ 6)).toInt();
      String text = (index * (totalTasks ~/ 6)).toString();
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 0,
        child: Text(text, style: style),
      );
    }

    return Container();
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    Widget text = Text(
      AppLocalizations.of(context)!.tasks,
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Colors.red,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: Colors.blue,
          width: width,
        ),
      ],
    );
  }
}
