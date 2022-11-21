import 'package:flutter/material.dart';
import '../../../../plants/presentation/screens/add_plant_screen.dart';
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
      case Routes.addPlantRoute:
        return MaterialPageRoute(
            builder: (_) => const AddPlantScreen(
                title: "Add Plant Screen"
            )
        );
      default:
        return null;
    }
  }
}