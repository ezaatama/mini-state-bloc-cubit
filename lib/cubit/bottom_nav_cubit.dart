import 'dart:ffi';

import 'package:bloc/bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  void setPage(int newPage){
    emit(newPage);
  }

}
