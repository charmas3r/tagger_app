import 'package:tagger_app/soil/data/repository/soil_repository.dart';

import '../../../core/base/use_case.dart';
import '../entities/soil.dart';

class GetSavedSoilBlendByIdUseCase implements UseCase<Soil?, int> {
  final SoilRepository soilRepository;

  const GetSavedSoilBlendByIdUseCase({
    required this.soilRepository,
  });

  @override
  Future<Soil?> call({required int params}) {
    return soilRepository.getSoilByUniqueId(params);
  }
}
