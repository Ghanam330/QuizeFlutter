import 'package:bmi/archive_tasks/archive_tasks_screen.dart';
import 'package:bmi/done_tasks/done_tasks_screen.dart';
import 'package:bmi/new_tasks/new_tasks_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShow = false;
  IconData fabIcon = Icons.edit;
  var titleController;
  var timeController;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen()
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
              ),
              label: 'new Tasks'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.check_circle_outline,
              ),
              label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.archive_outlined,
              ),
              label: 'Archive'),
        ],
      ),
    );
  }


}
