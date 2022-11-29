import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Origin extends Equatable {
  @primaryKey
  final int id;
  final bool isSeedling;
  final String vendor;

  const Origin(
    this.id,
    this.isSeedling,
    this.vendor,
  );

  @override
  List<Object> get props => [
        id,
        isSeedling,
        vendor,
      ];

  @override
  String toString() {
    return '''Origin { id: $id, isSeedling: $isSeedling, vendor: $vendor,}''';
  }
}
