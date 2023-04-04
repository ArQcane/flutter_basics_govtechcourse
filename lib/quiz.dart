import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tester/question.dart';

import 'answers.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({required this.questions, required this.answerQuestion, required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText'] as String),
        //... -> pulls all the values out of a list to the surrounding list as individual values
        // Has to be declared for type or else Null error or wrong object inference
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answers(() => answerQuestion(answer['score']), answer['text'] as String);
        }).toList()
      ],
    );
  }
}
