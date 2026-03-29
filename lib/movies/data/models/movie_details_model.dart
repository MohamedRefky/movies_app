import 'package:movies_app/movies/data/models/genres_model.dart';
import 'package:movies_app/movies/domain/entities/genres.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel({
    required super.runtime,
    required super.id,
    required super.title,
    required super.backdropPath,
    required super.overview,
    required super.releaseDate,
    required super.genres,
    required super.voteAverage,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      runtime: json['runtime'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      genres: List<Genres>.from(
        json['genres'].map((e) => GenresModel.fromJson(e)).toList() ?? [],
      ),
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}
