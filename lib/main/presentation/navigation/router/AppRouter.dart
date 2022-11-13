import 'package:flutter/material.dart';

import '../../screens/home_screen.dart';
import '../model/routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(
            title: "Home Screen",
          ),
        );
      default:
        return null;
    }
  }
}