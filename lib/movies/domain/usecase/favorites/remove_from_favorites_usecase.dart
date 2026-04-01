import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class RemoveFromFavoritesUsecase {
  final BaseMoviesRepository baseMoviesRepository;
  RemoveFromFavoritesUsecase(this.baseMoviesRepository);

  Future<Either<Failure, String>> call(int movieId) async {
    return await baseMoviesRepository.removeFromFavoritesById(movieId);
  }
}
