import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class IsMovieFavoriteUsecase {
  final BaseMoviesRepository repository;

  IsMovieFavoriteUsecase(this.repository);

  Future<Either<Failure, bool>> call(int movieId) async {
    return await repository.isMovieFavorite(movieId);
  }
}
