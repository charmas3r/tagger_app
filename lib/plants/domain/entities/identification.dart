import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Identification extends Equatable {
  @Id()
  int id = 0;
  String nickname = "";
  String cultivar = "";
  String species = "";
  String genus = "Plumeria L.";
  String family = "Apocynaceae";

  Identification({
    required this.nickname,
    required this.cultivar,
    required this.species,
  });

  @override
  List<Object> get props => [
        id,
        nickname,
        cultivar,
        species,
        genus,
        family,
      ];

  @override
  String toString() {
    return '''Identification { id: $id, nickname: $nickname, cultivar: $cultivar, species: $species, genus: $genus}''';
  }

  Identification copyWith({
    int? id,
    String? nickname,
    String? cultivar,
    String? species,
  }) {
    return Identification(
      nickname: nickname ?? this.nickname,
      cultivar: cultivar ?? this.cultivar,
      species: species ?? this.species,
    );
  }
}
