import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Origin extends Equatable {
  @Id()
  int id = 0;
  bool isSeedling = false;
  String vendor = "";
  @Property(type: PropertyType.date)
  DateTime acquireDate = DateTime.now();

  @override
  List<Object?> get props => [
        id,
        isSeedling,
        vendor,
        acquireDate,
      ];

  @override
  String toString() {
    return '''Origin { id: $id, isSeedling: $isSeedling, vendor: $vendor, acquireDate: ${acquireDate.toString()}''';
  }

  Origin copyWith({
    bool? isSeedling,
    String? vendor,
    DateTime? acquireDate,
  }) {
    return Origin(
      isSeedling: isSeedling ?? this.isSeedling,
      vendor: vendor ?? this.vendor,
      acquireDate: acquireDate ?? this.acquireDate,
    );
  }

  Origin({
    required this.isSeedling,
    required this.vendor,
    required this.acquireDate,
  });
}
