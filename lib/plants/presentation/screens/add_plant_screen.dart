import 'package:flutter/material.dart';
import 'package:tagger_app/utils/logging_utils.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AddPlantScreen createState() => _AddPlantScreen();
}

class _AddPlantScreen extends State<AddPlantScreen> {
  final nickNameEditController = TextEditingController(
    text: "Plant nickname"
  );

  @override
  void dispose() {
    nickNameEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Plant Screen"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const ListTile(
              title: Text("General"),
              dense: true,
            ),
            ListTile(
              title: Text(nickNameEditController.text),
              trailing: const Icon(Icons.edit),
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    nickNameEditController.text = "";
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
                              controller: nickNameEditController,
                              decoration: const InputDecoration(
                                labelText: 'Plant Nickname',
                                hintText: 'Beauty Factory',
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
              },
            ),
            const SizedBox(height: 48),
            ElevatedButton(
                onPressed: () {},
                child: const Text('Save Plant'),
            )
          ],
        ));
  }
}
