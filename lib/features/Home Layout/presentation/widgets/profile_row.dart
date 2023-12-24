import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget profileRow(Widget icon, String text, VoidCallback onTab, context) {
  return InkWell(
    onTap: onTab,
    child: Row(
      children: [
        icon,
        SizedBox(width: 10.w),
        Text(text, style: Theme.of(context).textTheme.bodyLarge),
        const Spacer(),
        Icon(Icons.arrow_forward_ios_rounded, size: 24.r),
      ],
    ),
  );
}
