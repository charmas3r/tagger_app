part of 'plant_bloc.dart';

enum PlantStatus { initial, loading, success, failure }

class PlantState extends Equatable {
  const PlantState({
    this.status = PlantStatus.initial,
    this.plants = const <Plant>[],
  });

  final List<Plant> plants;
  final PlantStatus status;


  @override
  String toString() {
    return '''PlantState { status: $status, plants: ${plants.length} }''';
  }

  @override
  List<Object> get props => [status, plants];

  PlantState copyWith({
    List<Plant>? plants,
    PlantStatus? status,
  }) {
    return PlantState(
      plants: plants ?? this.plants,
      status: status ?? this.status,
    );
  }
}