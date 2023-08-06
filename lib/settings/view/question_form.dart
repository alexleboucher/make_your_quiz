import 'package:flutter/material.dart';
import 'package:make_your_quiz/shared/controller/field_controller.dart';
import 'package:make_your_quiz/shared/util/form_util.dart';

enum QuestionField { title }

class QuestionForm extends StatefulWidget {
  const QuestionForm({
    this.title,
    super.key,
  });

  final String? title;

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleFieldController = FieldController<TextEditingController, String>(
    controller: TextEditingController(),
    validator: (value) {
      return FormUtil.isNullOrEmpty(value)
          ? 'Le titre doit être renseigné'
          : null;
    },
  );

  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    if (widget.title != null) {
      _titleFieldController.controller.text = widget.title!;
    }
    checkFormValid();
  }

  @override
  void dispose() {
    _titleFieldController.dispose();
    super.dispose();
  }

  void checkFormValid() {
    final errors = _titleFieldController.validator
        ?.call(_titleFieldController.controller.text);

    final isValid = errors == null;
    if (_isValid != isValid) {
      setState(() {
        _isValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: checkFormValid,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _titleFieldController.controller,
            validator: _titleFieldController.validator,
            decoration: const InputDecoration(
              labelText: 'Titre de la question',
              helperText: '*required',
            ),
          ),
          ElevatedButton(
            onPressed: _isValid ? () {} : null,
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}
