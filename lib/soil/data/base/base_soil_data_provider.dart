
import '../../../core/data/model/result.dart';
import '../../domain/entities/soil.dart';

abstract class BaseSoilDataProvider {
  const BaseSoilDataProvider();
  Future<Result> createSoil(Soil soil) async {
    return Result.success;
  }
  Future<Soil?> updateSoil(Soil soil) async {
    return null;
  }
  Future<List<Soil>> fetchSoils() async {
    return List.empty();
  }
  Future<Result> deleteSoil(int soilId) async {
    return Result.success;
  }
}
