import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Origin extends Equatable {
  @Id()
  int id = 0;
  bool isSeedling = false;
  String vendor = "";

  @override
  List<Object?> get props => [
        id,
        isSeedling,
        vendor,
      ];

  @override
  String toString() {
    return '''Origin { id: $id, isSeedling: $isSeedling, vendor: $vendor,}''';
  }
}
