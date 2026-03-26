import 'package:movies_app/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.voteAverage,
    required super.title,
    required super.overview,
    required super.backdropPath,
    required super.genreIds,
    required super.releaseDate,
  });
  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    id: json["id"],
    voteAverage: json["vote_average"].toDouble(),
    title: json["title"],
    overview: json["overview"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((e) => e)),
    releaseDate: json["release_date"],
  );
}
