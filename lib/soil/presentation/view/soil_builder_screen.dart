
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/soil/domain/entities/builder/soil_builder.dart';
import 'package:tagger_app/soil/domain/entities/soil_medium.dart';
import 'package:tagger_app/soil/presentation/bloc/soil_bloc.dart';

class SoilBuilderScreen extends StatefulWidget {
  const SoilBuilderScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SoilBuilderScreen createState() => _SoilBuilderScreen();
}

class _SoilBuilderScreen extends State<SoilBuilderScreen> {
  final soilNameEditController = TextEditingController();

  @override
  void dispose() {
    soilNameEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(soilNameEditController, context),
        ));
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text("Add Soil Screen"),
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<SoilBloc>().add(const FetchSoilBlendsRequested());
            Navigator.of(context).pop();
          }),
    );
  }

  Widget _buildBody(
      TextEditingController textEditingController,
      BuildContext context,
      ) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: _buildChildren(textEditingController, context),
    );
  }

  List<Widget> _buildChildren(
      TextEditingController textEditingController,
      BuildContext context,
      ) {
    String initialTextTitle = textEditingController.text.isEmpty
        ? "Choose a soil name"
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
      ),
      const SizedBox(height: 48),
      ElevatedButton(
        onPressed: () {
          final soil = SoilBuilder()
            .setSoilName(textEditingController.text)
            .setPh(7.0)
            .addSoilMedium(SoilMedium(medium: "coir", part: 1))
            .create();
          context.read<SoilBloc>().add(SaveSoilBlendRequested(soil));
          context.read<SoilBloc>().add(const FetchSoilBlendsRequested());
          Navigator.pop(context);
        },
        child: const Text("Save Plant"),
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
                const Text('Choose a name for this soil blend'),
                const SizedBox(height: 16),
                TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Soil blend name',
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
