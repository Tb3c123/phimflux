import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../theme/app_colors.dart';
import 'web_iframe/web_iframe_helper.dart';

/// Core Video Player wrapper supporting Web HTML iframe & Native WebView/ExoPlayer stream playback
class VideoPlayerWrapper extends StatefulWidget {
  final String videoUrl;
  final String? embedUrl;
  final bool autoPlay;
  final ValueChanged<VideoPlayerController>? onControllerInitialized;

  const VideoPlayerWrapper({
    super.key,
    required this.videoUrl,
    this.embedUrl,
    this.autoPlay = true,
    this.onControllerInitialized,
  });

  @override
  State<VideoPlayerWrapper> createState() => _VideoPlayerWrapperState();
}

class _VideoPlayerWrapperState extends State<VideoPlayerWrapper> {
  VideoPlayerController? _controller;
  WebViewController? _webViewController;
  bool _hasError = false;
  bool _useWebView = false;
  late String _viewId;

  @override
  void initState() {
    super.initState();
    final activeUrl = (widget.embedUrl != null && widget.embedUrl!.isNotEmpty)
        ? widget.embedUrl!
        : widget.videoUrl;
    _viewId = 'phimflux_iframe_${activeUrl.hashCode}';

    if (!kIsWeb) {
      if (activeUrl.contains('embed') || activeUrl.contains('player') || !activeUrl.endsWith('.m3u8')) {
        _initWebViewPlayer(activeUrl);
      } else {
        _initNativePlayer();
      }
    }
  }

  void _initWebViewPlayer(String url) {
    setState(() => _useWebView = true);
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            debugPrint('WebView Error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  Future<void> _initNativePlayer() async {
    try {
      final uri = Uri.parse(widget.videoUrl);
      _controller = VideoPlayerController.networkUrl(uri);
      await _controller!.initialize();
      if (widget.autoPlay) {
        await _controller!.play();
      }
      if (widget.onControllerInitialized != null) {
        widget.onControllerInitialized!(_controller!);
      }
      if (mounted) setState(() {});
    } catch (e) {
      final activeUrl = (widget.embedUrl != null && widget.embedUrl!.isNotEmpty)
          ? widget.embedUrl!
          : widget.videoUrl;
      _initWebViewPlayer(activeUrl);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      final activeUrl = (widget.embedUrl != null && widget.embedUrl!.isNotEmpty)
          ? widget.embedUrl!
          : widget.videoUrl;
      return Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: buildWebIframe(activeUrl, _viewId),
      );
    }

    if (_useWebView && _webViewController != null) {
      return Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: WebViewWidget(controller: _webViewController!),
      );
    }

    if (_hasError) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Text(
            'Không thể phát luồng video này',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    if (_controller != null && _controller!.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: VideoPlayer(_controller!),
      );
    }

    return Container(
      color: Colors.black,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primaryFocusGlow),
      ),
    );
  }
}
