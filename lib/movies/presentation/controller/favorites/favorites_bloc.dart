import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/enumes.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/usecase/favorites/add_to_favorites_usecase.dart';
import 'package:movies_app/movies/domain/usecase/favorites/get_favorites_usecase.dart';
import 'package:movies_app/movies/domain/usecase/favorites/is_movie_favorite_usecase.dart';
import 'package:movies_app/movies/domain/usecase/favorites/remove_from_favorites_usecase.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final AddToFavoritesUsecase addUseCase;
  final RemoveFromFavoritesUsecase removeUseCase;
  final GetFavoritesUsecase getUseCase;
  final IsMovieFavoriteUsecase isFavoriteUseCase;

  FavoritesBloc({
    required this.addUseCase,
    required this.removeUseCase,
    required this.getUseCase,
    required this.isFavoriteUseCase,
  }) : super(FavoritesInitial()) {
    on<LoadFavoritesEvent>((event, emit) async {
      emit(FavoritesLoading());
      final result = await getUseCase();
      result.fold(
        (l) => emit(FavoritesError(l.message)),
        (r) => emit(FavoritesLoaded(r)),
      );
    });

    on<AddFavoriteEvent>((event, emit) async {
      final result = await addUseCase(event.movieId);
      result.fold(
        (l) => emit(FavoritesError(l.message)),
        (_) => add(LoadFavoritesEvent()),
      );
    });

    on<RemoveFavoriteEvent>((event, emit) async {
      final result = await removeUseCase(event.movieId);
      result.fold(
        (l) => emit(FavoritesError(l.message)),
        (_) => add(LoadFavoritesEvent()),
      );
    });
  }
}
