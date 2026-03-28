import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/api_constance.dart';
import 'package:movies_app/core/utils/enumes.dart';
import 'package:movies_app/movies/presentation/controller/movie_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movie_state.dart';

class NowPlayingComponent extends StatelessWidget {
  const NowPlayingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: (previous, current) =>
          previous.nawPlayingState != current.nawPlayingState,
      builder: (BuildContext context, MovieState state) {
        switch (state.nawPlayingState) {
          case RequestState.loading:
            return const SizedBox(
              height: 400.0,
              child: Center(child: CircularProgressIndicator()),
            );

          case RequestState.error:
            return SizedBox(
              height: 400.0,
              child: Center(child: Text(state.nawPlayngMessage)),
            );

          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 400.0,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {},
                ),
                items: state.nowPlayingMovies.map((item) {
                  return GestureDetector(
                    onTap: () {
                      /// TODO : NAVIGATE TO MOVIE DETAILS
                    },
                    child: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                // fromLTRB
                                Colors.transparent,
                                Colors.black12.withValues(alpha: 1.0),
                                Colors.black12.withValues(alpha: 1.0),
                                Colors.transparent,
                              ],
                              stops: [0, 0.2, 0.5, 1],
                            ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height),
                            );
                          },
                          blendMode: BlendMode.dstIn,
                          child: CachedNetworkImage(
                            height: 560.0,
                            imageUrl: ApiConstance.imageUrl(item.backdropPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.redAccent,
                                      size: 16.0,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      'Now Playing'.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
        }
      },
    );
  }
}
