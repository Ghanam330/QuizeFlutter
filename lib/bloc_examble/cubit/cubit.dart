import 'package:bmi/bloc_examble/cubit/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStatus> {
  
  CounterCubit() : super(CounterInitialState());

  // to be more easily when use this cubit in place

  int counter = 1;

  static CounterCubit get(context) => BlocProvider.of(context);

  void minus() {
    counter--;
    emit(CounterMinusState(counter));
  }

  void plus() {
    counter++;
    emit(CounterPlusState(counter));
  }
}
