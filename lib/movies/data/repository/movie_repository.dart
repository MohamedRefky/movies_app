import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/core/utils/movie_mapper.dart';
import 'package:movies_app/movies/data/data_source/movies_remote_datasource.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';
import 'package:movies_app/movies/domain/entities/movie_video.dart';
import 'package:movies_app/movies/domain/entities/recommendations.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';
import 'package:movies_app/movies/domain/usecase/details/get_recommendations_usecase.dart';

class MovieRepository extends BaseMoviesRepository {
  MovieRepository(this.baseMoviesRemoteDataSource, this.favoritesBox);
  final BaseMoviesRemoteDatasource baseMoviesRemoteDataSource;
  final Box<int> favoritesBox;

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    final result = await baseMoviesRemoteDataSource.getNawPlayingMovies();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    final result = await baseMoviesRemoteDataSource.getPopularMovies();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    final result = await baseMoviesRemoteDataSource.getTopRatedMovies();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<MovieVideo>>> getMovieVideos(
    MovieId parameter,
  ) async {
    final result = await baseMoviesRemoteDataSource.getMovieVideos(parameter);
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(
    MovieId parameter,
  ) async {
    final result = await baseMoviesRemoteDataSource.getMovieDetails(parameter);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Recommendations>>> getMovieRecommendations(
    RecommendationsParameter parameter,
  ) async {
    final result = await baseMoviesRemoteDataSource.getMovieRecommendations(
      parameter,
    );
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> addToFavoritesById(int movieId) async {
    try {
      await favoritesBox.put(movieId, movieId);
      return Right('Added to Favorites');
    } catch (e) {
      return Left(DatabaseFailure('Could not add to favorites'));
    }
  }

  @override
  Future<Either<Failure, String>> removeFromFavoritesById(int movieId) async {
    try {
      await favoritesBox.delete(movieId);
      return Right('Removed from Favorites');
    } catch (e) {
      return Left(DatabaseFailure('Could not remove from favorites'));
    }
  }

  @override
  Future<Either<Failure, bool>> isMovieFavorite(int movieId) async {
    try {
      final exists = favoritesBox.containsKey(movieId);
      return Right(exists);
    } catch (e) {
      return Left(DatabaseFailure('Could not check favorite'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getFavorites() async {
    try {
      final ids = favoritesBox.values.toList();
      List<Movie> movies = [];
      // لو عندك طريقة للحصول على تفاصيل الأفلام من API:
      for (var id in ids) {
        // مثال وهمي لتحويل id → MovieDetails → Movie
        final movieDetails = MovieDetails(id: id, title: 'Movie $id');
        movies.add(movieDetails.toMovie());
      }
      return Right(movies);
    } catch (e) {
      return Left(DatabaseFailure('Could not load favorites'));
    }
  }
}
