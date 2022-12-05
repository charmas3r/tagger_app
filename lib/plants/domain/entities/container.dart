import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

enum Material {
  plastic,
  terracotta,
  metal,
  cloth,
}

@Entity()
class Container extends Equatable {

  @Id()
  int id = 0;
  int size = 0;
  Material material = Material.plastic;
  int startDate = 0;
  int endDate = 0;

  @override
  List<Object?> get props => [
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
