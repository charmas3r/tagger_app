import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:tagger_app/plants/domain/entities/identification.dart';

@entity
class Plant extends Equatable {
  @primaryKey
  final int id;
  final String name;
  final Identification identification;
  final int createDate;
  final int acquireDate;

  const Plant(
    this.id,
    this.name,
    this.identification,
    this.createDate,
    this.acquireDate,
  );

  Plant copyWith({
    int? id,
    String? name,
    Identification? identification,
    int? createDate,
    int? acquireDate,
  }) {
    return Plant(
      id ?? this.id,
      name ?? this.name,
      identification ?? this.identification,
      createDate ?? this.createDate,
      acquireDate ?? this.acquireDate,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        identification,
        createDate,
        acquireDate,
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
      }
    ''';
  }
}
