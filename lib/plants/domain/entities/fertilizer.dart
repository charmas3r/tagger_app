import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

import 'day_schedule.dart';

@Entity()
class Fertilizer extends Equatable {
  @Id()
  int id = 0;
  int startDate = 0;
  int endDate = 0;
  ToMany<DaySchedule> days = ToMany<DaySchedule>();
  String? product;

  @override
  List<Object?> get props => [
        id,
        startDate,
        endDate,
        days,
        product,
      ];

  @override
  String toString() {
    return '''Fertilizer { 
                id: $id,
                startDate: $startDate,
                endDate: $endDate,
                days: ${days.toString()},
                product: $product,
              }''';
  }
}
