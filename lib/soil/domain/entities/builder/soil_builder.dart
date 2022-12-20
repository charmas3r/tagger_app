import 'package:tagger_app/soil/domain/entities/builder/soil_builder_base.dart';

import '../soil.dart';
import '../soil_medium.dart';

class SoilBuilder extends SoilBuilderBase {
  @override
  Soil create() {
    return soil;
  }

  @override
  SoilBuilderBase setPh(double ph) {
    soil.ph = ph;
    return this;
  }

  @override
  SoilBuilderBase addSoilMedium(SoilMedium soilMedium) {
    soil.soilMediums.add(soilMedium);
    return this;
  }

  @override
  SoilBuilderBase setSoilName(String name) {
    soil.name = name;
    return this;
  }
}
