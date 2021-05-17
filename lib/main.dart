import 'package:bmi/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _question = [
    'What\' your favorite color ?',
    'What\' your favorite animal ?',
  ];

  int _questionIndex=0;

  void answerQuestion(){
    setState(() {
      _questionIndex+=1;
    });
    print(_questionIndex);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Question(_question[0]),
              Answer('Answer 1', answerQuestion),
              Answer('Answer 2', answerQuestion),
              Answer('Answer 3', answerQuestion),

            ],
          ),
        ),
      ),
    );
  }
}
