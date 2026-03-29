import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/recommendations.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetRecommendationsUseCase
    extends BaseUseCase<List<Recommendations>, RecommendationsParameter> {
  final BaseMoviesRepository baseMoviesRepository;

  GetRecommendationsUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Recommendations>>> call(
    RecommendationsParameter paraimeter,
  ) async {
    return await baseMoviesRepository.getMovieRecommendations(paraimeter);
  }
}

class RecommendationsParameter extends Equatable {
  final int id;

  const RecommendationsParameter(int movieId, {required this.id});

  @override
  List<Object?> get props => [id];
}
