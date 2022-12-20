import 'dart:developer';

import 'package:tagger_app/soil/data/base/base_soil_data_provider.dart';

import '../../../core/data/db/object_box.dart';
import '../../../core/data/model/result.dart';
import '../../domain/entities/soil.dart';

class RemoteSoilDataProvider extends BaseSoilDataProvider {
  @override
  Future<Result> createSoil(Soil soil) async {
    return Result.success;
  }

  @override
  Future<Result> deleteSoil(int soilId) async {
    return Result.success;
  }

  @override
  Future<List<Soil>> fetchSoils() async {
    return List.empty();
  }

  @override
  Future<Soil?> updateSoil(Soil soil) async {
    return null;
  }
}