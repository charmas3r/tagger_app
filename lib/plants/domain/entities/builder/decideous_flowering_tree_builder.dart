import 'package:tagger_app/plants/domain/entities/builder/plant_builder_base.dart';
import 'package:tagger_app/plants/domain/entities/container.dart';
import 'package:tagger_app/plants/domain/entities/fertilizer.dart';
import 'package:tagger_app/plants/domain/entities/identification.dart';
import 'package:tagger_app/plants/domain/entities/origin.dart';
import 'package:tagger_app/plants/domain/entities/soil.dart';
import 'package:tagger_app/plants/domain/entities/water.dart';

import '../plant.dart';

class DecideousFloweringTreeBuilder extends PlantBuilderBase {
  @override
  PlantBuilderBase setContainer(Container container) {
    plant.container.target = container;
    return this;
  }

  @override
  PlantBuilderBase setFertilizerSchedule(Fertilizer fertilizer) {
    plant.fertilizer.target = fertilizer;
    return this;
  }

  @override
  PlantBuilderBase setIdentification(Identification identification) {
    plant.identification.target = identification;
    return this;
  }

  @override
  PlantBuilderBase setOrigin(Origin origin) {
    plant.origin.target = origin;
    return this;
  }

  @override
  PlantBuilderBase setSoil(Soil soil) {
    plant.soil.target = soil;
    return this;
  }

  @override
  PlantBuilderBase setWateringSchedule(Water water) {
    plant.water.target = water;
    return this;
  }

  @override
  Plant create() {
    return plant;
  }
}
