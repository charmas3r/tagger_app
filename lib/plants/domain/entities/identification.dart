import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Identification extends Equatable {
  @Id()
  int id = 0;
  String nickname = "";
  String cultivar = "";
  String species = "";
  String genus = "";

  Identification(this.nickname);

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
