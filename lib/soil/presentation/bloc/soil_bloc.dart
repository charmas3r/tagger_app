import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/soil/domain/entities/soil.dart';
import 'package:tagger_app/soil/domain/usecase/create_soil_blend_use_case.dart';
import 'package:tagger_app/soil/domain/usecase/get_soil_blend_by_id_use_case.dart';
import 'package:tagger_app/soil/domain/usecase/get_soil_blends_use_case.dart';
import 'package:tagger_app/soil/domain/usecase/update_soil_blend_use_case.dart';

import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/data/model/result.dart';
import '../../domain/usecase/remove_soil_blend_use_case.dart';

part 'soil_event.dart';
part 'soil_state.dart';

class SoilBloc extends BlocWithState<SoilEvent, SoilState> {
  final GetSoilBlendsUseCase getSoilBlendsUseCase;
  final CreateSoilBlendUseCase createSoilBlendUseCase;
  final GetSavedSoilBlendByIdUseCase getSavedSoilBlendByIdUseCase;
  final UpdateSoilBlendUseCase updateSoilBlendUseCase;
  final RemoveSoilBlendUseCase removeSoilBlendUseCase;

  SoilBloc({
    required this.getSoilBlendsUseCase,
    required this.createSoilBlendUseCase,
    required this.getSavedSoilBlendByIdUseCase,
    required this.updateSoilBlendUseCase,
    required this.removeSoilBlendUseCase,
  }) : super(const SoilState()) {
    on<FetchSoilBlendsRequested>(_onSoilsFetched);
    on<FetchUniqueSoilBlendRequested>(_onSoilFetched);
    on<SaveSoilBlendRequested>(_onSoilSaved);
    on<UpdateSoilBlendRequested>(_onSoilUpdated);
    on<RemoveSoilBlendRequested>(_onSoilRemoved);
  }

  Future<void> _onSoilsFetched(FetchSoilBlendsRequested event,
      Emitter<SoilState> emit) async {
    try {
      final plants = await getSoilBlendsUseCase.call();
      return emit(state.copyWith(
        status: SoilStatus.success,
        soils: plants,
      ));
    } catch (_) {
      return emit(state.copyWith(status: SoilStatus.failure));
    }
  }

  Future<void> _onSoilFetched(FetchUniqueSoilBlendRequested event,
      Emitter<SoilState> emit) async {
    try {
      final soil = await getSavedSoilBlendByIdUseCase.call(params: event.id);
      if (soil != null) {
        List<Soil> soils = <Soil>[soil];
        return emit(state.copyWith(
          status: SoilStatus.success,
          soils: soils,
        ));
      } else {
        return emit(state.copyWith(status: SoilStatus.failure));
      }
    } catch (_) {
      return emit(state.copyWith(status: SoilStatus.failure));
    }
  }

  Future<void> _onSoilSaved(SaveSoilBlendRequested event,
      Emitter<SoilState> emit) async {
    try {
      final result = await createSoilBlendUseCase.call(params: event.soil);
      if (result == Result.success) {
        return emit(state.copyWith(status: SoilStatus.success));
      } else {
        return emit(state.copyWith(status: SoilStatus.failure));
      }
    } catch (_) {
      return emit(state.copyWith(status: SoilStatus.failure));
    }
  }

  Future<void> _onSoilUpdated(UpdateSoilBlendRequested event,
      Emitter<SoilState> emit) async {
    try {
      emit(state.copyWith(status: SoilStatus.loading));
      final updatedSoil = await updateSoilBlendUseCase.call(params: event.soil);
      if (updatedSoil != null) {
        List<Soil> soils = <Soil>[updatedSoil];
        return emit(state.copyWith(
          status: SoilStatus.success,
          soils: soils,
        ));
      } else {
        return emit(state.copyWith(status: SoilStatus.failure));
      }
    } catch (_) {
      return emit(state.copyWith(status: SoilStatus.failure));
    }
  }

  Future<void> _onSoilRemoved(RemoveSoilBlendRequested event,
      Emitter<SoilState> emit) async {
    try {
      final result = await removeSoilBlendUseCase.call(params: event.id);
      if (result == Result.success) {
        return emit(state.copyWith(status: SoilStatus.success));
      } else {
        return emit(state.copyWith(status: SoilStatus.failure));
      }
    } catch (_) {
      return emit(state.copyWith(status: SoilStatus.failure));
    }
  }
}