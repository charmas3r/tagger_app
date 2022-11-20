import 'package:tagger_app/plants/data/repository/plant_repository.dart';

import '../../../core/base/use_case.dart';
import '../../../core/data/model/result.dart';

class RemovePlantUseCase implements UseCase<Result, void> {
  final PlantRepository plantRepository;
  final int plantId;

  const RemovePlantUseCase({
    required this.plantRepository,
    required this.plantId,
  });

  @override
  Future<Result> call({params}) {
    return plantRepository.removePlant(plantId);
  }
}
