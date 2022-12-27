import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';
import 'package:tagger_app/soil/domain/entities/soil.dart';

@Entity()
class SoilMedium extends Equatable {
  @Id()
  int id = 0;
  String medium = "Peat";
  int part = 1;

  ToOne<Soil> soil = ToOne<Soil>();

  @override
  List<Object?> get props => [
        id,
        medium,
        part,
        soil,
      ];

  @override
  String toString() {
    return '''SoilMedium { id: $id, medium: $medium, part: $part, }''';
  }

  SoilMedium({
    required String medium,
    required int part,
  });

  SoilMedium copyWith({
    String? medium,
    int? part,
  }) {
    return SoilMedium(
      medium: medium ?? this.medium,
      part: part ?? this.part,
    );
  }
}
