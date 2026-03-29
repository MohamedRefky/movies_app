import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/error/failure.dart';

abstract class BaseUseCase<T, Paraimeter> {
  Future<Either<Failure, T>> call(Paraimeter paraimeter);
}

class NoParameters extends Equatable {
  const NoParameters();
  @override
  List<Object?> get props => [];
}


class MovieId extends Equatable {
  final int movieId;
  

  const MovieId(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
