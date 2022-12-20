import 'package:meta/meta.dart';
import 'package:tagger_app/core/di/injector.dart';
import 'package:tagger_app/plants/domain/entities/fertilizer.dart';
import 'package:tagger_app/plants/domain/entities/identification.dart';
import 'package:tagger_app/plants/domain/entities/origin.dart';

import '../../../../soil/domain/entities/soil.dart';
import '../container.dart';
import '../plant.dart';
import '../water.dart';

abstract class PlantBuilderBase {
  @protected
  final Plant plant = Plant(injector<DateTime>().millisecondsSinceEpoch);

  PlantBuilderBase setIdentification(Identification identification);
  PlantBuilderBase setContainer(Container container);
  PlantBuilderBase setOrigin(Origin origin);
  PlantBuilderBase setWateringSchedule(Water water);
  PlantBuilderBase setFertilizerSchedule(Fertilizer fertilizer);
  Plant create();
}