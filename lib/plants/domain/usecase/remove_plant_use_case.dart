import 'package:tagger_app/plants/data/repository/plant_repository.dart';

import '../../../core/base/use_case.dart';
import '../../../core/data/model/result.dart';

class RemovePlantUseCase implements UseCase<Result, int> {
  final PlantRepository plantRepository;

  const RemovePlantUseCase({
    required this.plantRepository,
  });

  @override
  Future<Result> call({required int params}) {
    return plantRepository.removePlant(params);
  }
}
