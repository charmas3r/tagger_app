import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

// TODO add more as needed
enum Medium {
  coir,
  perlite,
  pumice,
  peat,
}

@Entity()
class Soil extends Equatable {
  @Id()
  int id = 0;
  double ph = 7.0;
  List<Medium> amendments = [Medium.coir];
  Medium base = Medium.peat;

  @override
  List<Object?> get props => [
        id,
        ph,
        amendments,
        base,
      ];

  @override
  String toString() {
    return '''Soil { 
                id: $id,
                ph: $ph,
                amendments: ${amendments.toString()}, 
                base: $base, 
              }''';
  }
}
