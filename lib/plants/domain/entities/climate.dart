import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

enum Domicile {
  indoor,
  outdoor,
  greenhouse,
}

@Entity()
class Climate extends Equatable {

  @Id()
  int id = 0;
  Domicile domicile = Domicile.outdoor;

  @override
  List<Object?> get props => [
        id,
        domicile,
      ];

  @override
  String toString() {
    return '''Climate { 
                id: $id,
                domicile: $domicile,
              }''';
  }
}
