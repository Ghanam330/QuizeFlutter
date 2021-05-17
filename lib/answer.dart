import 'package:flutter/material.dart';


class Answer extends StatelessWidget {
final String answerQuestion;
final Function x;

Answer(this.answerQuestion, this.x);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
            onPressed: x
            ,color: Colors.blue,
            textColor: Colors.white,
            child: Text(
              answerQuestion,
            style: TextStyle(
              fontSize: 25,
            ),
            ),
          ),
    );
  }
}
