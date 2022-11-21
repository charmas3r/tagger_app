import 'package:flutter/material.dart';

import '../../domain/entities/plant.dart';

class PlantListItem extends StatelessWidget {
  const PlantListItem({Key? key, required this.plant}): super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${plant.id}', style: textTheme.caption),
        title: Text(plant.name),
        dense: true,
      ),
    );
  }
}
