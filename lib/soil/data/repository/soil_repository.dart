import 'dart:developer';

import 'package:tagger_app/soil/data/local/local_soil_data_provider.dart';
import 'package:tagger_app/soil/data/remote/remote_soil_data_provider.dart';
import 'package:tagger_app/soil/domain/base_soils.dart';

import '../../../core/data/model/result.dart';
import '../../domain/entities/soil.dart';

class SoilRepository {
  const SoilRepository({
    required this.localDataProvider,
    required this.remoteDataProvider,
    required this.baseSoilProvider,
  });

  final RemoteSoilDataProvider remoteDataProvider;
  final LocalSoilDataProvider localDataProvider;
  final BaseSoilProvider baseSoilProvider;

  Future<List<Soil>> fetchAllSoils() async {
    log("attempting to fetch soils");
    final List<Soil> remoteDataset = await remoteDataProvider.fetchSoils();
    final Result localUpdate = await localDataProvider.addAll(remoteDataset);
    if (localUpdate == Result.failed) {
      log("There's been an error fetching from remote, attempting to return local dataset");
    }
    final List<Soil> localDataset = await localDataProvider.fetchSoils();
    if (localDataset.isEmpty) {
      log("no local data - adding base blends");
      // fetch and store baseline soil blends (for now just hardcoded blends)
      // TODO [BE-PROJECT] add REST api for baseline blends
      final List<Soil> baselineDataset = baseSoilProvider.getBaseSoils();
      final Result localUpdate = await localDataProvider.addAll(baselineDataset);
      if (localUpdate == Result.failed) {
        log("There's been an error fetching from remote, attempting to return local dataset");
      }
      final List<Soil> localDataset = await localDataProvider.fetchSoils();
      log("current soils in db: $localDataset");
      return localDataset;
    }
    log("current soils in db: $localDataset");
    return localDataset;
  }

  Future<Result> removeSoil(int soilId) async {
    // final Result remoteResult = await remoteDataProvider.deletePlant(plantId);
    final Result localResult = await localDataProvider.deleteSoil(soilId);
    return localResult;
  }

  Future<Result> createSoil(Soil soil) async {
    log("attempting to create soil in db");
    // final Result remoteResult = await remoteDataProvider.createPlant(plant);
    final Result localResult = await localDataProvider.createSoil(soil);
    log("result of db operation:\n$localResult");
    return localResult;
  }

  Future<Soil?> updateSoil(Soil soil) async {
    log("attempting to update soil in db");
    // final Result remoteResult = await remoteDataProvider.createPlant(plant);
    final Soil? localResult = await localDataProvider.updateSoil(soil);
    log("result of db operation:\n$localResult");
    return localResult;
  }

  Future<Soil?> getSoilByUniqueId(int soilId) async {
    return localDataProvider.getSoilByUniqueId(soilId);
  }
}
