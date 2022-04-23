import 'package:entaj/src/entities/home_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../colors.dart';
import '../../../images.dart';
import '../../../utils/custom_widget/custom_text.dart';
import '../../../utils/item_widget/item_product.dart';

class FeaturedProductsWidget extends StatelessWidget {
  final FeaturedProducts? featuredProducts;

  const FeaturedProductsWidget({Key? key, required this.featuredProducts})
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
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        CustomText(
                          featuredProducts?.title ?? '',
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                        if (featuredProducts?.moreButton != null)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed('/category-details/arguments',
                                    arguments: {
                                      'name': featuredProducts?.title ?? '',
                                      'filter':
                                          featuredProducts?.moreButton?.url,
                                    });
                              },
                              child: Row(
                                children: [
                                  const Spacer(),
                                  CustomText("عرض الكل".tr),
                                  const SizedBox(
                                    width: 10,
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
