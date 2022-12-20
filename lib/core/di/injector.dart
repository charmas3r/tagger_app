import 'package:get_it/get_it.dart';
import 'package:tagger_app/plants/data/local/local_plant_data_provider.dart';
import 'package:tagger_app/plants/data/remote/remote_plant_data_provider.dart';
import 'package:tagger_app/plants/data/repository/plant_repository.dart';
import 'package:tagger_app/plants/domain/usecase/remove_plant_use_case.dart';
import 'package:tagger_app/plants/domain/usecase/update_plant_use_case.dart';
import 'package:tagger_app/plants/presentation/bloc/plant_bloc.dart';
import 'package:tagger_app/soil/data/local/local_soil_data_provider.dart';
import 'package:tagger_app/soil/data/remote/remote_soil_data_provider.dart';
import 'package:tagger_app/soil/data/repository/soil_repository.dart';
import 'package:tagger_app/soil/domain/base_soils.dart';
import 'package:tagger_app/soil/domain/usecase/create_soil_blend_use_case.dart';
import 'package:tagger_app/soil/domain/usecase/get_soil_blend_by_id_use_case.dart';
import 'package:tagger_app/soil/domain/usecase/get_soil_blends_use_case.dart';
import 'package:tagger_app/soil/domain/usecase/remove_soil_blend_use_case.dart';
import 'package:tagger_app/soil/domain/usecase/update_soil_blend_use_case.dart';
import 'package:tagger_app/soil/presentation/bloc/soil_bloc.dart';

import '../../plants/domain/usecase/create_plant_use_case.dart';
import '../../plants/domain/usecase/get_saved_plant_by_id_use_case.dart';
import '../../plants/domain/usecase/get_saved_plants_use_case.dart';
import '../data/db/object_box.dart';

final injector = GetIt.instance;

Future<void> initDependencies() async {
  // db
  final database = await ObjectBox.create();
  injector.registerSingleton<ObjectBox>(database);

  // plants
  injector.registerSingleton<LocalPlantDataProvider>(
      LocalPlantDataProvider(database: database)
  );
  injector.registerSingleton<RemotePlantDataProvider>(RemotePlantDataProvider());
  injector.registerSingleton<PlantRepository>(
      PlantRepository(
        localDataProvider: injector(),
        remoteDataProvider: injector(),
      )
  );
  injector.registerSingleton<GetSavedPlantsUseCase>(
      GetSavedPlantsUseCase(plantRepository: injector())
  );
  injector.registerSingleton<CreatePlantUseCase>(
      CreatePlantUseCase(plantRepository: injector())
  );
  injector.registerSingleton<UpdatePlantUseCase>(
      UpdatePlantUseCase(plantRepository: injector())
  );
  injector.registerSingleton<GetSavedPlantByIdUseCase>(
      GetSavedPlantByIdUseCase(plantRepository: injector())
  );
  injector.registerSingleton<RemovePlantUseCase>(
      RemovePlantUseCase(plantRepository: injector())
  );
  injector.registerFactory<PlantBloc>(
        () => PlantBloc(
      getSavedPlantsUseCase: injector(),
      createPlantUseCase: injector(),
      getSavedPlantByIdUseCase: injector(),
      updatePlantUseCase: injector(),
      removePlantUseCase: injector(),
    ),
  );

  // soils
  injector.registerSingleton<LocalSoilDataProvider>(
      LocalSoilDataProvider(database: database)
  );
  injector.registerSingleton<RemoteSoilDataProvider>(RemoteSoilDataProvider());
  injector.registerSingleton<BaseSoilProvider>(BaseSoilProvider());
  injector.registerSingleton<SoilRepository>(
      SoilRepository(
        localDataProvider: injector(),
        remoteDataProvider: injector(),
        baseSoilProvider: injector(),
      )
  );

  injector.registerSingleton<GetSoilBlendsUseCase>(
      GetSoilBlendsUseCase(soilRepository: injector())
  );
  injector.registerSingleton<CreateSoilBlendUseCase>(
      CreateSoilBlendUseCase(soilRepository: injector())
  );
  injector.registerSingleton<UpdateSoilBlendUseCase>(
      UpdateSoilBlendUseCase(soilRepository: injector())
  );
  injector.registerSingleton<GetSavedSoilBlendByIdUseCase>(
      GetSavedSoilBlendByIdUseCase(soilRepository: injector())
  );
  injector.registerSingleton<RemoveSoilBlendUseCase>(
      RemoveSoilBlendUseCase(soilRepository: injector())
  );

  injector.registerFactory<SoilBloc>(
        () => SoilBloc(
      getSoilBlendsUseCase: injector(),
      createSoilBlendUseCase: injector(),
      updateSoilBlendUseCase: injector(),
      getSavedSoilBlendByIdUseCase: injector(),
      removeSoilBlendUseCase: injector(),
    ),
  );

  // utils
  injector.registerSingleton<DateTime>(
    DateTime.now()
  );
}