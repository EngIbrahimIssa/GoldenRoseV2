import 'dart:developer';

import 'package:entaj/src/moudules/_main/widgets/features_widget.dart';
import 'package:entaj/src/moudules/_main/widgets/video_widget.dart';

import '../../widgets/partners_widget.dart';

import '../../../../app_config.dart';
import '../../../../entities/module_model.dart';
import '../../logic.dart';
import '../../widgets/annoucement_bar_widget.dart';
import '../../widgets/categories_grid_widget.dart';
import '../../widgets/slider_widget.dart';
import '../../widgets/testimonials_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../entities/home_screen_model.dart';
import '../../widgets/categories_widget.dart';
import '../../widgets/featured_products_wigget.dart';
import '../../widgets/gallery_widget.dart';

class HomeLogic extends GetxController {
  late MainLogic _mainLogic;
  List<ModuleModel> moduleList = [];
  Map<String?, int?> displayOrderMap = {};

  @override
  void onInit() {
    _mainLogic = Get.find<MainLogic>();
    super.onInit();
  }

  List<Widget> getDisplayOrderModule() {
    moduleList = [];
    List<Widget> widgets = [];
    _mainLogic.homeScreenOldThemeModel?.payload?.files?.forEach((file) {
      file.modules?.forEach((module) {
        if (module.settings?.order == null) {
          return;
        }
        moduleList.add(module);
      });
    });

    moduleList.sort((a, b) => a.settings!.order!.compareTo(b.settings!.order!));
    widgets.add(const AnnouncementBarWidget());
    widgets.add(const CategoriesWidget());
    bool hasSlider = false;
    for (var element in moduleList) {
      if (element.settings?.slider?.isNotEmpty == true) {
        if (element.fileName == 'main-slider.twig') {
          if (!hasSlider) {
            if (AppConfig.showOneSlider) {
              hasSlider = true;
            }
            widgets.add(SliderWidget(
                sliderItems: element.settings?.slider ?? [],
                textColor: element.settings?.textColor,
                hideDots: element.settings?.slider?.length == 1
                    ? true
                    : element.settings?.hideDots ?? true));
          }
        }
      } else if (element.fileName == 'ggallery.twig') {
        if (element.settings?.gallery != null) {
          widgets.add(GalleryWidget(
            galleryItems: element.settings?.gallery ?? [],
            title: element.settings?.title,
          ));
        }
      } else if (element.fileName == 'features-section.twig') {
        if (element.settings?.storeFeatures != null) {
          widgets.add(FeaturesWidget(
              storeFeatures: element.settings?.storeFeatures ?? []));
        }
      } else if (element.fileName == 'category-products-section.twig') {
        widgets.add(FeaturedProductsWidget(
          featuredProducts: element.settings?.category,
          moreText: element.settings?.displayMore == true
              ? element.settings?.moreText
              : null,
        ));
      } else if (element.fileName == 'testimonials.twig') {
        widgets.add(TestimonialWidget(
          title: element.settings?.title,
          display: true,
          items: element.settings?.testimonials ?? [],
        ));
      } else if (element.fileName == 'partners.twig') {
        widgets.add(PartnersWidget(
            title: element.settings?.title,
            gallery: element.settings?.storePartners));
      } else if (element.fileName == 'video.twig') {
        if (element.settings?.video != null) {
          widgets.add(VideoWidget(
            settings: element.settings,
          ));
        }
      } else if (element.fileName == 'category-section.twig') {
        widgets.add(CategoriesGridWidget(
          title: element.settings?.title,
          categories: element.settings?.categories,
          moreText: element.settings?.displayMore == true
              ? element.settings?.moreText
              : null,
        ));
      } else if (element.fileName == 'products-section.twig') {
        widgets.add(FeaturedProductsWidget(
          featuredProducts: element.settings?.products,
          title: element.settings?.title,
          moreText: element.settings?.displayMore == true
              ? element.settings?.moreText
              : null,
        ));
      }
    }
    widgets.add(const SizedBox(
      height: 15,
    ));
    return widgets;
  }

  ///AnnouncementBar
  bool announcementBarDisplay = true;
  String? announcementBarText;
  String? announcementBarLink;
  String? announcementBarForegroundColor;
  String? announcementBarBackgroundColor;

  void hideAnnouncementBar() {
    _mainLogic.showAnnouncementBar = false;
    update(['announcementBar']);
  }

  getAnnouncementBar() {
    getDisplayOrderModule();
    if (AppConfig.isSoreUseNewTheme) {
      _mainLogic.homeScreenOldThemeModel?.payload?.files?.forEach((element) {
        if (element.name == 'header.twig') {
          if (element.modules != null) {
            if (element.modules!.isNotEmpty) {
              var item = element.modules!.first;
              announcementBarText = item.settings?.announcementBarText;
              announcementBarLink = item.settings?.announcementBarUrl;
              announcementBarDisplay = announcementBarText != null &&
                  announcementBarText != '' &&
                  item.settings?.announcementBarDisplay == true &&
                  _mainLogic.showAnnouncementBar;
              announcementBarForegroundColor =
                  item.settings?.colorsFooterBackgroundColor;
              announcementBarBackgroundColor =
                  item.settings?.announcementBarBackgroundColor;
            }
          }
        }
      });
    } else {
      announcementBarText =
          _mainLogic.settingModel?.header?.announcementBar?.text;
      announcementBarDisplay = announcementBarText != null &&
          announcementBarText != '' &&
          _mainLogic.settingModel?.header?.announcementBar?.enabled == true &&
          _mainLogic.showAnnouncementBar;
      announcementBarForegroundColor = _mainLogic
          .settingModel?.header?.announcementBar?.style?.foregroundColor;
      announcementBarBackgroundColor = _mainLogic
          .settingModel?.header?.announcementBar?.style?.backgroundColor;
    }
  }

  ///Slider
  int sliderOrderDisplay = 0;
  bool sliderDisplay = true;
  List<Items> sliderItems = [];

  getSlider() {
    if (AppConfig.isSoreUseNewTheme) {
      _mainLogic.homeScreenOldThemeModel?.payload?.files?.forEach((element) {
        if (element.name == 'main-slider.twig') {
          if (element.modules != null) {
            if (element.modules!.isNotEmpty) {
              var item = element.modules!.first;
              sliderItems = item.settings?.slider ?? [];
              sliderDisplay = sliderItems.isNotEmpty;
              sliderOrderDisplay = item.settings?.order ?? 0;
            }
          }
        }
      });
    } else {
      sliderItems = _mainLogic.slider?.items ?? [];
      sliderDisplay =
          _mainLogic.slider?.display == true && sliderItems.isNotEmpty;
    }
  }

  ///Gallery
  List<Gallery> galleryItems = [];

  getGallery() {
    if (AppConfig.isSoreUseNewTheme) {
      galleryItems = [];
      _mainLogic.homeScreenOldThemeModel?.payload?.files?.forEach((element) {
        if (element.name == 'ggallery.twig') {
          if (element.modules != null) {
            if (element.modules!.isNotEmpty) {
              element.modules?.forEach((element) {
                galleryItems.addAll(element.settings?.gallery ?? []);
              });
            }
          }
        }
      });
    }
  }
}
