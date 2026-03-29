part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetailsEvent extends MovieDetailsEvent {
  final int movieId;
  const GetMovieDetailsEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}



class GetMovieVideosEvent extends MovieDetailsEvent {
  final int movieId;

  const GetMovieVideosEvent(this.movieId);
  @override
  List<Object> get props => [movieId];
}
class GetMovieRecommendationsEvent  extends MovieDetailsEvent {
  final int movieId;
  const GetMovieRecommendationsEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
