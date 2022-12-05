import 'dart:developer';

import '../../../core/data/db/object_box.dart';
import '../../../core/data/model/result.dart';
import '../../domain/entities/plant.dart';
import '../base/base_plant_data_provider.dart';

class LocalPlantDataProvider extends BasePlantDataProvider {
  const LocalPlantDataProvider({
    required this.database
  });

  final ObjectBox database;

  @override
  Future<Result> createPlant(Plant plant) async {
    try {
      final plantBox = database.store.box<Plant>();
      plantBox.put(plant);
      return Result.success;
    } catch (e) {
      return Result.failed;
    }
  }

  @override
  Future<Plant?> updatePlant(Plant plant) async {
    try {
      final plantBox = database.store.box<Plant>();
      plantBox.put(plant);
      return plant;
    } catch (e) {
      log("Error in updating the plant, returning null instead");
      return null;
    }
  }

  @override
  Future<List<Plant>> fetchPlants() async {
    try {
      final plantBox = database.store.box<Plant>();
      return plantBox.getAll();
    } catch (e) {
      return List.empty();
    }
  }

  @override
  Future<Result> deletePlant(int plantId) async {
    try {
      final plantBox = database.store.box<Plant>();
      final isRemoved = plantBox.remove(plantId);
      return isRemoved ? Result.success : Result.failed;
    } catch (e) {
      return Result.failed;
    }
  }

  Future<Result> addAll(List<Plant> plant) async {
    return Result.success;
  }

  Plant? getPlantByUniqueId(int plantId) {
    final plantBox = database.store.box<Plant>();
    return plantBox.get(plantId);
  }
}
