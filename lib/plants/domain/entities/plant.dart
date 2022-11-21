import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Plant extends Equatable {

  @primaryKey
  final int id;
  final String name;

  const Plant(
      this.id,
      this.name,
      );

  @override
  List<Object> get props => [id, name];
}
