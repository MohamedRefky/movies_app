import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'movie.g.dart';
@HiveType(typeId: 0)
class Movie extends Equatable {
   @HiveField(0)
  final int id;
  @HiveField(1)
  final double voteAverage;
    @HiveField(2)
  final String title;
    @HiveField(3)
  final String releaseDate;
    @HiveField(4)
  final String overview;
    @HiveField(5)
  final String backdropPath;
    @HiveField(6)
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
