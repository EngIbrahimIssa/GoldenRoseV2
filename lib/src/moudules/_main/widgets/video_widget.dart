import 'package:entaj/src/entities/module_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart' as y;
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../colors.dart';
import '../../../utils/custom_widget/custom_text.dart';
import '../../../utils/functions.dart';

class VideoWidget extends StatefulWidget {
  Settings? settings;

  VideoWidget({required this.settings, Key? key}) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {

  late VideoPlayerController _controller;
  late YoutubePlayerController _youtubeController;
  @override
  void initState() {
    if (widget.settings?.video?.contains('youtube.com') != true) {
      _controller = VideoPlayerController.network(widget.settings?.video ?? '')
        ..initialize().then((value) {
          if (widget.settings?.autoplay == true) _controller.play();
          _controller.setLooping(false);
          setState(() {

          });
        });

    } else if (widget.settings?.video?.contains('youtube.com') == true) {
      _youtubeController = YoutubePlayerController(
        initialVideoId:
        y.YoutubePlayer.convertUrlToId(widget.settings?.video ?? '') ?? '',
        params: YoutubePlayerParams(
          startAt: const Duration(seconds: 10),
          showControls: widget.settings?.controls == true,
          showFullscreenButton: true,
        ),
      );
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.settings?.title != null)
            CustomText(
              widget.settings?.title,
              fontSize: 17,
              color: primaryColor,
              fontWeight: FontWeight.w900,
            ),
          const SizedBox(height: 15,),
          AspectRatio(
            aspectRatio: widget.settings?.video?.contains('youtube.com') != true
                ? _controller.value.aspectRatio
                : 16 / 9,
            child: widget.settings?.video?.contains('youtube.com') == true
                ? YoutubePlayerIFrame(
                    controller: _youtubeController, gestureRecognizers: null,
                    //  showVideoProgressIndicator: true,
                  )
                : VideoPlayer(_controller),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
