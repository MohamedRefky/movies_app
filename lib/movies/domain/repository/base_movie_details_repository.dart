import 'package:movies_app/movies/domain/entities/movie_video.dart';

abstract class BaseMovieDetailsRepository {
  Future<List<MovieVideo>> getMovieVideos(int movieId);
}
