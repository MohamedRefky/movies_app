import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';

extension MovieDetailsMapper on MovieDetails {
  Movie toMovie() {
    return Movie(
      id: id!,
      title: title ?? '',
      backdropPath: backdropPath ?? '',
      overview: overview ?? '',
      voteAverage: voteAverage ?? 0.0,
      releaseDate: releaseDate ?? '',
      genreIds: genres?.map((g) => g.id).toList() ?? [],
    );
  }
}
