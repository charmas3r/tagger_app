import 'package:meta/meta.dart';

import '../soil.dart';
import '../soil_medium.dart';


abstract class SoilBuilderBase {
  @protected
  final Soil soil = Soil();

  SoilBuilderBase setPh(double ph);

  SoilBuilderBase setSoilName(String name);

  SoilBuilderBase addSoilMedium(SoilMedium soilMedium);

  Soil create();
}
