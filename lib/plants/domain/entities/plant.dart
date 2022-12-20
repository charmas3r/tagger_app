import 'package:objectbox/objectbox.dart';
import 'package:tagger_app/plants/domain/entities/container.dart';
import 'package:tagger_app/plants/domain/entities/identification.dart';
import 'package:tagger_app/plants/domain/entities/water.dart';

import 'climate.dart';
import 'fertilizer.dart';
import 'origin.dart';

@Entity()
class Plant {
  @Id()
  int id = 0;
  int soilId = 0;
  ToOne<Identification> identification = ToOne<Identification>();
  final int createDate;
  ToOne<Origin> origin = ToOne<Origin>();
  ToOne<Container> container = ToOne<Container>();
  ToOne<Climate> climate = ToOne<Climate>();
  ToOne<Water> water = ToOne<Water>();
  ToOne<Fertilizer> fertilizer = ToOne<Fertilizer>();

  Plant(
    this.createDate,
  );

  @override
  String toString() {
    return '''
      Plant { 
        id: $id,
        identification: ${identification.target.toString()}
        createDate: $createDate,
        origin: ${origin.target.toString()},
        container: ${container.target.toString()},
        soilId: $soilId,
        climate: ${climate.target.toString()},
        water: ${water.target.toString()},
      }
    ''';
  }
}
