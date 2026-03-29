import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/utils/api_constance.dart';
import 'package:movies_app/core/utils/enumes.dart';
import 'package:movies_app/movies/domain/entities/genres.dart';
import 'package:movies_app/movies/presentation/controller/details/movie_details_bloc.dart';
import 'package:movies_app/movies/presentation/screens/video_player_screen.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        final movie = state.movieDetails!;
        switch (state.movieDetailsState) {
          case RequestState.loading:
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );

          case RequestState.error:
            return SliverToBoxAdapter(
              child: Center(child: Text(state.movieDetailsMessage)),
            );
          case RequestState.loaded:
            return SliverMainAxisGroup(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                              Colors.black,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.5, 1.0, 1.0],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstIn,
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          imageUrl: ApiConstance.imageUrl(
                            movie.backdropPath ?? '',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  movie.releaseDate?.split('-')[0] ?? '',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20.0,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                (movie.voteAverage ?? 0 / 2).toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Text(
                                _formatDuration(
                                  state.movieDetails?.runtime ?? 0,
                                ),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Spacer(),
                              if (state.movieVideos.isNotEmpty &&
                                  state.videoPlayerController != null)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VideoPlayerScreen(
                                          controller:
                                              state.videoPlayerController!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        FontAwesomeIcons.youtube,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "Watch",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            movie.overview ?? '',
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Genres: ${_showGenres(movie.genres ?? [])}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
        }
      },
    );
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }
    return result.isEmpty ? result : result.substring(0, result.length - 2);
  }
}

String _formatDuration(int minutes) {
  final hours = minutes ~/ 60;
  final mins = minutes % 60;
  return '${hours}h ${mins}m';
}
