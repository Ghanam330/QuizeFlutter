import 'package:bmi/bloc_examble/cubit/cubit.dart';
import 'package:bmi/bloc_examble/cubit/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//   state less contain one class provide widget

//  stateful  contain classes

//1. first class provide widget
//2. second class provide state from this widget

class CounterScreen extends StatelessWidget {
  //1. counstructor
  //2. init state
  //3. build

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStatus>(
        listener: (context, state) {
          if (state is CounterMinusState) print("Minus state${state.counter}");
          if (state is CounterPlusState) print("Plus state${state.counter}");
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Counter'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).minus();
                    },
                    child: Text('minus'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '${CounterCubit.get(context).counter}',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).plus();
                    },
                    child: Text('plus'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
