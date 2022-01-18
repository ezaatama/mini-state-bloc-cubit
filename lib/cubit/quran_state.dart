part of 'quran_cubit.dart';

abstract class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object> get props => [];
}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState{

  final List<Quran> quranLoading;

  QuranLoading(this.quranLoading);

  @override
  List<Object> get props => [quranLoading];

}

class QuranFetched extends QuranState{

  final List<Quran>? quranFetched;

  QuranFetched({
    this.quranFetched
  });

  @override
  List<Object> get props => [quranFetched!];
}