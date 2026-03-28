import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/enumes.dart';
import 'package:movies_app/movies/domain/usecase/get_now_playing_usecase.dart';
import 'package:movies_app/movies/domain/usecase/get_popular_usecase.dart';
import 'package:movies_app/movies/domain/usecase/get_top_rated_usecase.dart';

import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingUsecase getNowPlayingUsecase;
  final GetPopularUsecase getPopularUsecase;
  final GetTopRatedUsecase getTopRatedUsecase;
  MovieBloc(
    this.getNowPlayingUsecase,
    this.getPopularUsecase,
    this.getTopRatedUsecase,
  ) : super(const MovieState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
    GetNowPlayingMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    final result = await getNowPlayingUsecase.call();
    result.fold(
      (failure) => emit(
        state.copyWith(
          nawPlayingState: RequestState.error,
          nawPlayngMessage: failure.message,
        ),
      ),
      (movies) {
        emit(
          state.copyWith(
            nowPlayingMovies: movies,
            nawPlayingState: RequestState.loaded,
          ),
        );
      },
    );
  }

  FutureOr<void> _getPopularMovies(
    GetPopularMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    final result = await getPopularUsecase.call();

    result.fold(
      (failure) => emit(
        state.copyWith(
          populerState: RequestState.error,
          populerMessage: failure.message,
        ),
      ),
      (movies) {
        emit(
          state.copyWith(
            popularMovies: movies,
            populerState: RequestState.loaded,
          ),
        );
      },
    );
  }

  FutureOr<void> _getTopRatedMovies(
    GetTopRatedMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    final result = await getTopRatedUsecase.call();

    result.fold(
      (failure) => emit(
        state.copyWith(
          topRatedState: RequestState.error,
          topRatedMessage: failure.message,
        ),
      ),
      (movies) {
        emit(
          state.copyWith(
            topRatedMovies: movies,
            topRatedState: RequestState.loaded,
          ),
        );
      },
    );
  }
}
