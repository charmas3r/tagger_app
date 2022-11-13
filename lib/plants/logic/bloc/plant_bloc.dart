import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import '../model/plant.dart';

part 'plant_event.dart';
part 'plant_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  PlantBloc({required this.httpClient}) : super(const PlantState()) {
    on<PlantFetched>(
      _onPlantFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onPlantFetched(PlantFetched event, Emitter<PlantState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PlantStatus.initial) {
        final plants = await _fetchPlants();
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
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Plant(
          map['id'] as int,
          map['title'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}