import 'package:flutter/material.dart';
import 'package:tagger_app/utils/logging_utils.dart';

import '../../domain/entities/plant.dart';
import '../view/bottom_sheet_utils.dart';

enum EditableBottomSheetVariableType {
  string,
  double,
}

enum EditableBottomSheetSavableType {
  saveOnClose,
  saveAfterClose,
}

extension EditableBottomsheet on State<StatefulWidget> {
  Future<void> showPlantDatePicker(
    BuildContext context,
    DateTime? selectedDate,
    Function(DateTime val) onTap,
  ) async {
    if (selectedDate != null) {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        log("selected ${picked.toString()}");
        onTap(picked);
      }
    }
  }

  void showEditableBottomSheet(
    BuildContext pageContext,
    TextEditingController textEditingController,
    String title,
    String label,
    EditableBottomSheetVariableType variableType,
    EditableBottomSheetSavableType savableType,
    Function(String val) onTap,
  ) {
    final buttonText = savableType == EditableBottomSheetSavableType.saveOnClose
    ? "Save"
    : "Continue";
    showModalBottomSheet<void>(
        context: pageContext,
        isScrollControlled: true,
        builder: (BuildContext context) {
          var isValidInput = true;
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setModalState) {
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
                    Text(title),
                    const SizedBox(height: 16),
                    TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        labelText: label,
                        errorText: isValidInput
                            ? null
                            : 'Value must be a number',
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                        child: Text(buttonText),
                        onPressed: () {
                          setModalState(() {
                            isValidInput = validateBottomSheetInput(
                                textEditingController.text,
                                variableType,
                            );
                            if (isValidInput) {
                              onTap(textEditingController.text);
                            }
                          });

                        }),
                  ],
                ),
              ),
            );
          });
        });
  }
}
