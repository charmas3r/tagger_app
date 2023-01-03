import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tagger_app/main/presentation/navigation/model/screens.dart';
import 'package:tagger_app/plants/domain/entities/plant.dart';
import 'package:tagger_app/plants/presentation/extensions/stateful_widget.dart';
import 'package:tagger_app/plants/presentation/view/identification_settings_screen.dart';
import 'package:tagger_app/plants/presentation/view/origin_settings_screen.dart';
import 'package:tagger_app/resources/colors.dart';
import 'package:tagger_app/soil/presentation/view/soil_settings_screen.dart';
import '../../../main/presentation/navigation/model/routes.dart';
import '../bloc/plant_bloc.dart';

class EditPlantScreen extends StatefulWidget {
  const EditPlantScreen({Key? key, required this.title, required this.plantId})
      : super(key: key);

  final String title;
  final int plantId;

  @override
  EditPlantScreenState createState() => EditPlantScreenState(plantId);
}

class EditPlantScreenState extends State<EditPlantScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _nickNameEditController;

  int _selectedIndex = Screens.activityPlants;
  final int plantId;

  final _tabs = [
    const Tab(text: 'Activity'),
    const Tab(text: 'Tasks'),
    const Tab(text: 'General'),
  ];

  EditPlantScreenState(this.plantId);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _nickNameEditController = TextEditingController(text: "Plant nickname");
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nickNameEditController.dispose();
    super.dispose();
  }

  void handleClick() {
    log("was clicked");
  }

  @override
  Widget build(BuildContext context) {
    context.read<PlantBloc>().add(FetchPlantRequested(plantId));
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(_nickNameEditController, context),
        ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Edit your plant",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () {
            context.read<PlantBloc>().add(const FetchPlantsRequested());
            Navigator.of(context).pop();
          }),
      actions: <Widget>[
        PopupMenuButton<String>(
          // color: ThemeColors.alabaster.shade500,
          elevation: 24,
          onSelected: _handleMenuOveflowClick,
          itemBuilder: (BuildContext context) {
            return {'Delete'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  void _handleMenuOveflowClick(String value) {
    switch (value) {
      case 'Delete':
        {
          _showAlertDialog(plantId, context);
          break;
        }
    }
  }

  void _showAlertDialog(int plantId, BuildContext pageContext) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Are you sure you want to delete this plant?'),
        content: const Text(
            'You will permanently lose all information saved with this plant.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text('Cancel',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
          TextButton(
            onPressed: () {
              context.read<PlantBloc>().add(RemovePlantRequested(plantId));
              context.read<PlantBloc>().add(const FetchPlantsRequested());
              Navigator.pop(context, 'OK');
              Navigator.pop(pageContext);
            },
            child: Text(
              'Ok',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
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
          return Column(
            children: [
              const SizedBox(height: 16),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 0,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                          radius: 48, // Image radius
                          backgroundImage:
                          AssetImage('assets/images/plumeria.webp')),
                    ),
                  ),
                  Positioned(
                    bottom: 76,
                    child: Text(textEditingController.text)
                  ),
                  Lottie.asset(
                    'assets/json/AlabasterGrass.json',
                    repeat: true,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.tertiary,
                  child: Column(
                    children: [
                      Container(
                        height: kToolbarHeight - 8.0,
                        decoration: BoxDecoration(
                          color: ThemeColors.alabaster,
                          borderRadius: BorderRadius.circular(48.0),
                        ),
                        child: TabBar(
                          onTap: (index) {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          controller: _tabController,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(48.0),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          labelColor: Theme.of(context).colorScheme.onPrimary,
                          unselectedLabelColor:
                              Theme.of(context).colorScheme.secondary,
                          tabs: _tabs,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildTabView(
                          _selectedIndex, state.plants, textEditingController)
                    ],
                  ),
                ),
              )
            ],
          );
        case PlantStatus.loading:
        case PlantStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget _buildTabView(
    int index,
    List<Plant> plants,
    TextEditingController nickNameController,
  ) {
    if (index == Screens.activityPlants) {
      return Column(children: [
        _buildShadowItem(),
        Text("Activity Plants"),
      ]);
    } else if (index == Screens.tasksPlants) {
      return Expanded(
          child: Container(
        color: Theme.of(context).colorScheme.primary,
        child: ListView(
          children:
              _buildTasksChildren(nickNameController, context, plants.first),
        ),
      ));
    } else {
      return Expanded(
          child: Container(
        color: Theme.of(context).colorScheme.primary,
        child: ListView(
          children:
              _buildSettingsChildren(nickNameController, context, plants.first),
        ),
      ));
    }
  }

  Widget _buildShadowItem() {
    return Container(
        height: 4,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ));
  }

  List<Widget> _buildTasksChildren(
    TextEditingController textEditingController,
    BuildContext context,
    Plant plant,
  ) {
    return [
      _buildShadowItem(),
      ListTile(
        title: Text(
          "CARE TASK SETTINGS",
          style: TextStyle(color: Colors.grey.shade500),
        ),
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
        title: const Text("Soil Changing Schedule"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.soilSettingsPlantRoute,
              arguments: SoilSettingsScreenArguments(plant.soilId));
        },
      ),
      ListTile(
        title: const Text("Pruning Schedule"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.locationSettingsPlantRoute,
              arguments: OriginSettingsScreenArguments(plant.id));
        },
      ),
      ListTile(
        title: const Text("Misting Schedule"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.locationSettingsPlantRoute,
              arguments: OriginSettingsScreenArguments(plant.id));
        },
      ),
      ListTile(
        title: const Text("Custom Schedule"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.locationSettingsPlantRoute,
              arguments: OriginSettingsScreenArguments(plant.id));
        },
      ),
    ];
  }

  List<Widget> _buildSettingsChildren(
    TextEditingController textEditingController,
    BuildContext context,
    Plant plant,
  ) {
    return [
      _buildShadowItem(),
      ListTile(
        title: Text(
          "GENERAL PLANT SETTINGS",
          style: TextStyle(color: Colors.grey.shade500),
        ),
        dense: true,
      ),
      ListTile(
          title: const Text("Edit plant name"),
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
              EditableBottomSheetVariableType.string,
              EditableBottomSheetSavableType.saveOnClose,
              (String val) {
                plant.identification.target =
                    plant.identification.target?.copyWith(nickname: val);
                context.read<PlantBloc>().add(UpdatePlantRequested(plant));
                Navigator.of(context).pop();
              },
            );
          }),
      SwitchListTile(
        title: const Text("Mute notifications"),
        value: false,
        onChanged:(bool? value) { },
      ),
      ListTile(
        title: const Text("Gallery"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.locationSettingsPlantRoute,
              arguments: OriginSettingsScreenArguments(plant.id));
        },
      ),
      ListTile(
        title: const Text("Label settings"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, Routes.locationSettingsPlantRoute,
              arguments: OriginSettingsScreenArguments(plant.id));
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
    ];
  }
}

class EditPlantScreenArguments {
  final int plantId;

  const EditPlantScreenArguments(this.plantId);
}
