import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';
import 'package:movies_app/movies/domain/entities/movie_video.dart';
import 'package:movies_app/movies/domain/entities/recommendations.dart';
import 'package:movies_app/movies/domain/usecase/details/get_recommendations_usecase.dart';

abstract class BaseMoviesRepository {
  // Movies
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  // Movie Details
  Future<Either<Failure, MovieDetails>> getMovieDetails(MovieId parameter);
  Future<Either<Failure, List<Recommendations>>> getMovieRecommendations(
    RecommendationsParameter parameter,
  ); 
  // Movie Videos
  Future<Either<Failure, List<MovieVideo>>> getMovieVideos(MovieId parameter);
  // Favorit Movies 
  Future<Either<Failure, String>> addToFavoritesById(int movieId);
  Future<Either<Failure, String>> removeFromFavoritesById(int movieId);
  Future<Either<Failure, bool>> isMovieFavorite(int movieId);
  Future<Either<Failure, List<Movie>>> getFavorites();
}
