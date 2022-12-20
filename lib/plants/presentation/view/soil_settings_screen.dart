import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/plants/domain/entities/plant.dart';
import 'package:tagger_app/plants/presentation/extensions/stateful_widget.dart';
import 'package:tagger_app/soil/presentation/bloc/soil_bloc.dart';
import 'package:tagger_app/utils/date_utils.dart';
import '../../../soil/domain/entities/soil.dart';
import '../bloc/plant_bloc.dart';

class SoilSettingsScreen extends StatefulWidget {
  const SoilSettingsScreen(
      {Key? key, required this.title, required this.soilId})
      : super(key: key);

  final String title;
  final int soilId;

  @override
  _SoilSettingsScreen createState() => _SoilSettingsScreen(soilId);
}

class _SoilSettingsScreen extends State<SoilSettingsScreen> {
  final List<String> list = <String>[
    'Coir',
    'Perlite',
    'Pumice',
  ];
  final int soilId;

  _SoilSettingsScreen(this.soilId);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<SoilBloc>().add(FetchUniqueSoilBlendRequested(soilId));
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context),
        ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Soil Settings"),
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
    return BlocConsumer<SoilBloc, SoilState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.status) {
            case SoilStatus.failure:
              return const Center(child: Text('failed to fetch plant'));
            case SoilStatus.success:
              return Stack(
                children: <Widget>[
                  ListView(
                    padding: const EdgeInsets.all(8),
                    children: _buildChildren(context, state.soils.first),
                  ),
                  _buildSoilMixtureButton(context),
                ],
              );
            case SoilStatus.loading:
            case SoilStatus.initial:
              return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildSoilMixtureButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        width: double.infinity,
        child: MaterialButton(
          onPressed: () => {},
          color: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.onPrimary,
          child:
              const Text('Create Soil Mixture', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(
    BuildContext context,
    Soil soil,
  ) {
    return [
      ListTile(
        title: const Text("Ph"),
        trailing: Text("${soil.ph}"),
        onTap: () {
          String bottomSheetTitle = "Enter a ph value";
          String bottomSheetEditLabel = "ph value";
          showEditableBottomSheet(
            context,
            TextEditingController(text: '${soil.ph}'),
            bottomSheetTitle,
            bottomSheetEditLabel,
            EditableBottomSheetType.double,
            (String val) {
              try {
                var value = double.parse(val);
                soil.ph = value;
                context.read<SoilBloc>().add(UpdateSoilBlendRequested(soil));
                Navigator.of(context).pop();
              } catch (e) {
                log("Unable to properly parse user input.");
              }
            },
          );
        },
      ),
      ListTile(
        title: const Text("Mix Date"),
        trailing: Text(
          formatDate(soil.mixDate),
        ),
        onTap: () {
          showPlantDatePicker(
            context,
            soil.mixDate,
            (DateTime val) {
              // TODO
              // plant.soil.target = plant.soil.target?.copyWith(mixDate: val);
              // context.read<PlantBloc>().add(UpdatePlantRequested(plant));
            },
          );
        },
      ),
      const ListTile(
        title: Text("Current Soil Mixture Details"),
        dense: true,
      ),

      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // use whichever suits your need
          children: const <Widget>[
            Spacer(),
            Expanded(
              child: Text("Coir"),
            ),
            Spacer(),
            Expanded(
              child: Text(
                "1 Part",
              ),
            ),
            Spacer(),
          ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // use whichever suits your need
        children: const <Widget>[
          Spacer(),
          Expanded(
            child: Text("Perlite"),
          ),
          Spacer(),
          Expanded(
            child: Text(
              "1 Part",
            ),
          ),
          Spacer(),
        ],
      ),
      //   )
      // ListTile(
      //   title: const Text("Soil Medium"),
      //   trailing: DropdownButton<String>(
      //     value: list[0],
      //     icon: const Icon(Icons.arrow_drop_down),
      //     elevation: 16,
      //     style: TextStyle(color: Theme
      //         .of(context)
      //         .colorScheme
      //         .primary),
      //     underline: Container(
      //       height: 2,
      //       color: Theme
      //           .of(context)
      //           .colorScheme
      //           .primary,
      //     ),
      //     onChanged: (String? value) {
      //       // TODO
      //       context.read<PlantBloc>().add(UpdatePlantRequested(plant));
      //     },
      //     items: list.map<DropdownMenuItem<String>>((String value) {
      //       return DropdownMenuItem<String>(
      //         value: value,
      //         child: Text(value),
      //       );
      //     }).toList(),
      //   ),
      //   onTap: () {
      //     // route user to Identification page
      //   },
      // ),
    ];
  }
}

List<Widget> _buildSoilParts() {
  return [
    const ListTile(
      title: Text("Coir "),
      trailing: Text("1 Part"),
    ),
    const ListTile(
      title: Text("Perlite"),
      trailing: Text("1 Part"),
    )
  ];
}

class SoilSettingsScreenArguments {
  final int soilId;

  const SoilSettingsScreenArguments(this.soilId);
}
