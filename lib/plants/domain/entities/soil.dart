import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

enum Amendments {
  plastic,
  terracotta,
  metal,
  cloth,
}

@entity
class Soil extends Equatable {
  @primaryKey
  final int id;
  final double ph;
  final Amendments amendments;
  final String base;

  const Soil(
    this.id,
    this.ph,
    this.amendments,
    this.base,
  );

  @override
  List<Object> get props => [
        id,
        ph,
        amendments,
        base,
      ];

  @override
  String toString() {
    return '''Soil { 
                id: $id,
                ph: $ph,
                amendments: $amendments, 
                base: $base, 
              }''';
  }
}
