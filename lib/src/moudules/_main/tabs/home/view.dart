import 'dart:math';

import 'package:entaj/main.dart';
import 'package:entaj/src/app_config.dart';
import 'package:entaj/src/colors.dart';
import 'package:entaj/src/entities/home_screen_model.dart';
import 'package:entaj/src/images.dart';
import 'package:entaj/src/moudules/_main/widgets/annoucement_bar_widget.dart';
import 'package:entaj/src/moudules/_main/widgets/brand_widget.dart';
import 'package:entaj/src/moudules/_main/widgets/categories_widget.dart';
import 'package:entaj/src/moudules/_main/widgets/slider_widget.dart';
import 'package:entaj/src/moudules/category_details/view.dart';
import 'package:entaj/src/moudules/_main/logic.dart';
import 'package:entaj/src/moudules/no_Internet_connection_screen.dart';
import 'package:entaj/src/services/app_events.dart';
import 'package:entaj/src/utils/custom_widget/custom_image.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:entaj/src/utils/item_widget/item_home_category.dart';
import 'package:entaj/src/utils/item_widget/item_product.dart';
import 'package:entaj/src/utils/item_widget/item_testimonial.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/functions.dart';
import '../../../../utils/item_widget/item_category.dart';
import 'logic.dart';

class HomePage extends StatelessWidget {
  final AppEvents _appEvents = Get.find();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _appEvents.logScreenOpenEvent('HomeTab');
    return GetBuilder<MainLogic>(
        init: Get.find<MainLogic>(),
        builder: (logic) {
          return RefreshIndicator(
            onRefresh: () => logic.refreshData(),
            child: SizedBox(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: !logic.hasInternet ? const NoInternetConnectionScreen() : (AppConfig.isSoreUseOldTheme)
                    ? GetBuilder<HomeLogic>(
                        init: Get.find<HomeLogic>(),
                        builder: (logic) {
                          return Column(
                            children: logic.getDisplayOrderModule(),
                          );
                        })
                    : Column(
                        children: [
                          const AnnouncementBarWidget(),
                          const CategoriesWidget(),
                          GetBuilder<HomeLogic>(
                              init: Get.find<HomeLogic>(),
                              builder: (logic) {
                                return SliderWidget(
                                  sliderItems: logic.sliderItems,
                                  hideDots: false,
                                );
                              }),
                          buildDescription(),
                          const SizedBox(
                            height: 15,
                          ),
                          GetBuilder<MainLogic>(builder: (logic) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildFeaturedProducts(logic
                                    .homeScreenModel?.featuredProductsPromoted),
                                buildFeaturedProducts(
                                    logic.homeScreenModel?.onSaleProducts),
                                buildFeaturedProducts(
                                    logic.homeScreenModel?.featuredProducts),
                                buildFeaturedProducts(
                                    logic.homeScreenModel?.featuredProducts2),
                                buildFeaturedProducts(
                                    logic.homeScreenModel?.featuredProducts3),
                                buildFeaturedProducts(
                                    logic.homeScreenModel?.featuredProducts4),
                                buildFeaturedProducts(
                                    logic.homeScreenModel?.recentProducts),
                              ],
                            );
                          }),
                          BrandWidget(brands: logic.homeScreenModel?.brands),
                          const SizedBox(
                            height: 10,
                          ),
                          buildTestimonials(),
                          const SizedBox(
                            height: 15,
                          )
                        ],
                      ),
              ),
            ),
          );
        });
  }

  GetBuilder<MainLogic> buildDescription() {
    return GetBuilder<MainLogic>(builder: (logic) {
      return logic.isHomeLoading
          ? Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20.sp)),
                width: double.infinity,
                child: SizedBox(
                  height: 100.h,
                ),
              ))
          : logic.homeScreenModel?.storeDescription == null ||
                  logic.homeScreenModel?.storeDescription?.display == false ||
                  (logic.homeScreenModel?.storeDescription?.title == null &&
                      logic.homeScreenModel?.storeDescription?.text == null)
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20.sp)),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        logic.homeScreenModel?.storeDescription?.title,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        logic.homeScreenModel?.storeDescription?.text,
                        fontSize: 10,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (logic.homeScreenModel?.storeDescription
                              ?.showSocialMediaIcons ==
                          true)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (logic.homeScreenModel?.storeDescription
                                    ?.socialMediaIcons?.twitter !=
                                null)
                              InkWell(
                                onTap: () => logic.goToTwitter(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    iconTwitter,
                                    color: primaryColor,
                                    scale: 2,
                                  ),
                                ),
                              ),
                            if (logic.homeScreenModel?.storeDescription
                                    ?.socialMediaIcons?.snapchat !=
                                null)
                              InkWell(
                                onTap: () => logic.goToLinkedin(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    iconSnapchat,
                                    color: primaryColor,
                                    scale: 2,
                                  ),
                                ),
                              ),
                            if (logic.homeScreenModel?.storeDescription
                                    ?.socialMediaIcons?.instagram !=
                                null)
                              InkWell(
                                onTap: () => logic.goToInstagram(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    iconInstagram,
                                    color: primaryColor,
                                    scale: 2,
                                  ),
                                ),
                              ),
                            if (logic.homeScreenModel?.storeDescription
                                    ?.socialMediaIcons?.facebook !=
                                null)
                              InkWell(
                                onTap: () => logic.goToFacebook(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    iconFacebook,
                                    color: primaryColor,
                                    scale: 2,
                                  ),
                                ),
                              ),
                          ],
                        )
                    ],
                  ),
                );
    });
  }

  Widget buildFeaturedProducts(FeaturedProducts? featuredProducts) {
    return (featuredProducts?.items == null ||
            featuredProducts?.items?.length == 0 ||
            featuredProducts?.display == false)
        ? const SizedBox()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
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
                      height: 10,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 300.h,
                    child: ListView.builder(
                        itemCount: featuredProducts?.items?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => ItemProduct(
                            featuredProducts!.items![index], index,
                            horizontal: true)),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          );
  }

  GetBuilder<MainLogic> buildTestimonials() {
    return GetBuilder<MainLogic>(
        init: Get.find<MainLogic>(),
        builder: (logic) {
          return logic.isHomeLoading
              ? Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomText(
                          logic.testimonials?.title ?? '',
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 150.h,
                        child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                const ItemTestimonial()),
                      ),
                    ],
                  ))
              : logic.testimonials?.display == false ||
                      logic.testimonials?.items?.length == 0
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CustomText(
                            logic.testimonials?.title ?? '',
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 170.h,
                          child: ListView.builder(
                              itemCount: logic.testimonials?.items?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => ItemTestimonial(
                                    item: logic.testimonials?.items?[index],
                                  )),
                        ),
                      ],
                    );
        });
  }
}
