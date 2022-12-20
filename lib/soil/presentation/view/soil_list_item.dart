
import 'package:flutter/material.dart';

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

        },
        dense: true,
      ),
    );
  }
}
