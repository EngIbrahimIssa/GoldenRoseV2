import 'dart:developer';

import 'package:entaj/src/app_config.dart';
import 'package:entaj/src/entities/category_model.dart';

import 'home_screen_model.dart';

class ModuleModel {
  ModuleModel.fromJson(dynamic json, filename) {
    id = json['id'];
    storefrontThemeStoreId = json['storefront_theme_store_id'];
    storefrontThemeFileId = json['storefront_theme_file_id'];
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    isDraft = json['is_draft'];
    draftFor = json['draft_for'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fileName = filename;
  }

  String? id;
  String? storefrontThemeStoreId;
  String? storefrontThemeFileId;
  Settings? settings;
  int? isDraft;
  dynamic draftFor;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? fileName;
}

class Settings {
  List<Links1Links>? links1Links;
  List<Links2Links>? links2Links;
  bool? links1Hide;
  bool? links2Hide;
  List<Items>? slider;
  bool? displayMore;
  bool? hideDots;
  bool? announcementBarDisplay;
  String? announcementBarText;
  String? announcementBarPageDisplay;
  String? announcementBarBackgroundColor;
  String? announcementBarTextColor;
  String? headerLogo;
  List<dynamic>? headerOptions;
  String? colorsHeaderBackgroundColor;
  String? colorsHeaderTextColor;
  String? colorsFooterBackgroundColor;
  String? colorsFooterTextColor;
  String? fontsName;
  String? title;
  List<Gallery>? gallery;
  int? order;
  FeaturedProducts? category;
  List<Items>? testimonials;

  Settings.fromJson(dynamic json) {
    if (json['links_1_links'] != null) {
      links1Links = [];
      json['links_1_links'].forEach((v) {
        links1Links?.add(Links1Links.fromJson(v));
      });
    }
    if (json['links_2_links'] != null) {
      links2Links = [];
      json['links_2_links'].forEach((v) {
        links2Links?.add(Links2Links.fromJson(v));
      });
    }
    links1Hide = json['links_1_hide'];
    links2Hide = json['links_2_hide'];
    if (json['slider'] != null) {
      slider = [];
      json['slider'].forEach((v) {
        slider?.add(Items.fromJson(v));
      });
    }
    hideDots = json['hide_dots'];
    announcementBarDisplay = json['announcement_bar_display'];
    announcementBarText = json['announcement_bar_text'];
    announcementBarPageDisplay = json['announcement_bar_page_display'];
    announcementBarBackgroundColor = json['announcement_bar_background_color'];
    announcementBarTextColor = json['announcement_bar_text_color'];
    headerLogo = json['header_logo'];
    if (json['header_options'] != null) {
      headerOptions = [];
      json['header_options'].forEach((v) {
        headerOptions?.add((v));
      });
    }
    colorsHeaderBackgroundColor = json['colors_header_background_color'];
    colorsHeaderTextColor = json['colors_header_text_color'];
    colorsFooterBackgroundColor = json[AppConfig.isSoreUseOldTheme ? 'announcement_bar_text_color':'colors_footer_background_color'];
    colorsFooterTextColor = json['colors_footer_text_color'];
    fontsName = json['fonts_name'];
    if (json['gallery'] != null) {
      gallery = [];
      json['gallery'].forEach((v) {
        gallery?.add(Gallery.fromJson(v));
      });
    }
    order = json['order'];
    displayMore = json['display_more'];
    title = json['title'];
    category = json['category'] == null
        ? null
        : FeaturedProducts.fromJson(json['category']);
    if (json['testimonials'] != null) {
      testimonials = [];
      json['testimonials'].forEach((v) {
        testimonials?.add(Items.fromJson(v));
      });
    }
  }
}

class Gallery {
  Gallery.fromJson(dynamic json) {
    image = json['image'];
    url = json['url'];
  }

  String? image;
  String? url;
}

class Slider {
  Slider.fromJson(dynamic json) {
    image = json['image'];
  }

  String? image;
}

class Links2Links {
  Links2Links.fromJson(dynamic json) {
    title = json['title'];
    url = json['url'];
  }

  String? title;
  String? url;
}

class Links1Links {
  Links1Links.fromJson(dynamic json) {
    url = json['url'];
  }

  String? url;
}
