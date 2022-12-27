import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/plants/presentation/extensions/stateful_widget.dart';
import 'package:tagger_app/soil/domain/entities/soil_medium.dart';
import 'package:tagger_app/soil/presentation/bloc/soil_bloc.dart';
import 'package:tagger_app/utils/date_utils.dart';
import '../../domain/entities/soil.dart';
import '../../../plants/presentation/bloc/plant_bloc.dart';
import '../viewmodel/soil_mixture_details_item.dart';

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
  final List<String> mediums = <String>[
    'Coir',
    'Perlite',
    'Pumice',
    'Peat',
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
          body: _buildBody(
            context,
            mediums,
          ),
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
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.delete,
          ),
          onPressed: () {
            _showAlertDialog(soilId, context);
          },
        ),
      ],
    );
  }

  void _showAlertDialog(int soilId, BuildContext pageContext) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Are you sure you want to delete this soil?'),
        content: const Text('You will permanently lose all information saved with this soil.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<SoilBloc>().add(RemoveSoilBlendRequested(soilId));
              context.read<SoilBloc>().add(const FetchSoilBlendsRequested());
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
    BuildContext context,
    List<String> mediums,
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
                    children: _buildChildren(
                      context,
                      mediums,
                      state.soils.first,
                    ),
                  ),
                  _buildSoilMixtureButton(
                    context,
                    mediums,
                    state.soils.first,
                  ),
                ],
              );
            case SoilStatus.loading:
            case SoilStatus.initial:
              return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildSoilMixtureButton(
    BuildContext context,
    List<String> mediums,
    Soil soil,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        width: double.infinity,
        child: MaterialButton(
          onPressed: () => {showSoilMixtureBottomSheet(context, mediums, soil)},
          color: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.onPrimary,
          child:
              const Text('Modify Soil Mixture', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  List<SoilMixtureDetailsItem> generateItems(List<SoilMedium> items) {
    return List<SoilMixtureDetailsItem>.generate(items.length, (int index) {
      String partTitle = items[index].part == 1
          ? '${items[index].part} part'
          : '${items[index].part} parts';
      return SoilMixtureDetailsItem(
        medium: items[index].medium,
        part: partTitle,
      );
    });
  }

  List<Widget> _buildChildren(
    BuildContext context,
    List<String> mediums,
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
            EditableBottomSheetVariableType.double,
            EditableBottomSheetSavableType.saveOnClose,
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
      ExpansionTile(
        title: const Text('Current soil mixture details'),
        children: _buildSoilMixtureDetailItems(generateItems(soil.soilMediums)),
      ),

      ExpansionTile(
        title: const Text('Current plants using this blend'),
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // use whichever suits your need
              children: const <Widget>[
                Spacer(),
                Expanded(
                  child: Text("Coir"),
                ),
                Spacer(flex: 3)
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // use whichever suits your need
            children: const <Widget>[
              Spacer(),
              Expanded(
                child: Text("Perlite"),
              ),
              Spacer(flex: 3)
            ],
          ),
        ],
      ),
    ];
  }
}

void showSoilMixtureBottomSheet(
  BuildContext pageContext,
  List<String> mediums,
  Soil soil,
) {
  showModalBottomSheet<void>(
      context: pageContext,
      isScrollControlled: true,
      builder: (BuildContext context) {
        // default and selected value
        String selectedValue = mediums.first;
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Padding(
            padding: EdgeInsets.only(
                top: 24,
                right: 24,
                left: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: 240,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 16),
                  const Text("Add a soil medium"),
                  const SizedBox(height: 16),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // use whichever suits your need
                      children: <Widget>[
                        const Expanded(
                          child: Text("Select a medium"),
                        ),
                        const Spacer(),
                        DropdownButton<String>(
                          value: selectedValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          underline: Container(
                            height: 2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onChanged: (String? value) {
                            setModalState(() {
                              selectedValue = value!;
                            });
                          },
                          items: mediums.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const Spacer(),
                      ]),
                  const SizedBox(height: 32),
                  ElevatedButton(
                      child: const Text("Continue"),
                      onPressed: () {
                        final SoilMedium soilMedium = SoilMedium(medium: selectedValue, part: 1);
                        soil.soilMediums.add(soilMedium);
                        context
                            .read<SoilBloc>()
                            .add(UpdateSoilBlendRequested(soil));
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
      });
}

List<Widget> _buildSoilMixtureDetailItems(List<SoilMixtureDetailsItem> items) {
  List<Widget> mixtureItems = [];
  for (var element in items) {
    mixtureItems.add(
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // use whichever suits your need
          children: <Widget>[
            const Spacer(),
            Expanded(
              child: Text(element.medium),
            ),
            const Spacer(),
            Expanded(
              child: Text(element.part),
            ),
            const Spacer(),
          ]),
    );
  }
  return mixtureItems;
}

class SoilSettingsScreenArguments {
  final int soilId;

  const SoilSettingsScreenArguments(this.soilId);
}
