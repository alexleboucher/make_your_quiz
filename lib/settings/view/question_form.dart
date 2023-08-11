import 'package:flutter/material.dart';
import 'package:make_your_quiz/model/question.dart';
import 'package:make_your_quiz/shared/controller/field_controller.dart';
import 'package:make_your_quiz/shared/util/form_util.dart';

abstract class _Validators {
  static String? titleValidator(String? value) {
    return FormUtil.isNullOrEmpty(value)
        ? 'Le titre doit être renseigné'
        : null;
  }

  static String? goodAnswerValidator(String? value) {
    return FormUtil.isNullOrEmpty(value)
        ? 'La bonne réponse doit être renseignée'
        : null;
  }
}

class QuestionForm extends StatefulWidget {
  const QuestionForm({
    this.question,
    super.key,
  });

  final Question? question;

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final _titleController = TextEditingFieldController(
    validator: _Validators.titleValidator,
  );
  final _goodAnswerController = TextEditingFieldController(
    validator: _Validators.goodAnswerValidator,
  );

  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    if (widget.question != null) {
      _titleController.controller.text = widget.question!.title;
      _goodAnswerController.controller.text = widget.question!.goodAnswer;
    }
    checkFormValid();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _goodAnswerController.dispose();
    super.dispose();
  }

  void checkFormValid() {
    final isValid = _titleController.isValid && _goodAnswerController.isValid;
    if (_isValid != isValid) {
      setState(() {
        _isValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: checkFormValid,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _titleController.controller,
            validator: _titleController.validator,
            decoration: const InputDecoration(
              labelText: 'Titre de la question',
              helperText: '*champ obligatoire',
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _goodAnswerController.controller,
            validator: _goodAnswerController.validator,
            decoration: const InputDecoration(
              labelText: 'Bonne réponse',
              helperText: '*champ obligatoire',
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: _isValid ? () {} : null,
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}
