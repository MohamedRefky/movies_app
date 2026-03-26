import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetTopRatedUsecase {
  GetTopRatedUsecase(this.baseMoviesRepository);
  final BaseMoviesRepository baseMoviesRepository;
  Future<List<Movie>> execute() async{
    return await baseMoviesRepository.getTopRatedMovies();
  }
}