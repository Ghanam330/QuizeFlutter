import 'package:bmi/archive_tasks/archive_tasks_screen.dart';
import 'package:bmi/components/constants.dart';
import 'package:bmi/cubit_bloc/states.dart';
import 'package:bmi/done_tasks/done_tasks_screen.dart';
import 'package:bmi/new_tasks/new_tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isBottomSheetShow = false;
  IconData fabIcon = Icons.edit;
  int currentIndex = 0;
  Database database;
  List<Map> tasks = [];

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen()
  ];

  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNabBarState());
  }

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
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
        emit(AppGetDatabaseState());
      });
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks( title, data, time, status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value insert successfuly');

        emit(AppInsertDatabaseState());

        getDateFromDatabase(database).then((value) {
          tasks = value;
          emit(AppGetDatabaseState());
        });
      }).then((value) {
        database = value;
        emit(AppCreateDatabaseState());
      }).catchError((onError) {
        print('error when Inserting new record ${onError.toString()}');
      });
      return null;
    });
  }

  Future getDateFromDatabase(database) async {
    emit(AppGetDatabaseState());
    return await database.rawQuery('SELECT * FROM tasks');
  }

  void updateDate({
    @required String states,
    @required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$states', id],
    ).then((value) {
      emit(AppUpdateDatabaseState());
    });
  }

  void changeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetShow = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }
}
