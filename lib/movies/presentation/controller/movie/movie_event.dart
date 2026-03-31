import 'package:equatable/equatable.dart';

  class MovieEvent extends Equatable {
    /// Todo abstract
  @override
  List<Object?> get props => [];
}

class GetNowPlayingMoviesEvent extends MovieEvent {}

class GetPopularMoviesEvent extends MovieEvent {}

class GetTopRatedMoviesEvent extends MovieEvent {}

