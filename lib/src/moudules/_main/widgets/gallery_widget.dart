import 'package:entaj/src/entities/home_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../colors.dart';
import '../../../entities/module_model.dart';
import '../../../utils/custom_widget/custom_image.dart';
import '../../../utils/functions.dart';
import '../../../utils/item_widget/item_category.dart';
import '../logic.dart';
import '../tabs/home/logic.dart';

class GalleryWidget extends StatelessWidget {
  final List<Gallery> galleryItems;
  const GalleryWidget({Key? key,required this.galleryItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLogic>(
        init: Get.find<MainLogic>(),
        builder: (mainLogic) {
          return mainLogic.isHomeLoading
              ? Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: GridView.builder(
                      itemCount: 20,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 1),
                      itemBuilder: (context, index) =>
                          const ItemCategory(null)),
                )
              : GetBuilder<HomeLogic>(
                  init: Get.find<HomeLogic>(),
                  builder: (logic) {
                    logic.getGallery();
                    return Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10 , top: 10),
                      child: GridView.builder(
                          itemCount: galleryItems.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: InkWell(
                                onTap: () => goToLink(
                                    galleryItems[index].url ?? ''),
                                child: CustomImage(
                                    url: galleryItems[index].image)),
                          )),
                    );
                  });
        });
  }
}
