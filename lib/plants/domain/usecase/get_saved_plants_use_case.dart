import 'package:tagger_app/plants/data/repository/plant_repository.dart';

import '../../../core/base/use_case.dart';
import '../entities/plant.dart';

class GetSavedPlantsUseCase implements UseCase<List<Plant>, void> {
  final PlantRepository plantRepository;

  const GetSavedPlantsUseCase({
    required this.plantRepository,
  });

  @override
  Future<List<Plant>> call({params}) {
    return plantRepository.fetchAllPlants();
  }
}
