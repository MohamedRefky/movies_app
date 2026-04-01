import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/core/utils/enumes.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';
import 'package:movies_app/movies/domain/usecase/movie/get_now_playing_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movie/get_popular_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movie/get_top_rated_usecase.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingUsecase getNowPlayingUsecase;
  final GetPopularUsecase getPopularUsecase;
  final GetTopRatedUsecase getTopRatedUsecase;
  final BaseMoviesRepository repository;
  
  MovieBloc(
    this.repository,
    this.getNowPlayingUsecase,
    this.getPopularUsecase,
    this.getTopRatedUsecase,
  ) : super(const MovieState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }

  Future<void> _getNowPlayingMovies(
    GetNowPlayingMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    final result = await getNowPlayingUsecase(NoParameters());
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

  Future<void> _getPopularMovies(
    GetPopularMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    final result = await getPopularUsecase(NoParameters());

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

  Future<void> _getTopRatedMovies(
    GetTopRatedMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    final result = await getTopRatedUsecase(NoParameters());

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
  Future<void> addToFavorites(int movieId) async {
  final result = await repository.addToFavoritesById(movieId);
  result.fold((l) => null, (r) => null);
}

Future<void> removeFromFavorites(int movieId) async {
  final result = await repository.removeFromFavoritesById(movieId);
  result.fold((l) => null, (r) => null);
}

Future<void> checkIfFavorite(int movieId) async {
  final result = await repository.isMovieFavorite(movieId);
  result.fold((l) => null, (r) => emit(state.copyWith(isFavorite: r)));
}
}
