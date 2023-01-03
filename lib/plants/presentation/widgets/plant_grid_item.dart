import 'package:flutter/material.dart';
import 'package:tagger_app/plants/presentation/view/edit_plant_screen.dart';

import '../../../main/presentation/navigation/model/routes.dart';
import '../../domain/entities/plant.dart';

class PlantGridItem extends StatelessWidget {
  const PlantGridItem({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(context, Routes.editPlantRoute,
            arguments: EditPlantScreenArguments(plant.id))
      },
        child: GridTile(
          child: Card(
            color: Theme.of(context).colorScheme.tertiary,
            child: Column(
              children: const [
              Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                width: 180,
                height: 160,
                child: Image(
                  image: AssetImage('assets/images/basic_tree_grid_photo.webp'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 12),
            Text("Some title"),
              ],
            ),
        ),
      ),
    );

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
