import 'package:dio/dio.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/error_message_model.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/core/utils/api_constance.dart';
import 'package:movies_app/movies/data/models/movie_details_model.dart';
import 'package:movies_app/movies/data/models/movie_model.dart';
import 'package:movies_app/movies/data/models/movie_video_model.dart';
import 'package:movies_app/movies/data/models/recommendations_model.dart';
import 'package:movies_app/movies/domain/usecase/get_recommendations_usecase.dart';

abstract class BaseMoviesRemoteDatasource {
  Future<List<MovieModel>> getNawPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  Future<MovieDetailsModel> getMovieDetails(MovieId paraimeter);
  Future<List<RecommendationsModel>> getMovieRecommendations(
    RecommendationsParameter paraimeter,
  );

  Future<List<MovieVideoModel>> getMovieVideos(MovieId paraimeter);
}

class MoviesRemoteDatasource implements BaseMoviesRemoteDatasource {
  final dio = Dio();
  @override
  Future<List<MovieModel>> getNawPlayingMovies() async {
    final response = await dio.get(ApiConstance.nowPlayingMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
      );
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await dio.get(ApiConstance.popularMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
      );
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await dio.get(ApiConstance.topRatedMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
      );
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieVideoModel>> getMovieVideos(MovieId parameter) async {
    final response = await dio.get(ApiConstance.movieVideos(parameter.movieId));
    if (response.statusCode == 200) {
      return List<MovieVideoModel>.from(
        (response.data['results'] as List).map(
          (e) => MovieVideoModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(MovieId parameter) async {
    final response = await dio.get(
      ApiConstance.movieDetails(parameter.movieId),
    );
    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(response.data);
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<RecommendationsModel>> getMovieRecommendations(
    RecommendationsParameter paraimeter,
  ) async {
    final response = await dio.get(
      ApiConstance.movieRecommendations(paraimeter.id),
    );
    if (response.statusCode == 200) {
      return List<RecommendationsModel>.from(
        (response.data['results'] as List).map(
          (e) => RecommendationsModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
