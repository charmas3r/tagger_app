import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

enum Material {
  plastic,
  terracotta,
  metal,
  cloth,
}

@entity
class Container extends Equatable {
  @primaryKey
  final int id;
  final int size;
  final Material material;
  final int startDate;
  final int endDate;

  const Container(
    this.id,
    this.size,
    this.material,
    this.startDate,
    this.endDate,
  );

  @override
  List<Object> get props => [
        id,
        size,
        material,
        startDate,
        endDate,
      ];

  @override
  String toString() {
    return '''Container { 
                id: $id,
                size: $size,
                material: $material, 
                startDate: $startDate, 
                endDate: $endDate
              }''';
  }
}
