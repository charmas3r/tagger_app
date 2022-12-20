import 'package:tagger_app/soil/data/repository/soil_repository.dart';

import '../../../core/base/use_case.dart';
import '../../../core/data/model/result.dart';
import '../entities/soil.dart';

class GetSoilBlendsUseCase implements UseCase<List<Soil>, void> {
  final SoilRepository soilRepository;

  const GetSoilBlendsUseCase({
    required this.soilRepository,
  });

  @override
  Future<List<Soil>> call({ params}) {
    return soilRepository.fetchAllSoils();
  }
}
