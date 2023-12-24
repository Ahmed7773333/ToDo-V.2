import 'package:flutter/material.dart';
import 'package:todo/features/Sign%20in/presentation/pages/sign_in.dart';

import '../../core/utils/app_strings.dart';
import '../../core/utils/app_styles.dart';
import '../features/Home Layout/presentation/pages/home_layout.dart';
import '../features/splach_page.dart';

class Routes {
  static const String splach = '/';
  static const String homeLayout = 'home';
  static const String login = 'login';
  static const String signUp = 'signUp';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splach:
        return MaterialPageRoute(builder: (_) => const SplachScreen());
      case Routes.homeLayout:
        return MaterialPageRoute(builder: (_) => const HomeLayout());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const SingIn());
      // case Routes.signUp:
      //   return MaterialPageRoute(builder: (_) => SignupScreen());
      default:
        return unDefinedScreen();
    }
  }

  static Route<dynamic> unDefinedScreen() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(
                  AppStrings.noRoute,
                  style: AppStyles.title,
                ),
              ),
              body: Center(
                child: Text(
                  AppStrings.noRoute,
                  style: AppStyles.title,
                ),
              ),
            ));
  }
}
