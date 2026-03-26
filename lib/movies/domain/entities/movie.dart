import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final double voteAverage;
  final String title;
  final String releaseDate;
  final String overview;
  final String backdropPath;
  final List<int> genreIds;

  const Movie({
    required this.id,
    required this.voteAverage,
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.genreIds,
    required this.releaseDate,
  });

  @override
  List<Object?> get props => [
    id,
    voteAverage,
    title,
    overview,
    backdropPath,
    genreIds,
    releaseDate,
  ];
}
