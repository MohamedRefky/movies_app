import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/movies/domain/entities/movie_video.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';


class GetMovieVideosUsease {
  GetMovieVideosUsease(this.baseMoviesRepository);

  final BaseMoviesRepository baseMoviesRepository;

  Future<Either<Failure, List<MovieVideo>>> execute(int movieId) async {
    return await baseMoviesRepository.getMovieVideos(movieId);
  }
}
