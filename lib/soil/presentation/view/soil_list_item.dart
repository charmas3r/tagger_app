
import 'package:flutter/material.dart';
import 'package:tagger_app/soil/presentation/view/soil_settings_screen.dart';

import '../../../main/presentation/navigation/model/routes.dart';
import '../../domain/entities/soil.dart';

class SoilListItem extends StatelessWidget {
  const SoilListItem({Key? key, required this.soil}) : super(key: key);

  final Soil soil;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${soil.id}', style: textTheme.caption),
        title: Text(soil.name),
        onTap: () {
          Navigator.pushNamed(context, Routes.soilSettingsRoute,
              arguments: SoilSettingsScreenArguments(soil.id));
          },
        dense: true,
      ),
    );
  }
}
