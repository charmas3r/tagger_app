import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/core/data/model/result.dart';
import 'package:tagger_app/plants/domain/usecase/create_plant_use_case.dart';
import 'package:tagger_app/plants/domain/usecase/get_saved_plants_use_case.dart';

import '../../../core/bloc/bloc_with_state.dart';
import '../../domain/entities/plant.dart';
import '../../domain/usecase/get_saved_plant_by_id_use_case.dart';
import '../../domain/usecase/remove_plant_use_case.dart';
import '../../domain/usecase/update_plant_use_case.dart';

part 'plant_event.dart';

part 'plant_state.dart';

class PlantBloc extends BlocWithState<PlantEvent, PlantState> {
  final GetSavedPlantsUseCase getSavedPlantsUseCase;
  final CreatePlantUseCase createPlantUseCase;
  final GetSavedPlantByIdUseCase getSavedPlantByIdUseCase;
  final UpdatePlantUseCase updatePlantUseCase;
  final RemovePlantUseCase removePlantUseCase;

  PlantBloc({
    required this.getSavedPlantsUseCase,
    required this.createPlantUseCase,
    required this.getSavedPlantByIdUseCase,
    required this.updatePlantUseCase,
    required this.removePlantUseCase,
  }) : super(const PlantState()) {
    on<FetchPlantsRequested>(_onPlantsFetched);
    on<FetchPlantRequested>(_onPlantFetched);
    on<SavePlantRequested>(_onPlantSaved);
    on<UpdatePlantRequested>(_onPlantUpdated);
    on<RemovePlantRequested>(_onPlantRemoved);
  }

  Future<void> _onPlantsFetched(FetchPlantsRequested event,
      Emitter<PlantState> emit) async {
    try {
      final plants = await getSavedPlantsUseCase.call();
      return emit(PlantState(
        status: PlantStatus.success,
        plants: plants,
      ));
    } catch (_) {
      return emit(const PlantState(status: PlantStatus.failure));
    }
  }

  Future<void> _onPlantFetched(FetchPlantRequested event,
      Emitter<PlantState> emit) async {
    try {
      final plant = await getSavedPlantByIdUseCase.call(params: event.id);
      if (plant != null) {
        List<Plant> plants = <Plant>[plant];
        return emit(PlantState(
          status: PlantStatus.success,
          plants: plants,
        ));
      } else {
        return emit(const PlantState(status: PlantStatus.failure));
      }
    } catch (_) {
      return emit(const PlantState(status: PlantStatus.failure));
    }
  }

  Future<void> _onPlantSaved(SavePlantRequested event,
      Emitter<PlantState> emit) async {
    try {
      final result = await createPlantUseCase.call(params: event.plant);
      if (result == Result.success) {
        return emit(const PlantState(status: PlantStatus.success));
      } else {
        return emit(const PlantState(status: PlantStatus.failure));
      }
    } catch (_) {
      return emit(const PlantState(status: PlantStatus.failure));
    }
  }

  Future<void> _onPlantUpdated(UpdatePlantRequested event,
      Emitter<PlantState> emit) async {
    try {
      emit(state.copyWith(status: PlantStatus.loading));
      final updatedPlant = await updatePlantUseCase.call(params: event.plant);
      if (updatedPlant != null) {
        List<Plant> plants = <Plant>[updatedPlant];
        return emit(state.copyWith(
          status: PlantStatus.success,
          plants: plants,
        ));
      } else {
        return emit(const PlantState(status: PlantStatus.failure));
      }
    } catch (_) {
      return emit(const PlantState(status: PlantStatus.failure));
    }
  }

  Future<void> _onPlantRemoved(RemovePlantRequested event,
      Emitter<PlantState> emit) async {
    try {
      final result = await removePlantUseCase.call(params: event.id);
      if (result == Result.success) {
        return emit(const PlantState(status: PlantStatus.success));
      } else {
        return emit(const PlantState(status: PlantStatus.failure));
      }
    } catch (_) {
      return emit(const PlantState(status: PlantStatus.failure));
    }
  }
}
