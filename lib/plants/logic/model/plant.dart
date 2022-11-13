import 'package:equatable/equatable.dart';

class Plant extends Equatable {
  const Plant(
      this.id,
      this.name,
      );

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
