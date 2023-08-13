import 'package:flutter/material.dart';

// ignore: strict_raw_type
extension FieldControllerListFunctions on List<FieldController> {
  bool get areValid {
    // ignore: unnecessary_this
    final areValids = this.map((e) => e.isValid);
    return areValids.every((element) => element == true);
  }

  void dispose() {
    for (final controller in this) {
      controller.dispose();
    }
  }
}

abstract class FieldController<ControllerType extends ValueNotifier<dynamic>,
    Value> {
  const FieldController({
    required this.controller,
    this.validator,
  });

  final ControllerType controller;
  final String? Function(Value?)? validator;

  bool get isValid;

  void dispose() => controller.dispose();
}

class TextEditingFieldController
    extends FieldController<TextEditingController, String> {
  TextEditingFieldController({String? defaultText, super.validator})
      : super(controller: TextEditingController(text: defaultText));

  @override
  bool get isValid {
    return validator?.call(controller.text) == null;
  }
}
