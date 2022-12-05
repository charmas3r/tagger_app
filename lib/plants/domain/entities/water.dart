import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

import 'day_schedule.dart';

@Entity()
class Water extends Equatable {
  @Id()
  int id = 0;
  int startDate = 0;
  int endDate = 0;
  ToMany<DaySchedule> days = ToMany<DaySchedule>();

  @override
  List<Object?> get props => [
        id,
        startDate,
        endDate,
        days,
      ];

  @override
  String toString() {
    return '''Water { 
                id: $id,
                startDate: $startDate,
                endDate: $endDate,
                days: ${days.toString()},
              }''';
  }
}
