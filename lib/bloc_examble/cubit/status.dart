abstract class CounterStatus {}

class CounterInitialState extends CounterStatus{}

class CounterPlusState extends CounterStatus{

  final int counter;

  CounterPlusState(this.counter);

}

class CounterMinusState extends CounterStatus{
  final int counter;

  CounterMinusState(this.counter);

}