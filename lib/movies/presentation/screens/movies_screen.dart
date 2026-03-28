import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/movies/presentation/components/custom_container.dart';
import 'package:movies_app/movies/presentation/components/now_playing_component.dart';
import 'package:movies_app/movies/presentation/components/populer_component.dart';
import 'package:movies_app/movies/presentation/components/top_rated_component.dart';
import 'package:movies_app/movies/presentation/controller/movie_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movie_event.dart';

class MainMoviesScreen extends StatelessWidget {
  const MainMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieBloc>()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatedMoviesEvent()),
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SingleChildScrollView(
          key: const Key('movieScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NowPlayingComponent(),
              CustomContainer(titel: "Popular", onTap: () {}),
              PopulerComponent(),
              CustomContainer(titel: "Top Rated", onTap: () {}),
              TopRatedComponent(),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
