
import '../../../core/data/model/result.dart';
import '../../domain/entities/plant.dart';
import '../base/base_plant_data_provider.dart';

class RemotePlantDataProvider extends BasePlantDataProvider {
  @override
  Future<Result> createPlant(Plant plant) async {
    return Result.success;
  }

  @override
  Future<Result> updatePlant(Plant plant) async {
    return Result.success;
  }

  @override
  Future<List<Plant>> fetchPlants() async {
    return List.empty();
  }

  @override
  Future<Result> deletePlant(int plantId) async {
    return Result.success;
  }
}
