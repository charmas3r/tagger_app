import 'package:floor/floor.dart';

import '../../domain/entities/plant.dart';

@dao
abstract class PlantDao {
  @Query('SELECT * FROM Plant')
  Future<List<Plant>> findAllPlants();

  @Query('SELECT * FROM Plant WHERE id = :id')
  Future<Plant?> findPlantByUniqueId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPlant(Plant plant);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatePlant(Plant plant);

  @Query('DELETE FROM Plant WHERE id = :id')
  Future<Plant?> deletePlant(int id);
}