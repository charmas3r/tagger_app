import 'package:get_it/get_it.dart';
import 'package:tagger_app/plants/data/local/local_plant_data_provider.dart';
import 'package:tagger_app/plants/data/remote/remote_plant_data_provider.dart';
import 'package:tagger_app/plants/data/repository/plant_repository.dart';
import 'package:tagger_app/plants/domain/usecase/get_saved_plants_use_case.dart';

import '../plants/domain/usecase/create_plant_use_case.dart';

final injector = GetIt.instance;

Future<void> initDependencies() async {
  // plants
  injector.registerSingleton<LocalPlantDataProvider>(LocalPlantDataProvider());
  injector.registerSingleton<RemotePlantDataProvider>(RemotePlantDataProvider());
  injector.registerSingleton<PlantRepository>(
      PlantRepository(
        localDataProvider: injector(),
        remoteDataProvider: injector(),
      )
  );

  // use-case
  injector.registerSingleton<GetSavedPlantsUseCase>(
      GetSavedPlantsUseCase(plantRepository: injector())
  );
  injector.registerSingleton<CreatePlantUseCase>(
      CreatePlantUseCase(plantRepository: injector())
  );
  injector.registerSingleton<GetSavedPlantsUseCase>(
      GetSavedPlantsUseCase(plantRepository: injector())
  );
}