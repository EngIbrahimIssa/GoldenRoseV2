import '../../../app_config.dart';

import '../../../entities/home_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../colors.dart';
import '../../../images.dart';
import '../../../utils/custom_widget/custom_text.dart';
import '../../../utils/functions.dart';
import '../../../utils/item_widget/item_product.dart';

class FeaturedProductsWidget extends StatelessWidget {
  final FeaturedProducts? featuredProducts;
  final String? title;
  final String? moreText;

  const FeaturedProductsWidget(
      {Key? key, required this.featuredProducts, this.title, this.moreText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (featuredProducts?.items == null ||
            featuredProducts?.items?.length == 0)
        ? const SizedBox()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            featuredProducts?.title ?? title,
                            fontSize: 17,
                            color: primaryColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        if (featuredProducts?.moreButton != null ||
                            moreText != null)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (AppConfig.isSoreUseNewTheme) {
                                  if (featuredProducts?.url != null) {
                                    goToLink(featuredProducts?.url);
                                  } else {
                                    Get.toNamed(
                                        '/category-details/${featuredProducts?.id}');
                                  }
                                } else {
                                  Get.toNamed('/category-details/arguments',
                                      arguments: {
                                        'name': featuredProducts?.title ?? '',
                                        'filter':
                                            featuredProducts?.moreButton?.url,
                                      });
                                }
                              },
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Expanded(
                                      child: CustomText(
                                    moreText ?? "عرض الكل".tr,
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                          color: primaryColor
                                  )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  RotationTransition(
                                      turns: AlwaysStoppedAnimation(
                                          (isArabicLanguage ? 180 : 0) / 360),
                                      child: Image.asset(iconBack,
                                          color: primaryColor, scale: 2)),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 1.3,
                child: ListView.builder(
                    itemCount: featuredProducts?.items?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ItemProduct(
                        featuredProducts!.items![index], index,
                        horizontal: true)),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          );
  }
}
