import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import '../../../app_config.dart';
import '../../../colors.dart';
import '../../../entities/home_screen_model.dart';
import '../../../utils/custom_widget/custom_image.dart';
import '../../../utils/custom_widget/custom_indicator.dart';
import '../../../utils/functions.dart';
import '../logic.dart';
import '../tabs/home/logic.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart' as y;
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class SliderWidget extends StatefulWidget {
  List<Items> sliderItems;
  final bool hideDots;

  SliderWidget(
      {required this.sliderItems, required this.hideDots, Key? key})
      : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  void initState() {
    super.initState();
    startLoop();
  }

  int currentPage = 0;

  bool loopStarted = false;

  final PageController pageController = PageController(initialPage: 0);

  onPageChanged(page) {
    currentPage = page;
    setState(() {});
  }

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.sliderItems.length; i++) {
      list.add(i == currentPage
          ? const CustomIndicator(true)
          : const CustomIndicator(false));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLogic>(
        //  id: "slider",
        init: Get.find<MainLogic>(),
        builder: (logic) {
          log(logic.isHomeLoading.toString());
          return logic.isHomeLoading
              ? Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 180.h,
                  ))
              : GetBuilder<HomeLogic>(
                  init: Get.find<HomeLogic>(),
                  builder: (homeLogic) {
                    if(!AppConfig.isSoreUseOldTheme) widget.sliderItems = logic.slider?.items ?? [];
                    return !homeLogic.sliderDisplay
                        ? const SizedBox()
                        : Column(
                            children: [
                              SizedBox(
                                height:
                                    AppConfig.isSoreUseOldTheme ? 180.h : 180.h,
                                child: PageView.builder(
                                  onPageChanged: onPageChanged,
                                  itemCount: widget.sliderItems.length,
                                  itemBuilder: (context, index) {
                                    var sliderItem = widget.sliderItems[index];
                                    late VideoPlayerController _controller;
                                    late YoutubePlayerController
                                        _youtubeController;
                                    if (sliderItem.type == 'video' &&
                                        sliderItem.link
                                                ?.contains('youtube.com') ==
                                            false) {
                                      _controller = VideoPlayerController
                                          .network(sliderItem.link ?? '')
                                        ..initialize().then((value) => null);
                                      _controller.play();
                                    } else if (sliderItem.type == 'video' &&
                                        sliderItem.link
                                                ?.contains('youtube.com') ==
                                            true) {
                                      _youtubeController =
                                          YoutubePlayerController(
                                        initialVideoId:
                                            y.YoutubePlayer.convertUrlToId(
                                                    sliderItem.link ?? '') ??
                                                '',
                                        params: const YoutubePlayerParams(
                                          startAt: Duration(seconds: 10),
                                          showControls: true,
                                          showFullscreenButton: true,
                                        ),
                                      );
                                    }
                                    return GestureDetector(
                                      onTap: () =>
                                          goToLink(sliderItem.link ?? ''),
                                      child: sliderItem.type != 'video'
                                          ? CustomImage(
                                              url: sliderItem.image ?? '',
                                              width: double.infinity,
                                              size: 80,
                                              fit: BoxFit.cover,
                                            )
                                          : sliderItem.link?.contains(
                                                      'youtube.com') ==
                                                  true
                                              ? YoutubePlayerIFrame(
                                                  controller:
                                                      _youtubeController,
                                                  gestureRecognizers: null
                                                  //  showVideoProgressIndicator: true,
                                                  )
                                              : VideoPlayer(_controller),
                                    );
                                  },
                                  controller: pageController,
                                  physics: const ClampingScrollPhysics(),
                                ),
                              ),
                              if (!widget.hideDots)
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: buildPageIndicator(),
                                  ),
                                )
                            ],
                          );
                  });
        });
  }

  void startLoop() async {
    if (loopStarted) return;
    loopStarted = true;
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPage < widget.sliderItems.length) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      try {
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } catch (e) {}
    });
  }
}
