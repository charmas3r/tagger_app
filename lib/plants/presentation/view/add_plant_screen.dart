import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/common/ui/widgets/primary_button.dart';
import 'package:tagger_app/plants/domain/entities/builder/decideous_flowering_tree_builder.dart';
import 'package:tagger_app/plants/domain/entities/identification.dart';
import 'package:tagger_app/plants/domain/entities/origin.dart';

import '../bloc/plant_bloc.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AddPlantScreen createState() => _AddPlantScreen();
}

class _AddPlantScreen extends State<AddPlantScreen> {
  final nickNameEditController = TextEditingController();

  @override
  void dispose() {
    nickNameEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(nickNameEditController, context),
        ));
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Add a new plant",
        style: TextStyle(
          fontSize: 14,
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
    );
  }

  Widget _buildBody(
    TextEditingController textEditingController,
    BuildContext context,
  ) {
    return Stack(children: [
      ListView(
        padding: const EdgeInsets.all(8),
        children: _buildChildren(textEditingController, context),
      ),
      PrimaryButton(
        onTap: () {
          final plant = DecideousFloweringTreeBuilder()
              .setIdentification(Identification(
                nickname: nickNameEditController.text,
                cultivar: "NoId",
                species: "Plumeria rubra",
              ))
              .setOrigin(Origin(
                  isSeedling: false,
                  vendor: "Unknown",
                  acquireDate: DateTime.now()))
              .create();
          context.read<PlantBloc>().add(SavePlantRequested(plant));
          context.read<PlantBloc>().add(const FetchPlantsRequested());
          Navigator.pop(context);
        },
        buttonText: "Save Plant",
      ),
    ]);
  }

  List<Widget> _buildChildren(
    TextEditingController textEditingController,
    BuildContext context,
  ) {
    String initialTextTitle = textEditingController.text.isEmpty
        ? "Choose a nickname"
        : textEditingController.text;
    return [
      const ListTile(
        title: Text("General"),
        dense: true,
      ),
      ListTile(
        title: Text(initialTextTitle),
        trailing: const Icon(Icons.edit),
        onTap: () {
          _showEditPlantBottomSheet(textEditingController, context);
        },
      )
    ];
  }

  void _showEditPlantBottomSheet(
    TextEditingController textEditingController,
    BuildContext context,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
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
                const Text('Choose a Nickname'),
                const SizedBox(height: 16),
                TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Plant Nickname',
                    hintText: 'Enter a name',
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                    child: const Text('Continue'),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
