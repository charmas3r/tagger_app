part of 'plant_bloc.dart';

enum PlantStatus { initial, success, failure }

class PlantState extends Equatable {
  const PlantState({
    this.status = PlantStatus.initial,
    this.plants = const <Plant>[],
    this.hasReachedMax = false,
  });

  final PlantStatus status;
  final List<Plant> plants;
  final bool hasReachedMax;

  PlantState copyWith({
    PlantStatus? status,
    List<Plant>? plants,
    bool? hasReachedMax,
  }) {
    return PlantState(
      status: status ?? this.status,
      plants: plants ?? this.plants,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PlantState { status: $status, hasReachedMax: $hasReachedMax, plants: ${plants.length} }''';
  }

  @override
  List<Object> get props => [status, plants, hasReachedMax];
}