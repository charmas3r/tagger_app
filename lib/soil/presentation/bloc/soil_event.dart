part of 'soil_bloc.dart';

abstract class SoilEvent extends Equatable {
  const SoilEvent();
  @override
  List<Object> get props => [];
}

class FetchSoilBlendsRequested extends SoilEvent {
  const FetchSoilBlendsRequested();
}

class FetchUniqueSoilBlendRequested extends SoilEvent {
  final int id;
  const FetchUniqueSoilBlendRequested(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveSoilBlendRequested extends SoilEvent {
  final int id;
  const RemoveSoilBlendRequested(this.id);

  @override
  List<Object> get props => [id];
}

class SaveSoilBlendRequested extends SoilEvent {
  final Soil soil;
  const SaveSoilBlendRequested(this.soil);

  @override
  List<Object> get props => [soil];
}

class UpdateSoilBlendRequested extends SoilEvent {
  final Soil soil;
  const UpdateSoilBlendRequested(this.soil);

  @override
  List<Object> get props => [soil];
}