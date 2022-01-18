import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  void counterDecrement(int value){
    emit((state is CounterFilled) ? CounterFilled((state as CounterFilled).value - value) : CounterFilled(0));
  }

  void counterIncrement(int value){
    emit((state is CounterFilled) ? CounterFilled((state as CounterFilled).value + value) : CounterFilled(0));
  }
}
