part of 'plant_bloc.dart';

abstract class PlantEvent extends Equatable {
  const PlantEvent();
  @override
  List<Object> get props => [];
}

class FetchPlantsRequested extends PlantEvent {
  const FetchPlantsRequested();
}

class FetchPlantRequested extends PlantEvent {
  final int id;
  const FetchPlantRequested(this.id);

  @override
  List<Object> get props => [id];
}

class SavePlantRequested extends PlantEvent {
  final Plant plant;
  const SavePlantRequested(this.plant);

  @override
  List<Object> get props => [plant];
}

class UpdatePlantRequested extends PlantEvent {
  final Plant plant;
  const UpdatePlantRequested(this.plant);

  @override
  List<Object> get props => [plant];
}