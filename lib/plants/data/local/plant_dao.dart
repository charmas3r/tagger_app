import 'package:floor/floor.dart';

import '../../domain/model/plant.dart';

@dao
abstract class PlantDao {
  @Query('SELECT * FROM Plant')
  Future<List<Plant>> findAllPlants();

  @Query('SELECT * FROM Plant WHERE id = :id')
  Stream<Plant?> findPersonById(int id);

  @insert
  Future<void> insertPlant(Plant person);
}