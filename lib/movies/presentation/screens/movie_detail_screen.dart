import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/core/utils/enumes.dart';
import 'package:movies_app/movies/presentation/components/movie_details/movie_details.dart';
import 'package:movies_app/movies/presentation/components/movie_details/recommendations.dart';
import 'package:movies_app/movies/presentation/controller/details/movie_details_bloc.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  const MovieDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailsBloc>()
        ..add(GetMovieDetailsEvent(id))
        ..add(GetMovieRecommendationsEvent(id))
        ..add(GetMovieVideosEvent(id)),
      child: const Scaffold(body: MovieDetailContent()),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        switch (state.movieDetailsState) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());

          case RequestState.error:
            return Center(child: Text(state.movieDetailsMessage));

          case RequestState.loaded:
            return CustomScrollView(
              key: Key('movieDetailScrollView'),
              slivers: [MovieDetails(), const Recommendations()],
            );
        }
      },
    );
  }
}
