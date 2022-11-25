import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tagger_app/plants/presentation/view/edit_plant_screen.dart';

import '../../../main/presentation/navigation/model/routes.dart';
import '../../domain/entities/plant.dart';

class PlantListItem extends StatelessWidget {
  const PlantListItem({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${plant.id}', style: textTheme.caption),
        title: Text(plant.name),
        onTap: () {
          log("trying to send ${plant.id}");
          Navigator.pushNamed(
              context,
              Routes.editPlantRoute,
              arguments: EditPlantScreenArguments(plant.id)
          );
        },
        dense: true,
      ),
    );
  }
}
