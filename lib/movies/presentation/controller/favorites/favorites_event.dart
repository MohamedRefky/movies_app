// lib/movies/presentation/controller/favorites/favorites_event.dart
part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent {}

class AddFavoriteEvent extends FavoritesEvent {
  final int movieId;
  AddFavoriteEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final int movieId;
  RemoveFavoriteEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
}