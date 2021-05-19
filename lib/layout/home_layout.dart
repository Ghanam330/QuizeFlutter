import 'package:bmi/archive_tasks/archive_tasks_screen.dart';
import 'package:bmi/done_tasks/done_tasks_screen.dart';
import 'package:bmi/new_tasks/new_tasks_screen.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen()
  ];

  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /*
          try {
            var name = await getName();
            print(name);

            /*
            دا بيعمل ايرور
            throw('some error !!!!!!!)
             */
          } catch (error) {
            print('error ${error.toString()}');
          }

           */

          // دي بدل try catch
          getName().then((value) => print(value)
          ).catchError((error){
                print('erore is ${error.toString()}');
          });
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

  // دي عشان اشغلها في الباك جراوند tread
  Future<String> getName() async {
    return 'AhmedAli';
  }
}
