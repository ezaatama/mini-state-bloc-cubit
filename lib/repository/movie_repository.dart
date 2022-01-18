import 'package:state_cubit/models/movie_model.dart';
import 'package:state_cubit/services/movie_services.dart';

class MovieRepository{

  final MovieService service;

  MovieRepository(this.service);

  Future<List<MovieModels>?> fetchMovies(int page) async{
    final movies = await service.fetchMovies(page);
    return movies.map((e) => MovieModels.fromJson(e)).toList();
  }
  
}