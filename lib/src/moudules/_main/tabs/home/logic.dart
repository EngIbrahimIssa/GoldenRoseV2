import 'dart:async';
import 'dart:developer';

import 'package:entaj/src/app_config.dart';
import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/entities/category_model.dart';
import 'package:entaj/src/entities/module_model.dart';
import 'package:entaj/src/moudules/_main/logic.dart';
import 'package:entaj/src/moudules/_main/widgets/annoucement_bar_widget.dart';
import 'package:entaj/src/moudules/_main/widgets/slider_widget.dart';
import 'package:entaj/src/moudules/_main/widgets/testimonials_widget.dart';
import 'package:entaj/src/utils/custom_widget/custom_indicator.dart';
import 'package:entaj/src/utils/error_handler/error_handler.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as ui;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
    for (var element in moduleList) {
      if (element.settings?.slider?.isNotEmpty == true) {
        if (element.fileName == 'main-slider.twig') {
          widgets.add(SliderWidget(
              sliderItems: element.settings?.slider ?? [],
              hideDots: element.settings?.slider?.length == 1
                  ? true
                  : element.settings?.hideDots ?? true));
        }
      } else if (element.fileName == 'ggallery.twig') {
        if (element.settings?.gallery != null) {
          widgets.add(
              GalleryWidget(galleryItems: element.settings?.gallery ?? []));
        }
      } else if (element.fileName == 'category-products-section.twig') {
        widgets.add(FeaturedProductsWidget(
            featuredProducts: element.settings?.category));
      } else if (element.fileName == 'testimonials.twig') {
        widgets.add(TestimonialWidget(
          title: element.settings?.title,
          display: element.settings?.hideDots == true,
          items: element.settings?.testimonials ?? [],
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
  String? announcementBarForegroundColor;
  String? announcementBarBackgroundColor;

  void hideAnnouncementBar() {
    _mainLogic.showAnnouncementBar = false;
    update(['announcementBar']);
  }

  getAnnouncementBar() {
    getDisplayOrderModule();
    if (AppConfig.isSoreUseOldTheme) {
      _mainLogic.homeScreenOldThemeModel?.payload?.files?.forEach((element) {
        if (element.name == 'header.twig') {
          if (element.modules != null) {
            if (element.modules!.isNotEmpty) {
              var item = element.modules!.first;
              announcementBarText = item.settings?.announcementBarText;
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
    if (AppConfig.isSoreUseOldTheme) {
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
    if (AppConfig.isSoreUseOldTheme) {
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
