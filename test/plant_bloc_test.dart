import 'package:tagger_app/core/di/injector.dart';
import 'package:tagger_app/plants/presentation/bloc/plant_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('Plant Bloc', () {
    late PlantBloc plantBloc;

    setUp(() async {
      await initDependencies();
      plantBloc = PlantBloc(
          getSavedPlantsUseCase: injector(),
          createPlantUseCase: injector(),
          getSavedPlantByIdUseCase: injector(),
          updatePlantUseCase: injector(),
          removePlantUseCase: injector());
    });

    test('initial state status is initial', () {
      expect(plantBloc.state.status, PlantStatus.initial);
    });

    // blocTest(
    //   'emits [1] when CounterIncrementPressed is added',
    //   build: () => plantBloc,
    //   act: (bloc) => plantBloc.add(const FetchPlantsRequested()),
    //   expect: () => [plantBloc.state.status, PlantStatus.success],
    // );
  });
}
