import '../../../core/data/model/result.dart';
import '../../domain/model/plant.dart';
import '../base/base_plant_data_provider.dart';

class LocalPlantDataProvider extends BasePlantDataProvider {
  @override
  Future<Result> createPlant(Plant plant) async {
    try {
      return Result.success;
    } catch(e) {
      return Result.failed;
    }
  }

  @override
  Future<Result> updatePlant(Plant plant) async {
    try{
      return Result.success;
    } catch(e) {
      return Result.failed;
    }
  }

  @override
  Future<List<Plant>> fetchPlants() async {
    try {
      return List.empty();
    } catch(e) {
      return List.empty();
    }
  }

  @override
  Future<Result> deletePlant(int plantId) async {
    try{
      return Result.success;
    } catch(e) {
      return Result.failed;
    }
  }

  Future<Result> addAll(List<Plant> plant) async {
    return Result.success;
  }
}