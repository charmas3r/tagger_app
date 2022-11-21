import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/core/data/model/result.dart';
import 'package:tagger_app/plants/domain/usecase/create_plant_use_case.dart';
import 'package:tagger_app/plants/domain/usecase/get_saved_plants_use_case.dart';

import '../../../core/bloc/bloc_with_state.dart';
import '../../domain/entities/plant.dart';

part 'plant_event.dart';
part 'plant_state.dart';

class PlantBloc extends BlocWithState<PlantEvent, PlantState> {
  final GetSavedPlantsUseCase getSavedPlantsUseCase;
  final CreatePlantUseCase createPlantUseCase;

  PlantBloc({
    required this.getSavedPlantsUseCase,
    required this.createPlantUseCase,
  }) : super(const PlantState()) {
    on<PlantFetched>(_onPlantsFetched);
    on<PlantSaved>(_onPlantSaved);
  }

  Future<void> _onPlantsFetched(PlantFetched event, Emitter<PlantState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PlantStatus.initial) {
        final plants = await getSavedPlantsUseCase.call();
        return emit(state.copyWith(
            status: PlantStatus.success,
            plants: plants,
            hasReachedMax: false,
        ));
      }
      final plants = await _fetchPlants(state.plants.length);
      return emit(plants.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: PlantStatus.success,
        plants: List.of(state.plants)..addAll(plants),
        hasReachedMax: false,
      ));
    } catch (_) {
      return emit(state.copyWith(status: PlantStatus.failure));
    }
  }

  Future<void> _onPlantSaved(PlantSaved event, Emitter<PlantState> emit) async {
    final result = await createPlantUseCase.call(params: event.plant);
    if (result == Result.success) {
      return emit(state.copyWith(status: PlantStatus.success));
    } else {
      return emit(state.copyWith(status: PlantStatus.failure));
    }
  }

  Future<List<Plant>> _fetchPlants([int startIndex = 0]) async {
    return await getSavedPlantsUseCase.call();
  }
}
