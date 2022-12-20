import 'dart:developer';

import 'package:tagger_app/soil/data/base/base_soil_data_provider.dart';

import '../../../core/data/db/object_box.dart';
import '../../../core/data/model/result.dart';
import '../../domain/entities/soil.dart';

class LocalSoilDataProvider extends BaseSoilDataProvider {
  const LocalSoilDataProvider({
    required this.database
  });

  final ObjectBox database;

  @override
  Future<Result> createSoil(Soil soil) async {
    try {
      final soilBox = database.store.box<Soil>();
      soilBox.put(soil);
      return Result.success;
    } catch (e) {
      return Result.failed;
    }
  }

  @override
  Future<Result> deleteSoil(int soilId) async {
    try {
      final soilBox = database.store.box<Soil>();
      final isRemoved = soilBox.remove(soilId);
      return isRemoved ? Result.success : Result.failed;
    } catch (e) {
      return Result.failed;
    }
  }

  @override
  Future<List<Soil>> fetchSoils() async {
    try {
      final soilBox = database.store.box<Soil>();
      return soilBox.getAll();
    } catch (e) {
      return List.empty();
    }
  }

  @override
  Future<Soil?> updateSoil(Soil soil) async {
    try {
      final soilBox = database.store.box<Soil>();
      soilBox.put(soil);
      return soil;
    } catch (e) {
      log("Error in updating the plant, returning null instead");
      return null;
    }
  }

  Future<Result> addAll(List<Soil> plant) async {
    return Result.success;
  }

  Soil? getSoilByUniqueId(int soilId) {
    final soilBox = database.store.box<Soil>();
    return soilBox.get(soilId);
  }
}