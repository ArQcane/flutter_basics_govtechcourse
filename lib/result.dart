import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetFunc;

  Result({required this.resultScore, required this.resetFunc});

  String get resultPhrase {
    String resultText = 'You did it!';
    if (resultScore <= 120) {
      resultText = 'You are below average!';
    } else if (resultScore <= 130) {
      resultText = 'pretty likeable';
    } else {
      resultText = 'pass';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          FlatButton(onPressed: resetFunc, child: Text('Restart Quiz!'))
        ],
      ),
    );
  }
}
