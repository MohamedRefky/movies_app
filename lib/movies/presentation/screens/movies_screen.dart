import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/movies/presentation/components/movie/custom_container.dart';
import 'package:movies_app/movies/presentation/components/movie/now_playing_component.dart';
import 'package:movies_app/movies/presentation/components/movie/populer_component.dart';
import 'package:movies_app/movies/presentation/components/movie/top_rated_component.dart';
import 'package:movies_app/movies/presentation/controller/movie/movie_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movie/movie_event.dart';
import 'package:movies_app/movies/presentation/screens/popular_movie_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieBloc>()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatedMoviesEvent()),
      child: Scaffold(
        body: SingleChildScrollView(
          key: const Key('movieScrollView'),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NowPlayingComponent(),
                CustomContainer(
                  titel: "Popular",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PopularMovieScreen(),
                      ),
                    );
                  },
                ),
                PopularComponent(),
                CustomContainer(
                  titel: "Top Rated",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TopRatedComponent(),
                      ),
                    );
                  },
                ),
                TopRatedComponent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
