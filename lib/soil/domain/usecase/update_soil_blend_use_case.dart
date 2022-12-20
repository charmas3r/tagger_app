import 'package:tagger_app/soil/data/repository/soil_repository.dart';

import '../../../core/base/use_case.dart';
import '../entities/soil.dart';

class UpdateSoilBlendUseCase implements UseCase<Soil?, Soil> {
  final SoilRepository soilRepository;

  const UpdateSoilBlendUseCase({
    required this.soilRepository,
  });

  @override
  Future<Soil?> call({required Soil params}) {
    return soilRepository.updateSoil(params);
  }
}
