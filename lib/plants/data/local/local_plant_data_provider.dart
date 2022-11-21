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
  Future<Result> updatePlant(Plant plant) async {
    try {
      return Result.success;
    } catch (e) {
      return Result.failed;
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
      return Result.success;
    } catch (e) {
      return Result.failed;
    }
  }

  Future<Result> addAll(List<Plant> plant) async {
    return Result.success;
  }
}