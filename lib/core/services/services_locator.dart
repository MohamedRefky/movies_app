import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/movies/data/data_source/movies_remote_datasource.dart';
import 'package:movies_app/movies/data/repository/movie_repository.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';
import 'package:movies_app/movies/domain/usecase/details/get_movie_details_usease.dart';
import 'package:movies_app/movies/domain/usecase/details/get_recommendations_usecase.dart';
import 'package:movies_app/movies/domain/usecase/favorites/add_to_favorites_usecase.dart';
import 'package:movies_app/movies/domain/usecase/favorites/get_favorites_usecase.dart';
import 'package:movies_app/movies/domain/usecase/favorites/is_movie_favorite_usecase.dart';
import 'package:movies_app/movies/domain/usecase/favorites/remove_from_favorites_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movie/get_now_playing_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movie/get_popular_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movie/get_top_rated_usecase.dart';
import 'package:movies_app/movies/domain/usecase/video/get_movie_videos_usease.dart';
import 'package:movies_app/movies/presentation/controller/details/movie_details_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movie/movie_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// BLOC
    sl.registerFactory(() => MovieBloc(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => MovieDetailsBloc(sl(), sl(), sl()));

    /// Use Cases
    sl.registerLazySingleton(() => GetNowPlayingUsecase(sl()));
    sl.registerLazySingleton(() => GetPopularUsecase(sl()));
    sl.registerLazySingleton(() => GetTopRatedUsecase(sl()));
    sl.registerLazySingleton(() => GetMovieDetailsUsease(sl()));
    sl.registerLazySingleton(() => GetRecommendationsUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieVideosUsease(sl()));

    /// Repositories
    sl.registerLazySingleton<BaseMoviesRepository>(
      () => MovieRepository(sl(), Hive.box<int>('favoritesBox')),
    );

    /// DATA SOURCE
    sl.registerLazySingleton<BaseMoviesRemoteDatasource>(
      () => MoviesRemoteDatasource(),
    );
    // FAVORITES
    sl.registerLazySingleton(() => AddToFavoritesUsecase(sl()));
    sl.registerLazySingleton(() => RemoveFromFavoritesUsecase(sl()));
    sl.registerLazySingleton(() => GetFavoritesUsecase(sl()));
    sl.registerLazySingleton(() => IsMovieFavoriteUsecase(sl()));
  }
}
