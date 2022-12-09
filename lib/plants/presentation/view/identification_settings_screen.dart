import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/plants/domain/entities/plant.dart';
import 'package:tagger_app/plants/presentation/extensions/stateful_widget.dart';
import '../../domain/entities/identification.dart';
import '../bloc/plant_bloc.dart';

class IdentificationSettingsScreen extends StatefulWidget {
  const IdentificationSettingsScreen(
      {Key? key, required this.title, required this.plantId})
      : super(key: key);

  final String title;
  final int plantId;

  @override
  _IdentificationSettingsScreen createState() =>
      _IdentificationSettingsScreen(plantId);
}

class _IdentificationSettingsScreen
    extends State<IdentificationSettingsScreen> {
  final List<String> list = <String>[
    'Plumeria rubra',
    'Plumeria alba',
    'Plumeria clusioides',
    'Plumeria cubensis',
    'Plumeria ekmanii',
    'Plumeria emarginata',
    'Plumeria filifolia',
    'Plumeria inodora',
    'Plumeria krugii',
    'Plumeria lanata',
    'Plumeria montana',
    'Plumeria obtusa',
    'Plumeria pudica',
    'Plumeria sericifolia',
    'Plumeria × stenophylla',
    'Plumeria subsessilis',
    'Plumeria trinitensis',
    'Plumeria tuberculata',
    'Plumeria venosa',
  ];
  final int plantId;

  _IdentificationSettingsScreen(this.plantId);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    context.read<PlantBloc>().add(FetchPlantRequested(plantId));
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context),
        ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Identification"),
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<PlantBloc>().add(const FetchPlantsRequested());
            Navigator.of(context).pop();
          }),
    );
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    return BlocConsumer<PlantBloc, PlantState>(listener: (context, state) {
    }, builder: (context, state) {
      switch (state.status) {
        case PlantStatus.failure:
          return const Center(child: Text('failed to fetch plant'));
        case PlantStatus.success:
          return ListView(
            padding: const EdgeInsets.all(8),
            children: _buildChildren(context, state.plants.first),
          );
        case PlantStatus.loading:
        case PlantStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  List<Widget> _buildChildren(
    BuildContext context,
    Plant plant,
  ) {
    return [
      ListTile(
          title: const Text("Family"),
          trailing: Text("${plant.identification.target?.family}"),
      ),
      ListTile(
        title: const Text("Genus"),
        trailing: Text("${plant.identification.target?.genus}"),
      ),
      ListTile(
        title: const Text("Species"),
        trailing: DropdownButton<String>(
          value: plant.identification.target?.species,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
          underline: Container(
            height: 2,
              color: Theme.of(context).colorScheme.primary,
          ),
          onChanged: (String? value) {
            plant.identification.target =
                plant.identification.target?.copyWith(
                    species: value,
                );
            context
                .read<PlantBloc>()
                .add(UpdatePlantRequested(plant));
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        onTap: () {
          // route user to Identification page
        },
      ),
      ListTile(
        title: const Text("Cultivar"),
        trailing: Text("${plant.identification.target?.cultivar}"),
        onTap: () {
          String bottomSheetTitle = "Choose a cultivar name";
          String bottomSheetEditLabel = "Cultivar name";
          showEditableBottomSheet(
              context,
              plant,
              TextEditingController(text: '${plant.identification.target?.cultivar}'),
              bottomSheetTitle,
              bottomSheetEditLabel,
              (String val) {
                plant.identification.target =
                    plant.identification.target?.copyWith(
                        cultivar: val
                    );
                context
                    .read<PlantBloc>()
                    .add(UpdatePlantRequested(plant));
                Navigator.of(context).pop();
              },
          );
        },
      ),
    ];
  }
}

class IdentificationSettingsScreenArguments {
  final int plantId;

  const IdentificationSettingsScreenArguments(this.plantId);
}
