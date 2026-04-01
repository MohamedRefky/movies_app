import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/movie_video.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetMovieVideosUsease extends BaseUseCase<List<MovieVideo>, MovieId> {
  GetMovieVideosUsease(this.baseMoviesRepository);

  final BaseMoviesRepository baseMoviesRepository;

  @override
  Future<Either<Failure, List<MovieVideo>>> call(MovieId paraimeter) async {
    return await baseMoviesRepository.getMovieVideos(paraimeter);
  }
}
