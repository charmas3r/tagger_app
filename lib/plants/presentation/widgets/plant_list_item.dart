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
    return GestureDetector(
        onTap: () => {
              Navigator.pushNamed(context, Routes.editPlantRoute,
                  arguments: EditPlantScreenArguments(plant.id))
            },
        child: Card(
          color: Theme.of(context).colorScheme.tertiary,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Text('${plant.identification.target?.nickname}',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onTertiary)),
          ),
        ));

    //   child: ListTile(
    //     title: Text('${plant.identification.target?.nickname}',
    //         style: TextStyle(color: Theme.of(context).colorScheme.onTertiary)),
    //     onTap: () {
    //       log("trying to send ${plant.id}");
    //       Navigator.pushNamed(context, Routes.editPlantRoute,
    //           arguments: EditPlantScreenArguments(plant.id));
    //     },
    //   ),
    // );
  }
}
