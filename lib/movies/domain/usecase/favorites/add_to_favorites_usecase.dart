import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class AddToFavoritesUsecase {
   final BaseMoviesRepository baseMoviesRepository;
  AddToFavoritesUsecase(this.baseMoviesRepository);

  Future<Either<Failure, String>> call(int movieId) async {
    return await baseMoviesRepository.addToFavoritesById(movieId);
  }
  
}