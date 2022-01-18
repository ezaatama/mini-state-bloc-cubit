part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoaded extends MovieState{

  final List<MovieModels>? movieModel;

  // ignore: prefer_const_constructors_in_immutables
  MovieLoaded({
    this.movieModel
  });

  @override
  List<Object> get props => [movieModel!];
}

// ignore: must_be_immutable
class MovieLoading extends MovieState{
 final List<MovieModels> oldMovies;
 final bool isFirstFetch;
  
  MovieLoading(
    this.oldMovies,
    {this.isFirstFetch = false}
  );

  @override
  List<Object> get props => [oldMovies, isFirstFetch];
}
