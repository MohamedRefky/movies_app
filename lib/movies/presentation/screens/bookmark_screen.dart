import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart' show sl;
import 'package:movies_app/core/utils/enumes.dart';
import 'package:movies_app/movies/presentation/controller/favorites/favorites_bloc.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc(
        addUseCase: sl(),
        removeUseCase: sl(),
        getUseCase: sl(),
        isFavoriteUseCase: sl(),
      )..add(LoadFavoritesEvent()), // تحميل المفضلة
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Bookmarks")),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            switch (state.favoritesState) {
              case RequestState.loading:
                return const Center(child: CircularProgressIndicator());
              case RequestState.error:
                return const Center(child: Text("Failed to load favorites."));
              case RequestState.loaded:
                if (state.favorites.isEmpty) {
                  return const Center(child: Text("No favorites yet."));
                } else {
                  return ListView.builder(
                    itemCount: state.favorites.length,
                    itemBuilder: (context, index) {
                      final movie = state.favorites[index];

                      return ListTile(
                        leading: const Icon(Icons.movie),
                        title: Text(movie.title),
                        subtitle: Text(movie.overview),

                        trailing: IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            context.read<FavoritesBloc>().add(
                              RemoveFavoriteEvent(movie.id),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
