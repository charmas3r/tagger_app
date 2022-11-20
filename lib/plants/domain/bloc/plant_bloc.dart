import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tagger_app/plants/data/repository/plant_repository.dart';

import '../model/plant.dart';

part 'plant_event.dart';
part 'plant_state.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  PlantBloc({
    required this.plantRepository,
  }) : super(const PlantState()) {
    on<PlantFetched>(
      _onPlantFetched,
    );
  }

  final PlantRepository plantRepository;

  Future<void> _onPlantFetched(PlantFetched event, Emitter<PlantState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PlantStatus.initial) {
        final plants = await plantRepository.fetchAllPlants();
        return emit(state.copyWith(
          status: PlantStatus.success,
          plants: plants,
          hasReachedMax: false,
        ));
      }
      final plants = await _fetchPlants(state.plants.length);
      emit(plants.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: PlantStatus.success,
        plants: List.of(state.plants)..addAll(plants),
        hasReachedMax: false,
      ));
    } catch (_) {
      emit(state.copyWith(status: PlantStatus.failure));
    }
  }

  Future<List<Plant>> _fetchPlants([int startIndex = 0]) async {
    return plantRepository.fetchAllPlants();
  }
}