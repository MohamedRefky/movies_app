import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart' show Failure;
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetNowPlayingUsecase {
  GetNowPlayingUsecase(this.baseMoviesRepository);

  final BaseMoviesRepository baseMoviesRepository;

  Future<Either<Failure, List<Movie>>> execute() async {
    return await baseMoviesRepository.getNowPlayingMovies();
  }
}
