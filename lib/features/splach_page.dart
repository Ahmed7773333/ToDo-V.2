import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';

import '../config/app_routes.dart';
import '../core/utils/app_images.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({super.key});

  Future<void> _navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(
        userDbHelper.getAll().isEmpty ? Routes.login : Routes.homeLayout);
  }

  @override
  Widget build(BuildContext context) {
    _navigateToHome(context);

    return Scaffold(
      body: Center(
          child: Container(
        width: 201.w,
        height: 250.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.logo),
            fit: BoxFit.cover,
          ),
        ),
      )),
    );
  }
}
