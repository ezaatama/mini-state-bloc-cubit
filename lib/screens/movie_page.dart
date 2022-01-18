import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cubit/cubit/movie_cubit.dart';
import 'package:state_cubit/models/movie_model.dart';
import 'package:state_cubit/shared/theme.dart';

import 'movie_detail_page.dart';

class MoviePage extends StatelessWidget {
  MoviePage({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<MovieCubit>(context).loadMovies();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<MovieCubit>(context).loadMovies();

    return Scaffold(
      body: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: defaultMargin, bottom: defaultMargin),
                    child: Center(
                      child: Text(
                        "Movie List Infinite Cubit",
                        style: blackTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _movieList(),
                  )
                ],
              ))),
    );
  }

  Widget _movieList() {
    return BlocBuilder<MovieCubit, MovieState>(builder: (context, state) {
      if (state is MovieLoading && state.isFirstFetch) {
        return _loadingIndicator();
      }
      List<MovieModels> movies = [];
      bool isLoading = false;

      if (state is MovieLoading) {
        movies = state.oldMovies;
        isLoading = true;
      } else if (state is MovieLoaded) {
        movies = state.movieModel!;
      }
      return ListView.builder(
        controller: scrollController,
        itemCount: movies.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < movies.length) {
            return _movie(movies[index], context);
          } else {
            return _loadingIndicator();
          }
        },
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _movie(MovieModels movie, BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: defaultMargin),
        height: 380,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MovieDetailPage(movieModels: movie)));
              },
              child: Container(
                width: 300,
                height: 287,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: NetworkImage(movie.image.toString()),
                        fit: BoxFit.cover)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.name.toString(),
                            style: blackTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            movie.country.toString(),
                            style: greyTextStyle.copyWith(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
