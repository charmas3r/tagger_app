part of 'plant_bloc.dart';

enum PlantStatus { initial, success, failure }

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
}