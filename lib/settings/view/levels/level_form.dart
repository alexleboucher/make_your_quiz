import 'package:flutter/material.dart';
import 'package:make_your_quiz/shared/controller/field_controller.dart';
import 'package:make_your_quiz/shared/util/form_util.dart';

abstract class _Validators {
  static String? levelValidator(String? value) {
    return FormUtil.isNullOrEmpty(value)
        ? 'Le nom du vieau doit être renseigné'
        : null;
  }
}

class LevelForm extends StatefulWidget {
  const LevelForm({
    required this.onSubmit,
    this.level,
    super.key,
  });

  final String? level;
  final void Function(String) onSubmit;

  @override
  State<LevelForm> createState() => _LevelFormState();
}

class _LevelFormState extends State<LevelForm> {
  final _formKey = GlobalKey<FormState>();
  final _levelController = TextEditingFieldController(
    validator: _Validators.levelValidator,
  );

  bool _isValid = false;

  @override
  void initState() {
    if (widget.level != null) {
      _levelController.controller.text = widget.level!;
    }
    checkFormValid();
    super.initState();
  }

  @override
  void dispose() {
    _levelController.dispose();
    super.dispose();
  }

  void checkFormValid() {
    final valid = _levelController.isValid;

    if (valid != _isValid) {
      setState(() {
        _isValid = valid;
      });
    }
  }

  void handleSubmit() {
    final isFormValid = _formKey.currentState?.validate();
    if (isFormValid ?? false) {
      widget.onSubmit(_levelController.controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: checkFormValid,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: (_) => _isValid ? handleSubmit() : null,
            controller: _levelController.controller,
            validator: _levelController.validator,
            decoration: const InputDecoration(
              labelText: 'Nom du niveau',
              helperText: '*champ obligatoire',
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: _isValid ? handleSubmit : null,
            child: const Text('Valider'),
          )
        ],
      ),
    );
  }
}
