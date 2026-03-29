import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/core/utils/enumes.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';
import 'package:movies_app/movies/domain/entities/recommendations.dart';
import 'package:movies_app/movies/domain/usecase/get_movie_details_usease.dart';
import 'package:movies_app/movies/domain/usecase/get_recommendations_usecase.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUsease getMovieDetailsUsease;
  final GetRecommendationsUseCase getMovieRecommendationsUsease;
  MovieDetailsBloc(
    this.getMovieDetailsUsease,
    this.getMovieRecommendationsUsease,
  ) : super(MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetMovieRecommendationsEvent>(_getMovieRecommendations);
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
}
