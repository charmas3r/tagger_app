import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/plants/domain/entities/plant.dart';
import 'package:tagger_app/plants/presentation/extensions/stateful_widget.dart';
import 'package:tagger_app/plants/presentation/view/identification_settings_screen.dart';
import 'package:tagger_app/plants/presentation/view/origin_settings_screen.dart';
import 'package:tagger_app/plants/presentation/view/soil_settings_screen.dart';
import '../../../main/presentation/navigation/model/routes.dart';
import '../../domain/entities/identification.dart';
import '../bloc/plant_bloc.dart';

class EditPlantScreen extends StatefulWidget {
  const EditPlantScreen({Key? key, required this.title, required this.plantId})
      : super(key: key);

  final String title;
  final int plantId;

  @override
  _EditPlantScreen createState() => _EditPlantScreen(plantId);
}

class _EditPlantScreen extends State<EditPlantScreen> {
  final nickNameEditController = TextEditingController(text: "Plant nickname");
  final int plantId;

  _EditPlantScreen(this.plantId);

  @override
  void dispose() {
    nickNameEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<PlantBloc>().add(FetchPlantRequested(plantId));
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(nickNameEditController, context),
        ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Edit Plant Screen"),
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<PlantBloc>().add(const FetchPlantsRequested());
            Navigator.of(context).pop();
          }),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.delete,
          ),
          onPressed: () {
            _showAlertDialog(plantId, context);
          },
        ),
      ],
    );
  }

  void _showAlertDialog(int plantId, BuildContext pageContext) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<PlantBloc>().add(RemovePlantRequested(plantId));
              context.read<PlantBloc>().add(const FetchPlantsRequested());
              Navigator.pop(context, 'OK');
              Navigator.pop(pageContext);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    TextEditingController textEditingController,
    BuildContext context,
  ) {
    return BlocConsumer<PlantBloc, PlantState>(listener: (context, state) {
      if (state.plants.isNotEmpty) {
        textEditingController.text =
            state.plants.first.identification.target?.nickname as String;
      }
    }, builder: (context, state) {
      switch (state.status) {
        case PlantStatus.failure:
          return const Center(child: Text('failed to fetch plant'));
        case PlantStatus.success:
          return ListView(
            padding: const EdgeInsets.all(8),
            children: _buildChildren(
                textEditingController, context, state.plants.first),
          );
        case PlantStatus.loading:
        case PlantStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  List<Widget> _buildChildren(
    TextEditingController textEditingController,
    BuildContext context,
    Plant plant,
  ) {
    return [
      const ListTile(
        title: Text("General"),
        dense: true,
      ),
      ListTile(
        title: Text(textEditingController.text),
        trailing: const Icon(Icons.edit),
        onTap: () {
          String bottomSheetTitle = "Choose a nickname";
          String bottomSheetEditLabel = "Plant nickname";
          showEditableBottomSheet(
            context,
            TextEditingController(
                text: '${plant.identification.target?.nickname}'),
            bottomSheetTitle,
            bottomSheetEditLabel,
            EditableBottomSheetType.string,
            (String val) {
              plant.identification.target =
                  plant.identification.target?.copyWith(nickname: val);
              context.read<PlantBloc>().add(UpdatePlantRequested(plant));
              Navigator.of(context).pop();
            },
          );
        },
      ),
      ListTile(
        title: const Text("Identification"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.idSettingsPlantRoute,
              arguments: IdentificationSettingsScreenArguments(plant.id));
        },
      ),
      ListTile(
        title: const Text("History"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.historySettingsPlantRoute,
              arguments: OriginSettingsScreenArguments(plant.id));
        },
      ),
      ListTile(
        title: const Text("Location"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.locationSettingsPlantRoute,
              arguments: OriginSettingsScreenArguments(plant.id));
        },
      ),
      const ListTile(
        title: Text("Care"),
        dense: true,
      ),
      ListTile(
        title: const Text("Watering Schedule"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.locationSettingsPlantRoute,
              arguments: OriginSettingsScreenArguments(plant.id));
        },
      ),
      ListTile(
        title: const Text("Fertilizer Schedule"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.locationSettingsPlantRoute,
              arguments: OriginSettingsScreenArguments(plant.id));
        },
      ),
      ListTile(
        title: const Text("Soil"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.soilSettingsPlantRoute,
              arguments: SoilSettingsScreenArguments(plant.soilId));
        },
      ),
      ListTile(
        title: const Text("Container"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.locationSettingsPlantRoute,
              arguments: OriginSettingsScreenArguments(plant.id));
        },
      ),
    ];
  }
}

class EditPlantScreenArguments {
  final int plantId;

  const EditPlantScreenArguments(this.plantId);
}
