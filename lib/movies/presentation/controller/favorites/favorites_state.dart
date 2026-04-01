
part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    this.favorites = const [],
    this.favoritesState = RequestState.loading,
    this.message = '',
  });

  final List<Movie> favorites;
  final RequestState favoritesState;
  final String message;

  FavoritesState copyWith({
    List<Movie>? favorites,
    RequestState? favoritesState,
    String? message,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      favoritesState: favoritesState ?? this.favoritesState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [favorites, favoritesState, message];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  @override
  final List<Movie> favorites;
  const FavoritesLoaded(this.favorites);
  @override
  List<Object?> get props => [favorites];
}

class FavoritesError extends FavoritesState {
  @override
  final String message;
  const FavoritesError(this.message);
  @override
  List<Object?> get props => [message];
}
