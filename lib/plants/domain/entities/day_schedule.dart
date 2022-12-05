import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

import 'measurement_unit.dart';

enum DaysOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

enum RepeatOptions {
  weekly,
  biweekly,
  monthly,
  firstWeekOfMonth,
  secondWeekOfMonth,
  thirdWeekOfMonth,
  fourthWeekOfMonth,
}

@Entity()
class DaySchedule extends Equatable {
  @Id()
  int id = 0;
  DaysOfWeek dayOfWeek = DaysOfWeek.monday;
  int time = 0;
  MeasurementUnit amount = MeasurementUnit.tablespoon;
  RepeatOptions repeatOption = RepeatOptions.biweekly;

  @override
  List<Object?> get props => [
        id,
        dayOfWeek,
        time,
        amount,
        repeatOption,
      ];

  @override
  String toString() {
    return '''DaySchedule { 
                id: $id,
                day: $dayOfWeek,
                time: $time,
                amount: ${amount.toString()},
                repeat: ${repeatOption.toString()},
              }''';
  }
}
