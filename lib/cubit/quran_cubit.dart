import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:state_cubit/models/quran_model.dart';
import 'package:state_cubit/repository/quran_repository.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit({required this.repository}) : super(QuranInitial());

  final QuranRepository repository;

  void loadQuran() async{
    if(state is QuranLoading) return ;

    final currentState = state;
    var loadingQuran = <Quran>[];

    if(currentState is QuranFetched){
      loadingQuran = currentState.quranFetched!;
    }

    emit(QuranLoading(loadingQuran));

    repository.fetchQurans().then((value) {
      final surah = (state as QuranLoading).quranLoading;

      surah.addAll(value);

      emit(QuranFetched(quranFetched: surah));
    });

  }
}
