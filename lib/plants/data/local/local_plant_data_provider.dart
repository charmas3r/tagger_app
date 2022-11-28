import 'dart:developer';

import 'package:tagger_app/plants/data/local/plant_dao.dart';

import '../../../core/data/model/result.dart';
import '../../domain/entities/plant.dart';
import '../base/base_plant_data_provider.dart';

class LocalPlantDataProvider extends BasePlantDataProvider {
  const LocalPlantDataProvider({required this.plantDao});
  final PlantDao plantDao;

  @override
  Future<Result> createPlant(Plant plant) async {
    try {
      await plantDao.insertPlant(plant);
      return Result.success;
    } catch (e) {
      return Result.failed;
    }
  }

  @override
  Future<Plant?> updatePlant(Plant plant) async {
    try {
      await plantDao.updatePlant(plant);
      return plant;
    } catch (e) {
      log("Error in updating the plant, returning null instead");
      return null;
    }
  }

  @override
  Future<List<Plant>> fetchPlants() async {
    try {
      return await plantDao.findAllPlants();
    } catch (e) {
      return List.empty();
    }
  }

  @override
  Future<Result> deletePlant(int plantId) async {
    try {
      var deletedItem = await plantDao.deletePlant(plantId);
      return deletedItem != null ? Result.success : Result.failed;
    } catch (e) {
      return Result.failed;
    }
  }

  Future<Result> addAll(List<Plant> plant) async {
    return Result.success;
  }

  Future<Plant?> getPlantByUniqueId(int plantId) {
    return plantDao.findPlantByUniqueId(plantId);
  }
}