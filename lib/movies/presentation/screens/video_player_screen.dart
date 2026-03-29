import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatelessWidget {
  final YoutubePlayerController controller;
  const VideoPlayerScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      },
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      },
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
          bufferedColor: Colors.white38,
        ),
        onReady: () => controller.play(),
      ),
      builder: (context, player) {
        
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            // ✅ AppBar بيتحدث تلقائي
            title: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, YoutubePlayerValue value, _) {
                final isLoaded = value.metaData.title.isNotEmpty;
                return isLoaded
                    ? Text(
                        value.metaData.title.isNotEmpty
                            ? value.metaData.title
                            : 'Trailer',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[600]!,
                        child: Container(
                          height: 16,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:  Column(
              children: [
                player,
                const SizedBox(height: 16),
                // ✅ المعلومات بتتحدث تلقائي
                ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (context, YoutubePlayerValue value, _) {
                    final isLoaded = value.metaData.title.isNotEmpty;
                    return isLoaded ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.metaData.title.isNotEmpty
                              ? value.metaData.title
                              : '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          value.metaData.author.isNotEmpty
                              ? value.metaData.author
                              : '',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ) : Shimmer.fromColors(
                      baseColor: Colors.grey[800]!,
                      highlightColor: Colors.grey[600]!,
                      child: Column( 
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 14,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
