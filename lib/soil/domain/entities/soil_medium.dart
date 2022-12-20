import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class SoilMedium extends Equatable {
  @Id()
  int id = 0;
  String medium = "";
  int part = 0;

  @override
  List<Object?> get props => [
        id,
        medium,
        part,
      ];

  @override
  String toString() {
    return '''SoilMedium { id: $id, medium: $medium, part: $part, }''';
  }

  SoilMedium({
    required String medium,
    required int part,
  });
}
