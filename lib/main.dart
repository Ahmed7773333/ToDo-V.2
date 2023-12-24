import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';
import 'package:todo/features/Settings/settings_provider.dart';

import 'core/utils/my_bloc_observer.dart';
import 'my_app.dart';

void main() async {
  await registsHive();
  Bloc.observer = MyBlocObserver();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
    ),
  ], child: MyApp()));
}
