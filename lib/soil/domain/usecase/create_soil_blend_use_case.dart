import 'package:tagger_app/soil/data/repository/soil_repository.dart';

import '../../../core/base/use_case.dart';
import '../../../core/data/model/result.dart';
import '../entities/soil.dart';

class CreateSoilBlendUseCase implements UseCase<Result, Soil> {
  final SoilRepository soilRepository;

  const CreateSoilBlendUseCase({
    required this.soilRepository,
  });

  @override
  Future<Result> call({required Soil params}) {
    return soilRepository.createSoil(params);
  }
}
