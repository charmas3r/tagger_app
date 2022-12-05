import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

enum Denomination {
  USD,
}

@Entity()
class Cost extends Equatable {
  @Id()
  int id = 0;
  int amount = 0;
  String vendor = "";
  Denomination denomination = Denomination.USD;

  @override
  List<Object?> get props => [
        id,
        amount,
        vendor,
        denomination,
      ];

  @override
  String toString() {
    return '''Cost { id: $id, amount: $amount, vendor: $vendor, denomination: $denomination}''';
  }
}
