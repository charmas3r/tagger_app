import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Identification extends Equatable {
  @primaryKey
  final int id;
  final String nickname;
  final String cultivar;
  final String species;
  final String genus;

  const Identification(
    this.id,
    this.nickname,
    this.cultivar,
    this.species,
    this.genus,
  );

  @override
  List<Object> get props => [
        id,
        nickname,
        cultivar,
        species,
        genus,
      ];

  @override
  String toString() {
    return '''Identification { id: $id, nickname: $nickname, cultivar: $cultivar, species: $species, genus: $genus}''';
  }
}
