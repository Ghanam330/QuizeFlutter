import 'package:flutter/material.dart';
import 'layout/home_layout.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomeLayout() ,
    );
  }
}

/*
 sqflite
1. create database
2. create tables
3. open database
4. insert to database
5. get from database
6. update in database
7. delete from database
 */
