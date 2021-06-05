import 'package:bmi/archive_tasks/archive_tasks_screen.dart';
import 'package:bmi/components/components.dart';
import 'package:bmi/components/constants.dart';
import 'package:bmi/done_tasks/done_tasks_screen.dart';
import 'package:bmi/new_tasks/new_tasks_screen.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  Database database;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  bool _isBottomSheetShow = false;

  IconData fabIcon = Icons.edit;

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen()
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: ConditionalBuilder(
        condition: tasks.length > 0,
        builder: (context) => screens[currentIndex],
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isBottomSheetShow) {
            if (_formKey.currentState.validate()) {
              insertDatabase(
                title: titleController.text,
                date: dateController.text,
                time: timeController.text,
              ).then((value) {
                getDateFromDatabase(database).then((value) {
                  tasks = value;
                  Navigator.pop(context);
                  _isBottomSheetShow = false;
                  setState(() {
                    fabIcon = Icons.edit;
                  });
                });

              });
            }
          } else {
            scaffoldKey.currentState
                .showBottomSheet(
                  (context) => Container(
                    padding: EdgeInsets.all(20.0),
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormField(
                            controller: titleController,
                            type: TextInputType.text,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'title must not be empty';
                              }
                              return null;
                            },
                            label: 'Task Title',
                            prefix: Icons.title,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: timeController,
                            type: TextInputType.datetime,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) => timeController.text =
                                  value.format(context).toString());
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Time must not be empty';
                              }
                              return null;
                            },
                            label: 'Time',
                            prefix: Icons.watch_later_outlined,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: dateController,
                            type: TextInputType.datetime,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('20121-05-03'),
                              ).then(
                                (value) => dateController.text =
                                    DateFormat.yMMMd().format(value),
                              );
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Date must not be empty';
                              }
                              return null;
                            },
                            label: 'Data',
                            prefix: Icons.calendar_today,
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 20.0,
                )
                .closed
                .then((value) {
              _isBottomSheetShow = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });
            _isBottomSheetShow = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child: Icon(
          fabIcon,
        ),
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

  void createDatabase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {

      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title Text,data Text, time Text,status Text)')
          .then((value) {})
          .catchError((onError) {
        print('Error when Creating Tabel ${onError.toString()}');
      });
    }, onOpen: (database) {
      getDateFromDatabase(database).then((value) {
          tasks = value;
      });
    });
  }

  Future insertDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    return await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks( title, data, time, status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value insert successfuly');
      }).catchError((onError) {
        print('error when Inserting new record ${onError.toString()}');
      });
      return null;
    });
  }

  Future getDateFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
