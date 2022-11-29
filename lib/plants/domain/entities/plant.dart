import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:tagger_app/plants/domain/entities/identification.dart';

import 'origin.dart';

@entity
class Plant extends Equatable {
  @primaryKey
  final int id;
  final String name;
  final Identification identification;
  final int createDate;
  final int acquireDate;
  final Origin origin;

  const Plant(
    this.id,
    this.name,
    this.identification,
    this.createDate,
    this.acquireDate,
    this.origin,
  );

  Plant copyWith({
    int? id,
    String? name,
    Identification? identification,
    int? createDate,
    int? acquireDate,
    Origin? origin,
  }) {
    return Plant(
      id ?? this.id,
      name ?? this.name,
      identification ?? this.identification,
      createDate ?? this.createDate,
      acquireDate ?? this.acquireDate,
      origin ?? this.origin,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        identification,
        createDate,
        acquireDate,
        origin,
      ];

  @override
  String toString() {
    return '''
      Plant { 
        id: $id,
        name: $name,
        identification: ${identification.toString()}
        createDate: $createDate,
        acquireDate: $acquireDate,
        origin: $origin,
      }
    ''';
  }
}
