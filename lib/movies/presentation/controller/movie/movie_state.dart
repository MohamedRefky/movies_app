import 'package:equatable/equatable.dart';
import 'package:movies_app/core/utils/enumes.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';

class MovieState extends Equatable {
  const MovieState({
    this.nowPlayingMovies = const [],
    this.nawPlayingState = RequestState.loading,
    this.nawPlayngMessage = '',
    this.popularMovies = const [],
    this.populerState = RequestState.loading,
    this.populerMessage = '',
    this.topRatedMovies = const [],
    this.topRatedState = RequestState.loading,
    this.topRatedMessage = '',
  });
  final List<Movie> nowPlayingMovies;
  final RequestState nawPlayingState;
  final String nawPlayngMessage;
  final List<Movie> popularMovies;
  final RequestState populerState;
  final String populerMessage;
  final List<Movie> topRatedMovies;
  final RequestState topRatedState;
  final String topRatedMessage;
  
  MovieState copyWith({
    List<Movie>? nowPlayingMovies,
    RequestState? nawPlayingState,
    String? nawPlayngMessage,
    List<Movie>? popularMovies,
    RequestState? populerState,
    String? populerMessage,
    List<Movie>? topRatedMovies,
    RequestState? topRatedState,
    String? topRatedMessage,
  }) {
    return MovieState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nawPlayingState: nawPlayingState ?? this.nawPlayingState,
      nawPlayngMessage: nawPlayngMessage ?? this.nawPlayngMessage,
      popularMovies: popularMovies ?? this.popularMovies,
      populerState: populerState ?? this.populerState,
      populerMessage: populerMessage ?? this.populerMessage,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedState: topRatedState ?? this.topRatedState,
      topRatedMessage: topRatedMessage ?? this.topRatedMessage,
    );
  }

  @override
  List<Object?> get props => [
    nowPlayingMovies,
    nawPlayingState,
    nawPlayngMessage,
    popularMovies,
    populerState,
    populerMessage,
    topRatedMovies,
    topRatedState,
    topRatedMessage,
  ];
}
