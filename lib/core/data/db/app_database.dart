\import 'package:floor/floor.dart';

import '../../../plants/data/local/plant_dao.dart';
import '../../../plants/domain/model/plant.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Plant])
abstract class AppDatabase extends FloorDatabase {
  PlantDao get plantDao;
}