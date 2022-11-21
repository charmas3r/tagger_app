import 'package:tagger_app/plants/data/repository/plant_repository.dart';

import '../../../core/base/use_case.dart';
import '../../../core/data/model/result.dart';
import '../entities/plant.dart';

class CreatePlantUseCase implements UseCase<Result, Plant> {
  final PlantRepository plantRepository;

  const CreatePlantUseCase({
    required this.plantRepository,
  });

  @override
  Future<Result> call({required Plant params}) {
    return plantRepository.createPlant(params);
  }
}
