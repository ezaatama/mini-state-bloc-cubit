import 'package:equatable/equatable.dart';

class MovieModels extends Equatable{
  final String? name;
  final int? id;
  final String? permalink;
  final String? startDate;
  final String? endDate;
  final String? country;
  final String? network;
  final String? image;

  MovieModels({
    this.name,
    this.id,
    this.permalink,
    this.startDate,
    this.endDate,
    this.country,
    this.network,
    this.image
  });

  factory MovieModels.fromJson(Map<String, dynamic> json) => MovieModels(
    name: json["name"],
    id: json["id"] as int,
    permalink: json["permalink"],
    startDate: json["start_date"],
    endDate: json["end_date"] ?? "",
    country: json["country"],
    network: json["network"],
    image: json["image_thumbnail_path"]
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "permalink": permalink,
        "start_date": startDate,
        "end_date": endDate,
        "country": country,
        "network": network,
        "image_thumbnail_path": image,
    };

  @override
  // TODO: implement props
  List<Object?> get props => [name, id, permalink, startDate, endDate, country, network, image];
  
}

class DetailMovie extends MovieModels{

  final List? genres;
  final String? bigImage;
  final String? rating;
  final String? description;

  DetailMovie(
    MovieModels movieModels,
    {this.genres,
    this.bigImage,
    this.rating,
    this.description
  }) : super(
    country: movieModels.country,
    endDate: movieModels.endDate,
    id: movieModels.id,
    image: movieModels.image,
    name: movieModels.name,
    network: movieModels.network,
    permalink: movieModels.permalink,
    startDate: movieModels.startDate
  );

  @override
  List<Object?> get props => [genres, bigImage, rating, description];
}