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

  static String? otherAnswerValidator(String? value, int index) {
    return FormUtil.isNullOrEmpty(value)
        ? "L'autre réponse nº ${index + 1} doit être renseignée"
        : null;
  }
}

class QuestionForm extends StatefulWidget {
  const QuestionForm({
    required this.onSubmit,
    this.question,
    super.key,
  });

  final Question? question;
  final void Function(Question) onSubmit;

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingFieldController(
    validator: _Validators.titleValidator,
  );
  final _goodAnswerController = TextEditingFieldController(
    validator: _Validators.goodAnswerValidator,
  );

  final _otherAnswersControllers = List.generate(
    3,
    (index) => TextEditingFieldController(
      validator: (value) => _Validators.otherAnswerValidator(value, index),
    ),
  );

  bool _isValid = false;

  @override
  void initState() {
    if (widget.question != null) {
      _titleController.controller.text = widget.question!.title;
      _goodAnswerController.controller.text = widget.question!.goodAnswer;
      for (var i = 0; i < widget.question!.otherAnswers.length; i++) {
        _otherAnswersControllers[i].controller.text =
            widget.question!.otherAnswers[i];
      }
    }
    checkFormValid();
    super.initState();
  }

  @override
  void dispose() {
    [
      _titleController,
      _goodAnswerController,
      ..._otherAnswersControllers.map((e) => e),
    ].dispose();
    super.dispose();
  }

  void checkFormValid() {
    final areValid = [
      _titleController,
      _goodAnswerController,
      ..._otherAnswersControllers.map((e) => e),
    ].areValid;

    if (areValid != _isValid) {
      setState(() {
        _isValid = areValid;
      });
    }
  }

  void handleSubmit() {
    final isFormValid = _formKey.currentState?.validate();
    if (isFormValid ?? false) {
      final newQuestion = Question(
        title: _titleController.controller.text,
        goodAnswer: _goodAnswerController.controller.text,
        otherAnswers:
            _otherAnswersControllers.map((c) => c.controller.text).toList(),
      );
      widget.onSubmit(newQuestion);
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
            onFieldSubmitted: (_) => _isValid ? handleSubmit() : null,
            controller: _goodAnswerController.controller,
            validator: _goodAnswerController.validator,
            decoration: const InputDecoration(
              labelText: 'Bonne réponse',
              helperText: '*champ obligatoire',
            ),
          ),
          const SizedBox(height: 15),
          for (var i = 0; i < _otherAnswersControllers.length; i++) ...[
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: (_) => _isValid ? handleSubmit() : null,
              controller: _otherAnswersControllers[i].controller,
              validator: _otherAnswersControllers[i].validator,
              decoration: InputDecoration(
                labelText: 'Autre réponse nº ${i + 1}',
                helperText: '*champ obligatoire',
              ),
            ),
            const SizedBox(height: 15)
          ],
          ElevatedButton(
            onPressed: _isValid ? handleSubmit : null,
            child: const Text('Valider'),
          )
        ],
      ),
    );
  }
}
