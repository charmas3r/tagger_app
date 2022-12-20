part of 'soil_bloc.dart';

enum SoilStatus { initial, loading, success, failure }

class SoilState extends Equatable {
  const SoilState({
    this.status = SoilStatus.initial,
    this.soils = const <Soil>[],
  });

  final List<Soil> soils;
  final SoilStatus status;


  @override
  String toString() {
    return '''SoilState { status: $status, soils: ${soils.length} }''';
  }

  @override
  List<Object> get props => [status, soils];

  SoilState copyWith({
    List<Soil>? soils,
    SoilStatus? status,
  }) {
    return SoilState(
      soils: soils ?? this.soils,
      status: status ?? this.status,
    );
  }
}