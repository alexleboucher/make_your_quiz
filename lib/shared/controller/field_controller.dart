import 'package:flutter/material.dart';

abstract class FieldController<ControllerType extends ValueNotifier<dynamic>,
    Value> {
  const FieldController({
    required this.controller,
    this.validator,
  });

  final ControllerType controller;
  final String? Function(Value?)? validator;

  void dispose() => controller.dispose();
}

class TextEditingFieldController
    extends FieldController<TextEditingController, String> {
  TextEditingFieldController({String? defaultText, super.validator})
      : super(controller: TextEditingController(text: defaultText));

  bool get isValid {
    return validator?.call(controller.text) == null;
  }
}
