part of 'plant_bloc.dart';

abstract class PlantEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlantFetched extends PlantEvent {}