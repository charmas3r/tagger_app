import 'package:flutter/material.dart';

import '../../domain/entities/plant.dart';

extension EditableBottomsheet on State<StatefulWidget> {
  void showEditableBottomSheet(
      BuildContext pageContext,
      Plant plant,
      TextEditingController textEditingController,
      String title,
      String label,
      Function(String val) onTap,
      ) {
    showModalBottomSheet<void>(
      context: pageContext,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 24,
              right: 24,
              left: 24,
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom),
          child: SizedBox(
            height: 240,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 16),
                Text(title),
                const SizedBox(height: 16),
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: label,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      onTap(
                        textEditingController.text
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}