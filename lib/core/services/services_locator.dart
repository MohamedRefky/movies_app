import 'package:get_it/get_it.dart';
import 'package:movies_app/movies/data/data_source/movies_remote_datasource.dart';
import 'package:movies_app/movies/data/repository/movie_repository.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';
import 'package:movies_app/movies/domain/usecase/get_now_playing_usecase.dart';
import 'package:movies_app/movies/domain/usecase/get_popular_usecase.dart';
import 'package:movies_app/movies/domain/usecase/get_top_rated_usecase.dart';
import 'package:movies_app/movies/presentation/controller/movie_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// BLOC
    sl.registerFactory(() => MovieBloc(sl() ,sl(),sl()));
    /// Use Cases
    sl.registerLazySingleton(() => GetNowPlayingUsecase(sl()));
    sl.registerLazySingleton(() => GetPopularUsecase(sl()));
    sl.registerLazySingleton(() => GetTopRatedUsecase(sl()));

    /// Repositories
    sl.registerLazySingleton<BaseMoviesRepository>(() => MovieRepository(sl()));

    /// DATA SOURCE
    sl.registerLazySingleton<BaseMoviesRemoteDatasource>(
      () => MoviesRemoteDatasource(),
    );
  }
}
