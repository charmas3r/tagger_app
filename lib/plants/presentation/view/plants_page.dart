import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/plants/presentation/view/plants_list.dart';

import '../../../core/di/injector.dart';
import '../bloc/plant_bloc.dart';

class PlantsPage extends StatefulWidget {
  const PlantsPage({Key? key}) : super(key: key);

  @override
  _PlantsPageState createState() => _PlantsPageState();
}

class _PlantsPageState extends State<PlantsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlantBloc>(
    create: (_) => injector()..add(const PlantFetched()),
    child: const PlantsList(),
    );
  }
}