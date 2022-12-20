import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/plants/domain/entities/plant.dart';
import 'package:tagger_app/plants/presentation/extensions/stateful_widget.dart';
import 'package:tagger_app/utils/date_utils.dart';
import '../../domain/entities/identification.dart';
import '../bloc/plant_bloc.dart';

class OriginSettingsScreen extends StatefulWidget {
  const OriginSettingsScreen(
      {Key? key, required this.title, required this.plantId})
      : super(key: key);

  final String title;
  final int plantId;

  @override
  _OriginSettingsScreen createState() => _OriginSettingsScreen(plantId);
}

class _OriginSettingsScreen extends State<OriginSettingsScreen> {
  final int plantId;

  _OriginSettingsScreen(this.plantId);

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
      title: const Text("Plant History"),
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
    return BlocConsumer<PlantBloc, PlantState>(
        listener: (context, state) {},
        builder: (context, state) {
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
        title: const Text("Seedling"),
        trailing: Checkbox(
            value: plant.origin.target?.isSeedling,
            onChanged: (bool? value) {
              if (value != null) {
                plant.origin.target =
                    plant.origin.target?.copyWith(isSeedling: value);
                context.read<PlantBloc>().add(UpdatePlantRequested(plant));
              }
            }),
      ),
      ListTile(
        title: const Text("Acquire Date"),
        trailing: Text(
          formatDate(plant.origin.target?.acquireDate),
        ),
        onTap: () {
          showPlantDatePicker(
            context,
            plant.origin.target?.acquireDate,
            (DateTime val) {
              plant.origin.target =
                  plant.origin.target?.copyWith(acquireDate: val);
              context.read<PlantBloc>().add(UpdatePlantRequested(plant));
            },
          );
        },
      ),
      ListTile(
        title: const Text("Vendor"),
        trailing: Text("${plant.origin.target?.vendor}"),
        onTap: () {
          String bottomSheetTitle = "Choose a vendor name";
          String bottomSheetEditLabel = "Vendor name";
          showEditableBottomSheet(
            context,
            TextEditingController(text: '${plant.origin.target?.vendor}'),
            bottomSheetTitle,
            bottomSheetEditLabel,
            EditableBottomSheetType.string,
            (String val) {
              plant.origin.target = plant.origin.target?.copyWith(vendor: val);
              context.read<PlantBloc>().add(UpdatePlantRequested(plant));
              Navigator.of(context).pop();
            },
          );
        },
      ),
    ];
  }
}

class OriginSettingsScreenArguments {
  final int plantId;

  const OriginSettingsScreenArguments(this.plantId);
}
