import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tester/quiz.dart';
import 'package:tester/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //const -> compile time, final -> cant change at runtime
  final _questions = const [
    {
      'questionText': 'What\'s your favourite color',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favourite animal',
      'answers': [
        {'text': 'Rabbit', 'score': 5},
        {'text': 'Snake', 'score': 10},
        {'text': 'Elephant', 'score': 3},
        {'text': 'Lion', 'score': 8}
      ],
    },
    {
      'questionText': 'Who\'s your favourite Instructor',
      'answers': [
        {'text': 'Max', 'score': 100}, {'text': 'Max', 'score': 100},  {'text': 'Max', 'score': 100}, {'text': 'Max', 'score': 100}],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz(){
    setState((){
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    //iterate through the list whenever the function is called to generate new question
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print("We have more questions");
    } else {
      print("No More Questions!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("My First App!"),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questions: _questions,
                questionIndex: _questionIndex,
              )
            : Result(resultScore: _totalScore, resetFunc: _resetQuiz),
      ),
    );
  }
}
