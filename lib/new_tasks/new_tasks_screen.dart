import 'package:bmi/components/components.dart';
import 'package:bmi/cubit_bloc/cubit_todo.dart';
import 'package:bmi/cubit_bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatelessWidget {
  AppCubit cubit;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var tasks =AppCubit.get(context).newTasks;

        return ListView.separated(
          itemBuilder:(context,index ) =>
              buildTaskItem(tasks[index],context),
          separatorBuilder:(context ,index) => Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
          itemCount:tasks.length,
        );
      },

    );
  }
}

