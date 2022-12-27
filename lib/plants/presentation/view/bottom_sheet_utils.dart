import 'dart:developer';

import 'package:tagger_app/plants/presentation/extensions/stateful_widget.dart';

bool validateBottomSheetInput(
  String input,
  EditableBottomSheetVariableType type,
) {
  if (type == EditableBottomSheetVariableType.double) {
    try {
      double.parse(input);
      return true;
    } catch (e) {
      log("Unable to properly parse user input.");
      return false;
    }
  }
  return true;
}
