
import '../../../core/data/model/result.dart';
import '../../domain/entities/plant.dart';

abstract class BasePlantDataProvider {
  const BasePlantDataProvider();
  Future<Result> createPlant(Plant plant) async {
    return Result.success;
  }
  Future<Result> updatePlant(Plant plant) async {
    return Result.success;
  }
  Future<List<Plant>> fetchPlants() async {
    return List.empty();
  }
  Future<Result> deletePlant(int plantId) async {
    return Result.success;
  }
}
