import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:state_cubit/models/movie_model.dart';
import 'package:state_cubit/repository/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit({required this.repository}) : super(MovieInitial());

  final MovieRepository repository;
  int page = 1;

  void loadMovies(){
    if(state is MovieLoading) return;

    final currentState = state;
    var oldMovies = <MovieModels>[];

    if(currentState is MovieLoaded){
      oldMovies = currentState.movieModel!;
    }

    emit(MovieLoading(oldMovies, isFirstFetch: page == 1));

    repository.fetchMovies(page).then((newMovie) {
      page++;
      
      final movies = (state as MovieLoading).oldMovies;
      movies.addAll(newMovie!);

      emit(MovieLoaded(movieModel: movies));
    });
  }

}
