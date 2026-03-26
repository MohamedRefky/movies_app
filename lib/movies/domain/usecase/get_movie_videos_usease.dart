import 'package:movies_app/movies/domain/entities/movie_video.dart';
import 'package:movies_app/movies/domain/repository/base_movie_details_repository.dart';

class GetMovieVideosUsease {
  GetMovieVideosUsease(this.baseMoviesRepository);

  final BaseMovieDetailsRepository baseMoviesRepository;

  Future<List<MovieVideo>> execute(int movieId) async {
    return await baseMoviesRepository.getMovieVideos(movieId);
  }
}
