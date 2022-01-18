import 'package:flutter/material.dart';
import 'package:state_cubit/models/movie_model.dart';
import 'package:state_cubit/services/movie_services.dart';
import 'package:state_cubit/shared/theme.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModels? movieModels;
  const MovieDetailPage({Key? key, this.movieModels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailMovie detailMovieModel;

    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: MovieService.fetchDetailMovie(movieModels!),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  detailMovieModel = snapshot.data;
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        title: Container(
                          width: MediaQuery.of(context).size.width - 2 * 24,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                detailMovieModel.name.toString(),
                                style: whiteTextStyle.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              )
                            ],
                          ),
                        ),
                        backgroundColor: const Color(0xFFCBD7D6),
                        pinned: true,
                        expandedHeight: 250,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          detailMovieModel.bigImage.toString()),
                                      fit: BoxFit.cover))),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          detailMovieModel.name.toString(),
                                          overflow: TextOverflow.clip,
                                          style: blackTextStyle.copyWith(
                                              fontSize: 20),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 20,
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        detailMovieModel.rating.toString(),
                                        style: greyTextStyle.copyWith(
                                            fontSize: 14),
                                      ),
                                      const Icon(
                                        Icons.star_rate,
                                        color: Colors.yellow,
                                        size: 16,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 14,
                                  left: defaultMargin,
                                  right: defaultMargin),
                              height: 30,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: detailMovieModel.genres!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFCBD7D6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Center(
                                        child: Text(
                                          detailMovieModel.genres![index],
                                          style: blackTextStyle,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 14,
                                  left: defaultMargin,
                                  right: defaultMargin),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(detailMovieModel.description.toString(), style: blackTextStyle.copyWith(fontSize: 14), textAlign: TextAlign.justify,),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    child: const Text("Something error"),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}
