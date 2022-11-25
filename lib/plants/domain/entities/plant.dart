import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Plant extends Equatable {
  @primaryKey
  final int id;
  final String name;

  const Plant(this.id, this.name);

  Plant copyWith({
    int? id,
    String? name,
  }) {
    return Plant(
      id ?? this.id,
      name ?? this.name,
    );
  }

  @override
  List<Object> get props => [id, name];

  @override
  String toString() {
    return '''Plant { id: $id, name: $name }''';
  }
}
