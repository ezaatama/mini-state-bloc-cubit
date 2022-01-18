import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:state_cubit/models/movie_model.dart';

class MovieService {
  final baseUrl = "https://www.episodate.com/api/most-popular?page=";

  Future<List<dynamic>> fetchMovies(int page) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + "$page"));
      return jsonDecode(response.body)["tv_shows"] as List<dynamic>;
    } catch (e) {
      return [];
    }
  }

  static Future<MovieModels?> fetchDetailMovie(MovieModels movieModels,
      {int? id}) async {
    try {
      String url =
          "https://www.episodate.com/api/show-details?q=${id ?? movieModels.id}";

      final response = await http
          .get(Uri.parse(url), headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        final result = data["tvShow"];

        return DetailMovie(MovieModels.fromJson(result),
            bigImage: result["image_path"],
            description: result["description"],
            genres: result["genres"],
            rating: result["rating"]   
          );
      }
    } catch (e) {
      throw Exception("Error");
    }
  }
}
