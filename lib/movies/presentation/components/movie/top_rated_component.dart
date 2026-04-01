import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/core/utils/api_constance.dart';
import 'package:movies_app/core/utils/enumes.dart';
import 'package:movies_app/movies/presentation/controller/movie/movie_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movie/movie_event.dart';
import 'package:movies_app/movies/presentation/controller/movie/movie_state.dart';
import 'package:movies_app/movies/presentation/screens/movie_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class TopRatedComponent extends StatelessWidget {
  TopRatedComponent({super.key});

  final ValueNotifier<int> currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieBloc>()..add(GetTopRatedMoviesEvent()),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          switch (state.topRatedState) {
            case RequestState.loading:
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            case RequestState.error:
              return SizedBox(
                height: 200,
                child: Center(child: Text(state.topRatedMessage)),
              );
            case RequestState.loaded:
              return FadeIn(
                duration: const Duration(milliseconds: 500),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    viewportFraction: 0.32,
                    enlargeCenterPage: true,
                    initialPage: 0,
                    onPageChanged: (index, reason) {
                      currentIndex.value = index;
                    },
                  ),
                  items: state.topRatedMovies.asMap().entries.map((entry) {
                    int index = entry.key;
                    var movie = entry.value;

                    return ValueListenableBuilder(
                      valueListenable: currentIndex,
                      builder: (context, value, child) {
                        bool isActive = value == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          margin: EdgeInsets.symmetric(
                            vertical: isActive ? 0 : 8,
                            horizontal: 1,
                          ),
                          transform: Matrix4.identity()
                              ..scaleByDouble(
                            isActive ? 1.0 : 0.95,
                            isActive ? 1.0 : 0.95,
                            1,
                            1,
                          ),
                          child: FadeInRight(
                            from: 20,
                            duration: const Duration(milliseconds: 500),
                            child: child!,
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MovieDetailScreen(id: movie.id),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: ApiConstance.imageUrl(movie.backdropPath),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                height: 120,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
          }
        },
      ),
    );
  }
}
