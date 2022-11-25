import 'package:tagger_app/plants/data/repository/plant_repository.dart';

import '../../../core/base/use_case.dart';
import '../entities/plant.dart';

class GetSavedPlantByIdUseCase implements UseCase<Plant?, int> {
  final PlantRepository plantRepository;

  const GetSavedPlantByIdUseCase({
    required this.plantRepository,
  });

  @override
  Future<Plant?> call({required int params}) {
    return plantRepository.getPlantByUniqueId(params);
  }
}
