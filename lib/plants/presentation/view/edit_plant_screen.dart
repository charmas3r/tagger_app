import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/plants/domain/entities/plant.dart';
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
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(nickNameEditController, context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text("Edit Plant Screen"),
    );
  }

  Widget _buildBody(
    TextEditingController textEditingController,
    BuildContext context,
  ) {
    return BlocBuilder<PlantBloc, PlantState>(builder: (context, state) {
      switch (state.status) {
        case PlantStatus.failure:
          return const Center(child: Text('failed to fetch plant'));
        case PlantStatus.success:
          return ListView(
            padding: const EdgeInsets.all(8),
            children: _buildChildren(textEditingController, context, state.plants.first),
          );
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
    textEditingController.text = plant.name;
    return [
      const ListTile(
        title: Text("General"),
        dense: true,
      ),
      ListTile(
        title: Text(textEditingController.text),
        trailing: const Icon(Icons.edit),
        onTap: () {
          _showEditPlantBottomSheet(textEditingController, context, plant);
        },
      ),
    ];
  }

  void _showEditPlantBottomSheet(
    TextEditingController textEditingController,
    BuildContext context,
      Plant plant,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        textEditingController.text = plant.name;
        return Padding(
          padding: const EdgeInsets.all(16),
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
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EditPlantScreenArguments {
  final int plantId;

  const EditPlantScreenArguments(this.plantId);
}
