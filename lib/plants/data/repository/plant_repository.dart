import 'dart:developer';

import 'package:tagger_app/plants/data/local/local_plant_data_provider.dart';
import 'package:tagger_app/plants/data/remote/remote_plant_data_provider.dart';

import '../../../core/data/model/result.dart';
import '../../domain/entities/plant.dart';

class PlantRepository {
  const PlantRepository({
    required this.localDataProvider,
    required this.remoteDataProvider,
  });

  final RemotePlantDataProvider remoteDataProvider;
  final LocalPlantDataProvider localDataProvider;

  Future<List<Plant>> fetchAllPlants() async {
    log("attempting to fetch plants");
    final List<Plant> remoteDataset = await remoteDataProvider.fetchPlants();
    final Result localUpdate = await localDataProvider.addAll(remoteDataset);
    if (localUpdate == Result.failed) {
      log("There's been an error fetching from remote, attempting to return local dataset");
    }
    final List<Plant> localDataset = await localDataProvider.fetchPlants();
    log("current plants in db: $localDataset");
    return localDataset;
  }

  Future<Result> removePlant(int plantId) async {
    // final Result remoteResult = await remoteDataProvider.deletePlant(plantId);
    final Result localResult = await localDataProvider.deletePlant(plantId);
    return localResult;
  }

  Future<Result> createPlant(Plant plant) async {
    log("attempting to create plant in db");
    // final Result remoteResult = await remoteDataProvider.createPlant(plant);
    final Result localResult = await localDataProvider.createPlant(plant);
    log("result of db operation: $localResult");
    return localResult;
  }

  Future<Plant?> updatePlant(Plant plant) async {
    log("attempting to update plant in db");
    // final Result remoteResult = await remoteDataProvider.createPlant(plant);
    final Plant? localResult = await localDataProvider.updatePlant(plant);
    log("result of db operation: $localResult");
    return localResult;
  }

  Future<Plant?> getPlantByUniqueId(int plantId) async {
    return await localDataProvider.getPlantByUniqueId(plantId);
  }
}
