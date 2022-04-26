import 'dart:math';

import '../../../../../main.dart';
import '../../../../app_config.dart';
import '../../../../colors.dart';
import '../../../../entities/home_screen_model.dart';
import '../../../../images.dart';
import '../../widgets/annoucement_bar_widget.dart';
import '../../widgets/brand_widget.dart';
import '../../widgets/categories_grid_widget.dart';
import '../../widgets/categories_widget.dart';
import '../../widgets/slider_widget.dart';
import '../../logic.dart';
import '../../../no_Internet_connection_screen.dart';
import '../../../../services/app_events.dart';
import '../../../../utils/custom_widget/custom_text.dart';
import '../../../../utils/item_widget/item_product.dart';
import '../../../../utils/item_widget/item_testimonial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

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
                child: !logic.hasInternet
                    ? const NoInternetConnectionScreen()
                    : (AppConfig.isSoreUseNewTheme)
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
                              if (logic.homeScreenModel?.products != null)
                                GridView.builder(
                                  itemCount:
                                      logic.homeScreenModel?.products?.length ??
                                          0,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(bottom: 20),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: 0.65),
                                  itemBuilder: (context, index) => ItemProduct(
                                    logic.homeScreenModel?.products?[index],
                                    index,
                                    horizontal: false,
                                    forWishlist: false,
                                  ),
                                ),
                              if (logic.homeScreenModel?.products == null &&
                                  logic.slider != null)
                                GetBuilder<HomeLogic>(
                                    init: Get.find<HomeLogic>(),
                                    builder: (logic) {
                                      return logic.sliderItems.isEmpty
                                          ? SizedBox()
                                          : SliderWidget(
                                              sliderItems: logic.sliderItems,
                                              textColor: null,
                                              hideDots: false,
                                            );
                                    }),
                              if (logic.homeScreenModel?.products == null)
                                buildDescription(),
                              if (logic.homeScreenModel?.products == null)
                                const SizedBox(
                                  height: 15,
                                ),
                              if (logic.homeScreenModel?.products == null)
                                GetBuilder<MainLogic>(builder: (logic) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildFeaturedProducts(logic
                                          .homeScreenModel
                                          ?.featuredProductsPromoted),
                                      buildFeaturedProducts(logic
                                          .homeScreenModel?.onSaleProducts),
                                      buildFeaturedProducts(logic
                                          .homeScreenModel?.featuredProducts),
                                      buildFeaturedProducts(logic
                                          .homeScreenModel?.featuredProducts2),
                                      buildFeaturedProducts(logic
                                          .homeScreenModel?.featuredProducts3),
                                      buildFeaturedProducts(logic
                                          .homeScreenModel?.featuredProducts4),
                                      buildFeaturedProducts(logic
                                          .homeScreenModel?.recentProducts),
                                    ],
                                  );
                                }),
                              if (logic.homeScreenModel?.products == null)
                                CategoriesGridWidget(
                                  title: logic.homeScreenModel
                                      ?.featuredCategories?.title,
                                  moreText: null,
                                  categories: logic.homeScreenModel
                                          ?.featuredCategories?.items ??
                                      [],
                                ),
                              if (logic.homeScreenModel?.products == null)
                                BrandWidget(
                                    brands: logic.homeScreenModel?.brands),
                              if (logic.homeScreenModel?.products == null)
                                const SizedBox(
                                  height: 10,
                                ),
                              if (logic.homeScreenModel?.products == null)
                                buildTestimonials(),
                              if (logic.homeScreenModel?.products == null)
                                const SizedBox(
                                  height: 15,
                                ),
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
                      logic.homeScreenModel?.storeDescription?.text == null &&
                      logic.homeScreenModel?.storeDescription
                              ?.socialMediaIcons ==
                          null)
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  decoration: BoxDecoration(
                      color: HexColor.fromHex(logic.homeScreenModel
                              ?.storeDescription?.style?.backgroundColor ??
                          '#dddddd'),
                      borderRadius: BorderRadius.circular(20.sp)),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (logic.homeScreenModel?.storeDescription?.title !=
                          null)
                        CustomText(
                          logic.homeScreenModel?.storeDescription?.title,
                          fontWeight: FontWeight.bold,
                          color: HexColor.fromHex(logic.homeScreenModel
                                  ?.storeDescription?.style?.foregroundColor ??
                              '#000000'),
                          textAlign: TextAlign.center,
                        ),
                      if (logic.homeScreenModel?.storeDescription?.text != null)
                        CustomText(
                          logic.homeScreenModel?.storeDescription?.text,
                          textAlign: TextAlign.center,
                          color: HexColor.fromHex(logic.homeScreenModel
                                  ?.storeDescription?.style?.foregroundColor ??
                              '#000000'),
                          fontSize: 10,
                        ),
                      if (logic.homeScreenModel?.storeDescription
                              ?.showSocialMediaIcons ==
                          true)
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
                                    color: HexColor.fromHex(logic
                                            .homeScreenModel
                                            ?.storeDescription
                                            ?.style
                                            ?.foregroundColor ??
                                        '#000000'),
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
                                    color: HexColor.fromHex(logic
                                            .homeScreenModel
                                            ?.storeDescription
                                            ?.style
                                            ?.foregroundColor ??
                                        '#000000'),
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
                                    color: HexColor.fromHex(logic
                                            .homeScreenModel
                                            ?.storeDescription
                                            ?.style
                                            ?.foregroundColor ??
                                        '#000000'),
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
                                    color: HexColor.fromHex(logic
                                            .homeScreenModel
                                            ?.storeDescription
                                            ?.style
                                            ?.foregroundColor ??
                                        '#000000'),
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
                          color: primaryColor,
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
