import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetMovieDetailsUsease extends BaseUseCase<MovieDetails, MovieId> {
  GetMovieDetailsUsease(this.baseMoviesRepository);
  final BaseMoviesRepository baseMoviesRepository;

  @override
  Future<Either<Failure, MovieDetails>> call(MovieId paraimeter) async {
    return await baseMoviesRepository.getMovieDetails(paraimeter);
  }
}
