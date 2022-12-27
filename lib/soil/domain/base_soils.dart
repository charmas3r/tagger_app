import 'package:tagger_app/soil/domain/entities/builder/soil_builder.dart';
import 'package:tagger_app/soil/domain/entities/soil_medium.dart';

import 'entities/soil.dart';

class BaseSoilProvider {
  BaseSoilProvider();

  List<Soil> getBaseSoils() {
    return [
      SoilBuilder()
          .setSoilName("David Konishi Plumeria Mix")
          .setPh(6.5)
          .addSoilMedium(SoilMedium(medium: "Coir", part: 1))
          .addSoilMedium(SoilMedium(medium: "Perlite", part: 1))
          .create(),
    ];
  }
}
