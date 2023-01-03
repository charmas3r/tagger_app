import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tagger_app/plants/presentation/view/edit_plant_screen.dart';
import 'package:tagger_app/resources/colors.dart';

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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Image(image: AssetImage('assets/images/tree.png')),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                '${plant.identification.target?.nickname}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary)),
                          ),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Secondary text",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: ThemeColors.dingleyGreen
                                  ))),
                        ],
                      ),
                    )),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        log("icon is tapped");
                      },
                      child: SvgPicture.asset(
                        'assets/icons/watering_icon.svg',
                        width: 32,
                        height: 32,
                      ),
                    )
                  ],
                ),
              )),
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
