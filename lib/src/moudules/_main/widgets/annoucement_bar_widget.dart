import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app_config.dart';
import '../../../colors.dart';
import '../../../utils/custom_widget/custom_text.dart';
import '../../../utils/functions.dart';
import '../logic.dart';
import '../tabs/home/logic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnnouncementBarWidget extends StatelessWidget {
  const AnnouncementBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLogic>(
        init: Get.find<MainLogic>(),
        builder: (mainLogic) {
          return (AppConfig.isSoreUseNewTheme
                  ? mainLogic.isHomeLoading
                  : mainLogic.isStoreSettingLoading)
              ? Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    color: Colors.white,
                    height: 100,
                    width: double.infinity,
                  ))
              : Builder(builder: (context) {
                  return GetBuilder<HomeLogic>(
                      init: Get.find<HomeLogic>(),
                      id: 'announcementBar',
                      builder: (logic) {
                        logic.getAnnouncementBar();
                        return (!logic.announcementBarDisplay ||
                                logic.announcementBarText == null ||
                                logic.announcementBarText == '')
                            ? const SizedBox()
                            : Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: HexColor.fromHex(
                                      logic.announcementBarBackgroundColor ??
                                          yalowColor.toHex()),
                                ),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: GestureDetector(
                                      onTap: () =>
                                          goToLink(logic.announcementBarLink),
                                      child: CustomText(
                                        logic.announcementBarText
                                            ?.replaceAll('\n', ' '),
                                        fontWeight: FontWeight.bold,
                                        color: HexColor.fromHex(logic
                                                .announcementBarForegroundColor ??
                                            Colors.black.toHex()),
                                        fontSize: 11,
                                      ),
                                    )),
                                    GestureDetector(
                                      onTap: () => logic.hideAnnouncementBar(),
                                      child: Icon(
                                        Icons.close,
                                        size: 20.sp,
                                        color: HexColor.fromHex(logic
                                                .announcementBarForegroundColor ??
                                            Colors.black.toHex()),
                                      ),
                                    )
                                  ],
                                ),
                              );
                      });
                });
        });
  }
}
