import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

enum Denomination {
  USD,
}

@entity
class Cost extends Equatable {
  @primaryKey
  final int id;
  final int amount;
  final String vendor;
  final Denomination denomination;

  const Cost(
    this.id,
    this.amount,
    this.vendor,
    this.denomination,
  );

  @override
  List<Object> get props => [
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
