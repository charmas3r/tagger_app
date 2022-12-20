import 'package:flutter/material.dart';
import 'package:tagger_app/plants/presentation/view/edit_plant_screen.dart';
import 'package:tagger_app/plants/presentation/view/identification_settings_screen.dart';
import 'package:tagger_app/plants/presentation/view/origin_settings_screen.dart';
import 'package:tagger_app/soil/presentation/view/soil_list_screen.dart';
import '../../../../plants/presentation/view/add_plant_screen.dart';
import '../../../../plants/presentation/view/soil_settings_screen.dart';
import '../../../../soil/presentation/view/soil_builder_screen.dart';
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
      case Routes.editPlantRoute:
        final args = settings.arguments as EditPlantScreenArguments;
        return MaterialPageRoute(
            builder: (_) => EditPlantScreen(
                title: "Edit Plant Screen",
                plantId: args.plantId,
            )
        );
      case Routes.idSettingsPlantRoute:
        final args = settings.arguments as IdentificationSettingsScreenArguments;
        return MaterialPageRoute(
            builder: (_) => IdentificationSettingsScreen(
              title: "Identification Settings Screen",
              plantId: args.plantId,
            )
        );
      case Routes.historySettingsPlantRoute:
        final args = settings.arguments as OriginSettingsScreenArguments;
        return MaterialPageRoute(
            builder: (_) => OriginSettingsScreen(
              title: "Plant History",
              plantId: args.plantId,
            )
        );
      case Routes.soilSettingsPlantRoute:
        final args = settings.arguments as SoilSettingsScreenArguments;
        return MaterialPageRoute(
            builder: (_) => SoilSettingsScreen(
              title: "Soil Settings",
              soilId: args.soilId,
            )
        );
      case Routes.soilCenterRoute:
        return MaterialPageRoute(
            builder: (_) => const SoilListScreen(
              title: "Soil Center",
            )
        );
      case Routes.addSoilRoute:
        return MaterialPageRoute(
            builder: (_) => const SoilBuilderScreen(
              title: "Soil Builder Center",
            )
        );
      default:
        return null;
    }
  }
}