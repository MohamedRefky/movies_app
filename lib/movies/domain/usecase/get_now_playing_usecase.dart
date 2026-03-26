import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetNowPlayingUsecase {
  GetNowPlayingUsecase(this.baseMoviesRepository);

  final BaseMoviesRepository baseMoviesRepository;

  Future<List<Movie>> execute() async {
    return await baseMoviesRepository.getNowPlayingMovies();
  }
}
