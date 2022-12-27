
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/plants/presentation/extensions/stateful_widget.dart';
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
  final soilPhEditController = TextEditingController();

  @override
  void dispose() {
    soilNameEditController.dispose();
    soilPhEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(
              soilNameEditController,
              soilPhEditController,
              context,
          ),
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
      TextEditingController soilNameEditingController,
      TextEditingController soilPhEditingController,
      BuildContext context,
      ) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: _buildChildren(
          soilNameEditingController,
          soilPhEditingController,
          context,
      ),
    );
  }

  List<Widget> _buildChildren(
      TextEditingController soilNameEditingController,
      TextEditingController soilPhEditingController,
      BuildContext context,
      ) {
    String initialNameTitle = soilNameEditingController.text.isEmpty
        ? "Choose a soil name"
        : soilNameEditingController.text;
    String initialPhTitle = soilPhEditingController.text.isEmpty
        ? "Set PH level for the soil blend"
        : soilPhEditingController.text;
    return [
      const ListTile(
        title: Text("General"),
        dense: true,
      ),
      ListTile(
        title: Text(initialNameTitle),
        trailing: const Icon(Icons.edit),
        onTap: () {
          _showEditSoilNameBottomSheet(soilNameEditingController, context);
        },
      ),
      ListTile(
        title: Text(initialPhTitle),
        trailing: const Icon(Icons.edit),
        onTap: () {
          _showEditSoilPhBottomSheet(soilPhEditingController, context);
        },
      ),
      const SizedBox(height: 48),
      ElevatedButton(
        onPressed: () {
          final soil = SoilBuilder()
            .setSoilName(soilNameEditingController.text)
            .setPh(7.0)
            .addSoilMedium(SoilMedium(medium: "coir", part: 1))
            .create();
          context.read<SoilBloc>().add(SaveSoilBlendRequested(soil));
          context.read<SoilBloc>().add(const FetchSoilBlendsRequested());
          Navigator.pop(context);
        },
        child: const Text("Save Soil Blend"),
      )
    ];
  }

  void _showEditSoilPhBottomSheet(
      TextEditingController textEditingController,
      BuildContext context,
      ) {
    String bottomSheetTitle = "Enter a ph value";
    String bottomSheetEditLabel = "ph value";
    showEditableBottomSheet(
      context,
      textEditingController,
      bottomSheetTitle,
      bottomSheetEditLabel,
      EditableBottomSheetVariableType.double,
      EditableBottomSheetSavableType.saveAfterClose,
          (String val) {
        try {
          double.parse(val);
          Navigator.pop(context);
          setState(() {});
        } catch (e) {
          log("Unable to properly parse user input.");
        }
      },
    );
  }

  void _showEditSoilNameBottomSheet(
      TextEditingController textEditingController,
      BuildContext context,
      ) {
    String bottomSheetTitle = 'Choose a name for this soil blend';
    String bottomSheetEditLabel = 'Soil blend name';
    showEditableBottomSheet(
      context,
      textEditingController,
      bottomSheetTitle,
      bottomSheetEditLabel,
      EditableBottomSheetVariableType.string,
      EditableBottomSheetSavableType.saveAfterClose,
          (String val) {
            Navigator.pop(context);
            setState(() {});
      },
    );
  }
}
