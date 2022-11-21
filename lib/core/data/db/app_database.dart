// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../plants/data/local/plant_dao.dart';
import '../../../plants/domain/entities/plant.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Plant])
abstract class AppDatabase extends FloorDatabase {
  PlantDao get plantDao;
}