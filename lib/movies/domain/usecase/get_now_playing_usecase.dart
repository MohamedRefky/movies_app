import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart' show Failure;
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetNowPlayingUsecase extends BaseUseCase<List<Movie>> {
  GetNowPlayingUsecase(this.baseMoviesRepository);

  final BaseMoviesRepository baseMoviesRepository;

  @override
  Future<Either<Failure, List<Movie>>> call() async {
    return await baseMoviesRepository.getNowPlayingMovies();
  }
}
