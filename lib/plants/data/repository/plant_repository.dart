import 'dart:developer';

import 'package:tagger_app/plants/data/local/local_plant_data_provider.dart';
import 'package:tagger_app/plants/data/remote/remote_plant_data_provider.dart';

import '../../../core/data/model/result.dart';
import '../../domain/model/plant.dart';

class PlantRepository {
  const PlantRepository({
    required this.localDataProvider,
    required this.remoteDataProvider,
  });

  final RemotePlantDataProvider remoteDataProvider;
  final LocalPlantDataProvider localDataProvider;

  Future<List<Plant>> fetchAllPlants() async {
    final List<Plant> remoteDataset = await remoteDataProvider.fetchPlants();
    final Result localUpdate = await localDataProvider.addAll(remoteDataset);
    if (localUpdate == Result.failed) {
      log("There's been an error fetching from remote, attempting to return local dataset");
    }
    final List<Plant> localDataset = await localDataProvider.fetchPlants();
    return localDataset;
  }

  Future<Result> removePlant(int plantId) async {
    final Result remoteResult = await remoteDataProvider.deletePlant(plantId);
    final Result localResult = await localDataProvider.deletePlant(plantId);
    return localResult;
  }

  Future<Result> createPlant(Plant plant) async {
    final Result remoteResult = await remoteDataProvider.createPlant(plant);
    final Result localResult = await localDataProvider.createPlant(plant);
    return localResult;
  }
}
