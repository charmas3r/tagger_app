import 'package:tagger_app/plants/data/repository/plant_repository.dart';

import '../../../core/base/use_case.dart';
import '../../../core/data/model/result.dart';
import '../entities/plant.dart';

class UpdatePlantUseCase implements UseCase<Plant?, Plant> {
  final PlantRepository plantRepository;

  const UpdatePlantUseCase({
    required this.plantRepository,
  });

  @override
  Future<Plant?> call({required Plant params}) {
    return plantRepository.updatePlant(params);
  }
}
