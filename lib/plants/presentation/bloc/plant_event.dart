part of 'plant_bloc.dart';

abstract class PlantEvent extends Equatable {
  const PlantEvent();
  @override
  List<Object> get props => [];
}

class PlantFetched extends PlantEvent {
  const PlantFetched();
}
class PlantSaved extends PlantEvent {
  final Plant plant;
  const PlantSaved(this.plant);

  @override
  List<Object> get props => [plant];
}