part of 'movie_details_bloc.dart';

class MovieDetailsState extends Equatable {
  const MovieDetailsState({
    this.movieDetails,
    this.movieDetailsState = RequestState.loading,
    this.movieDetailsMessage = '',
    this.recommendations = const [],
    this.recommendationsState = RequestState.loading,
    this.recommendationsMessage = '',
    this.movieVideos = const [],
    this.movieVideosState = RequestState.loading,
    this.movieVideosMessage = '',
      this.videoPlayerController,
  });

  final MovieDetails? movieDetails;
  final RequestState movieDetailsState;
  final String movieDetailsMessage;
  final List<Recommendations> recommendations;
  final RequestState recommendationsState;
  final String recommendationsMessage;
  final List<MovieVideo> movieVideos;
  final RequestState movieVideosState;
  final String movieVideosMessage;
  final YoutubePlayerController? videoPlayerController;

  MovieDetailsState copyWith({
    MovieDetails? movieDetails,
    RequestState? movieDetailsState,
    String? movieDetailsMessage,
    List<Recommendations>? recommendations,
    RequestState? recommendationsState,
    String? recommendationsMessage,
    List<MovieVideo>? movieVideos,
    RequestState? movieVideosState,
    String? movieVideosMessage,
    YoutubePlayerController? videoPlayerController,
  }) {
    return MovieDetailsState(
      movieDetails: movieDetails ?? this.movieDetails,
      movieDetailsState: movieDetailsState ?? this.movieDetailsState,
      movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,
      recommendations: recommendations ?? this.recommendations,
      recommendationsState: recommendationsState ?? this.recommendationsState,
      recommendationsMessage:
          recommendationsMessage ?? this.recommendationsMessage,
      movieVideos: movieVideos ?? this.movieVideos,
      movieVideosState: movieVideosState ?? this.movieVideosState,
      movieVideosMessage: movieVideosMessage ?? this.movieVideosMessage,
      videoPlayerController: videoPlayerController ?? this.videoPlayerController,
    );
  }

  @override
  List<Object> get props => [
    movieDetailsState,
    movieDetailsMessage,
    movieDetails ?? [],
    recommendationsState,
    recommendationsMessage,
    recommendations,
    movieVideos,
    movieVideosState,
    movieVideosMessage,
    
  ];
}
