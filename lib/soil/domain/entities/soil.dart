import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';
import 'package:tagger_app/soil/domain/entities/soil_medium.dart';

@Entity()
class Soil extends Equatable {
  @Id()
  int id = 0;
  double ph = 7.0;
  String name = "";

  @Property(type: PropertyType.date)
  DateTime mixDate = DateTime.now();

  @Backlink('soil')
  ToMany<SoilMedium> soilMediums = ToMany<SoilMedium>();

  @override
  List<Object?> get props => [
        id,
        ph,
        name,
        mixDate,
        soilMediums,
      ];

  @override
  String toString() {
    return '''Soil { id: $id, ph: name:$name, ph: $ph, mixDate: $mixDate, soilMedium: ${soilMediums.toString()}, }''';
  }

  Soil();
}
