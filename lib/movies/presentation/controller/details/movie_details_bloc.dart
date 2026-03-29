import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/core/utils/enumes.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';
import 'package:movies_app/movies/domain/entities/movie_video.dart';
import 'package:movies_app/movies/domain/entities/recommendations.dart';
import 'package:movies_app/movies/domain/usecase/get_movie_details_usease.dart';
import 'package:movies_app/movies/domain/usecase/get_movie_videos_usease.dart';
import 'package:movies_app/movies/domain/usecase/get_recommendations_usecase.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUsease getMovieDetailsUsease;
  final GetRecommendationsUseCase getMovieRecommendationsUsease;
  final GetMovieVideosUsease getMovieVideosUsease;

  MovieDetailsBloc(
    this.getMovieDetailsUsease,
    this.getMovieRecommendationsUsease,
    this.getMovieVideosUsease,
  ) : super(MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetMovieRecommendationsEvent>(_getMovieRecommendations);
    on<GetMovieVideosEvent>(_getMovieVideos);
  }

  FutureOr<void> _getMovieDetails(
    GetMovieDetailsEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    final result = await getMovieDetailsUsease(MovieId(event.movieId));
    result.fold(
      (l) => emit(
        state.copyWith(
          movieDetailsState: RequestState.error,
          movieDetailsMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(movieDetails: r, movieDetailsState: RequestState.loaded),
      ),
    );
  }

  FutureOr<void> _getMovieRecommendations(
    GetMovieRecommendationsEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    final result = await getMovieRecommendationsUsease(
      RecommendationsParameter(event.movieId, id: event.movieId),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          recommendationsState: RequestState.error,
          recommendationsMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          recommendations: r,
          recommendationsState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getMovieVideos(
    GetMovieVideosEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    final result = await getMovieVideosUsease(MovieId(event.movieId));
    result.fold(
      (l) => emit(
        state.copyWith(
          movieVideosState: RequestState.error,
          movieVideosMessage: l.message,
        ),
      ),
      (r) {
        // ✅ اختار الـ trailer
        MovieVideo? trailer;
        try {
          trailer = r.firstWhere((video) => video.type == "Trailer");
        } catch (e) {
          trailer = r.isNotEmpty ? r.first : null;
        }

        // ✅ اعمل الـ controller لو في فيديو
        final controller = trailer != null
            ? YoutubePlayerController(
                initialVideoId: trailer.key,
                flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
              )
            : null;

        emit(
          state.copyWith(
            movieVideos: r,
            movieVideosState: RequestState.loaded,
            videoPlayerController: controller, // ✅
          ),
        );
      },
    );
  }

  // ✅ dispose الـ controller لما الـ Bloc يتقفل
  @override
  Future<void> close() {
    state.videoPlayerController?.dispose();
    return super.close();
  }
}
