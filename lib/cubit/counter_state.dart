part of 'counter_cubit.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

class CounterInitial extends CounterState {}

class CounterFilled extends CounterState{

  final int value;

  CounterFilled(this.value);

  @override
  List<Object> get props => [value]; 
}