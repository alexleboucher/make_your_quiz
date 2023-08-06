import 'package:flutter/material.dart';

class FieldController<ControllerType extends ValueNotifier<dynamic>, Value> {
  const FieldController({
    required this.controller,
    this.validator,
  });

  final ControllerType controller;
  final String? Function(Value?)? validator;

  void dispose() => controller.dispose();
}
