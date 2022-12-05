import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';
import 'package:tagger_app/plants/domain/entities/container.dart';
import 'package:tagger_app/plants/domain/entities/identification.dart';
import 'package:tagger_app/plants/domain/entities/soil.dart';
import 'package:tagger_app/plants/domain/entities/water.dart';

import 'climate.dart';
import 'fertilizer.dart';
import 'origin.dart';

@Entity()
class Plant extends Equatable {
  @Id()
  int id = 0;
  ToOne<Identification> identification = ToOne<Identification>();
  final int createDate;
  int acquireDate = 0;
  ToOne<Origin> origin = ToOne<Origin>();
  ToOne<Container> container = ToOne<Container>();
  ToOne<Soil> soil = ToOne<Soil>();
  ToOne<Climate> climate = ToOne<Climate>();
  ToOne<Water> water = ToOne<Water>();
  ToOne<Fertilizer> fertilizer = ToOne<Fertilizer>();

  Plant(
    this.createDate,
  );

  // const Plant(
  //   this.id,
  //   this.name,
  //   this.identification,
  //   this.createDate,
  //   this.acquireDate,
  //   this.origin,
  //   this.container,
  //   this.soil,
  //   this.climate,
  //   this.water,
  // );

  // Plant copyWith({
  //   int? id,
  //   String? name,
  //   Identification? identification,
  //   int? createDate,
  //   int? acquireDate,
  //   Origin? origin,
  //   Container? container,
  //   Soil? soil,
  //   Climate? climate,
  //   Water? water,
  // }) {
  //   return Plant(
  //     id ?? this.id,
  //     name ?? this.name,
  //     identification ?? this.identification,
  //     createDate ?? this.createDate,
  //     acquireDate ?? this.acquireDate,
  //     origin ?? this.origin,
  //     container ?? this.container,
  //     soil ?? this.soil,
  //     climate ?? this.climate,
  //     water ?? this.water,
  //   );
  // }

  @override
  List<Object?> get props => [
        id,
        identification,
        createDate,
        acquireDate,
        origin,
        container,
        soil,
        climate,
        water,
      ];

  @override
  String toString() {
    return '''
      Plant { 
        id: $id,
        identification: ${identification.toString()}
        createDate: $createDate,
        acquireDate: $acquireDate,
        origin: ${origin.toString()},
        container: ${container.toString()},
        soil: ${soil.toString()},
        climate: ${climate.toString()},
        water: ${water.toString()},
      }
    ''';
  }
}
