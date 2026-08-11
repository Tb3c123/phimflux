import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import '../../../core/player/video_player_wrapper.dart';
import 'widgets/player_osd_top_bar.dart';

/// Fullscreen Video Player Screen with top navigation bar & web iframe support
class PlayerScreen extends StatelessWidget {
  final String movieTitle;
  final String episodeName;
  final String videoUrl;
  final String? embedUrl;
  final VoidCallback onBack;

  const PlayerScreen({
    super.key,
    required this.movieTitle,
    required this.episodeName,
    required this.videoUrl,
    this.embedUrl,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: VideoPlayerWrapper(
              videoUrl: videoUrl,
              embedUrl: embedUrl,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PointerInterceptor(
              child: PlayerOsdTopBar(
                movieTitle: movieTitle,
                episodeName: episodeName,
                onBack: onBack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
