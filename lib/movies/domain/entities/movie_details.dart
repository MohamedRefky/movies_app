import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/domain/entities/genres.dart';

class MovieDetails extends Equatable {
  const MovieDetails({
    required this.runtime,
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.genres,
    required this.voteAverage,
  });
  final int id;
  final int runtime;
  final String title;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final List<Genres> genres;
  final double voteAverage;

  @override
  List<Object?> get props => [
    runtime,
    id,
    title,
    backdropPath,
    overview,
    releaseDate,
    genres,
    voteAverage,
  ];
}
