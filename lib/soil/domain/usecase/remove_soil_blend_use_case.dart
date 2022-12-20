import 'package:tagger_app/soil/data/repository/soil_repository.dart';

import '../../../core/base/use_case.dart';
import '../../../core/data/model/result.dart';

class RemoveSoilBlendUseCase implements UseCase<Result, int> {
  final SoilRepository soilRepository;

  const RemoveSoilBlendUseCase({
    required this.soilRepository,
  });

  @override
  Future<Result> call({required int params}) {
    return soilRepository.removeSoil(params);
  }
}
