import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:entaj/src/app_config.dart';
import 'package:entaj/src/binding.dart';
import 'package:entaj/src/data/hive/wishlist/hive_controller.dart';
import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/entities/home_screen_old_theme_model.dart';
import 'package:entaj/src/entities/category_model.dart';
import 'package:entaj/src/entities/home_screen_model.dart';
import 'package:entaj/src/entities/setting_model.dart';
import 'package:entaj/src/moudules/delivery_option/view.dart';
import 'package:entaj/src/moudules/_main/view.dart';
import 'package:entaj/src/moudules/notification/view.dart';
import 'package:entaj/src/moudules/search/view.dart';
import 'package:entaj/src/utils/custom_widget/custom_indicator.dart';
import 'package:entaj/src/utils/error_handler/error_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart' as ui;
import '../../entities/OfferResponseModel.dart';
import '../../entities/page_model.dart';
import '../../utils/functions.dart';
import 'tabs/account/view.dart';
import 'tabs/cart/view.dart';
import 'tabs/categories/view.dart';
import 'tabs/home/view.dart';
import 'tabs/orders/view.dart';

class MainLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();

  @override
  void onInit() async {
    log("INIT ==> MainLogic");
    super.onInit();
  }

  List<PageModel> pagesList = [];
  ui.Widget _currentScreen = HomePage();
  List<CategoryModel> categoriesList = [];

  HomeScreenModel? homeScreenModel;
  HomeScreenOldThemeModel? homeScreenOldThemeModel;
  Slider? slider;
  Testimonials? testimonials;
  SettingModel? settingModel;
  int _navigatorValue = 0;
  bool hasInternet = true;
  bool showAppBar = true;
  bool isPagesLoading = false;
  bool isCategoriesLoading = false;
  bool isHomeLoading = false;
  bool isStoreSettingLoading = false;
  bool showAnnouncementBar = true;
  int? selectedCountry;

  get navigatorValue => _navigatorValue;

  get currentScreen => _currentScreen;

  Future<bool> checkInternetConnection() async {
    var connection =
        (await Connectivity().checkConnectivity() != ConnectivityResult.none);
    hasInternet = connection;
    update();
    return connection;
  }

  void changeSelectedValue(int selectedValue, bool withUpdate,
      {required int backCount}) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        {
          _currentScreen = HomePage();
          showAppBar = true;

          for (var i = backCount; i >= 1; i--) {
            Get.back();
          }
          break;
        }
      case 1:
        {
          _currentScreen = CategoriesPage();
          showAppBar = true;

          for (var i = backCount; i >= 1; i--) {
            Get.back();
          }
          break;
        }
      case 2:
        {
          _currentScreen = CartPage();
          showAppBar = false;

          for (var i = backCount; i >= 1; i--) {
            Get.back();
          }
          break;
        }
      case 3:
        {
          showAppBar = false;
          _currentScreen = OrdersPage();

          for (var i = backCount; i >= 1; i--) {
            Get.back();
          }
          break;
        }
      case 4:
        {
          _currentScreen = AccountPage();
          showAppBar = false;
          for (var i = backCount; i >= 1; i--) {
            Get.back();
          }
          break;
        }
    }
    if (withUpdate) update();
  }

  goToTwitter() {
    launch(
        "https://www.twitter.com/${homeScreenModel?.storeDescription?.socialMediaIcons?.twitter}");
  }

  goToLinkedin() {
    launch(
        "https://www.snapchat.com/add/${homeScreenModel?.storeDescription?.socialMediaIcons?.snapchat}");
  }

  goToInstagram() {
    launch(
        "https://www.instagram.com/${homeScreenModel?.storeDescription?.socialMediaIcons?.instagram}");
  }

  goToFacebook() {
    launch(
        "https://www.facebook.com/${homeScreenModel?.storeDescription?.socialMediaIcons?.facebook}");
  }

  void goToSearch() {
    Get.to(SearchPage());
  }

  void goToNotification() {
    Get.to(NotificationPage());
  }

  void goToDeliveryOptions() {
    Get.to(DeliveryOptionPage());
  }

  Future<void> getPages(bool forceLoading) async {
    if (pagesList.isNotEmpty && !forceLoading) {
      return;
    }
    isPagesLoading = true;
    update(['pages']);
    try {
      var response = await _apiRequests.getPages();
      pagesList = (response.data['payload']['store_pages'] as List)
          .map((e) => PageModel.fromJson(e))
          .toList();
    } catch (e) {
      hasInternet = await ErrorHandler.handleError(e);
    }
    isPagesLoading = false;
    update(['pages']);
  }

  Future<void> getCategories() async {
    if (!await checkInternetConnection()) return;
    isCategoriesLoading = true;
    update(['categories', 'categories2', 'categoriesMenu']);
    try {
      var response = await _apiRequests.getCategories();
      categoriesList = (response.data['payload'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    } catch (e) {
      hasInternet = await ErrorHandler.handleError(e);
    }
    isCategoriesLoading = false;
    update(['categories', 'categories2', 'categoriesMenu']);
  }

  Future<void> getHomeScreen() async {
    isHomeLoading = true;
    update();
    try {
      if (AppConfig.isSoreUseOldTheme) {
        var response = await _apiRequests.getHomeScreenOldTheme();
        homeScreenOldThemeModel =
            HomeScreenOldThemeModel.fromJson(response.data);
        await getOffers();
      } else {
        var response = await _apiRequests.getHomeScreen();
        slider = Slider.fromJson(response.data['payload']['slider']);
        testimonials =
            Testimonials.fromJson(response.data['payload']['testimonials']);
        homeScreenModel = HomeScreenModel.fromJson(response.data['payload']);

        await getOffers();
        showAnnouncementBar = true;
      }
    } catch (e) {
      hasInternet = await ErrorHandler.handleError(e);
    }
    isHomeLoading = false;
    update();
  }

  Future<void> getStoreSetting() async {
    isStoreSettingLoading = true;
    update();
    try {
      var response = await _apiRequests.getStoreSetting();
      settingModel = SettingModel.fromJson(response.data['payload']);
      //   log(response.data.toString());
      showAnnouncementBar = true;
      int index = 0;
      settingModel?.settings?.currencies?.forEach((element) {
        if (element.code == HiveController.generalBox.get('currency')) {
          selectedCountry = index;
        }
        index++;
      });
    } catch (e) {
      hasInternet = await ErrorHandler.handleError(e);
    }
    isStoreSettingLoading = false;
    update();
  }

  goToMaroof() async {
    if (!await checkInternet()) return;
    log(settingModel?.footer?.socialMedia?.items?.maroof ?? '');
    launch(settingModel?.footer?.socialMedia?.items?.maroof ?? '');
  }

  Future<void> refreshData() async {
    if (!await checkInternet()) return;
    getStoreSetting();
    getPages(false);
    getCategories();
    getHomeScreen();
  }

  changeCountrySelected(int index) {
    selectedCountry = index;
    update(['countries']);
  }

  saveCountry() async {
    if (selectedCountry == null) return;
    try {
      var currency = settingModel?.settings?.currencies?[selectedCountry!];
      HiveController.generalBox.put('currency', currency?.code);
      await _apiRequests.onInit();
      getHomeScreen();
      getStoreSetting();
      getCategories();
      Get.back();
    } catch (e) {}
  }

  Future<void> getOffers() async {
    try {
      List<String> productsIds = [];

      homeScreenOldThemeModel?.payload?.files?.forEach((element) {
        if (element.name == 'category-products-section.twig') {
          element.modules?.forEach((element2) {
            element2.settings?.category?.items?.forEach((element3) {
              productsIds.add(element3.id!);
              log(element3.id.toString());
            });
          });
        }
      });
      homeScreenModel?.featuredProducts?.items?.forEach((element) {
        if (element.id != null) {
          productsIds.add(element.id!);
        }
      });
      homeScreenModel?.featuredProducts?.items?.forEach((element) {
        if (element.id != null) {
          productsIds.add(element.id!);
        }
      });

      homeScreenModel?.featuredProducts2?.items?.forEach((element) {
        if (element.id != null) {
          productsIds.add(element.id!);
        }
      });

      homeScreenModel?.featuredProducts3?.items?.forEach((element) {
        if (element.id != null) {
          productsIds.add(element.id!);
        }
      });
      homeScreenModel?.featuredProducts4?.items?.forEach((element) {
        if (element.id != null) {
          productsIds.add(element.id!);
        }
      });
      homeScreenModel?.onSaleProducts?.items?.forEach((element) {
        if (element.id != null) {
          productsIds.add(element.id!);
        }
      });

      homeScreenModel?.recentProducts?.items?.forEach((element) {
        if (element.id != null) {
          productsIds.add(element.id!);
        }
      });

      var res = await _apiRequests.getSimpleBundleOffer(productsIds);
      List<OfferResponseModel> offerList = (res.data['payload'] as List)
          .map((e) => OfferResponseModel.fromJson(e))
          .toList();

      homeScreenModel?.featuredProducts?.items?.forEach((elementProduct) {
        offerList.forEach((elementOffer) {
          if (elementOffer.productIds?.contains(elementProduct.id) == true) {
            elementProduct.offerLabel = elementOffer.name;
          }
        });
      });
      homeScreenModel?.featuredProducts2?.items?.forEach((elementProduct) {
        offerList.forEach((elementOffer) {
          if (elementOffer.productIds?.contains(elementProduct.id) == true) {
            elementProduct.offerLabel = elementOffer.name;
          }
        });
      });
      homeScreenModel?.featuredProducts3?.items?.forEach((elementProduct) {
        offerList.forEach((elementOffer) {
          if (elementOffer.productIds?.contains(elementProduct.id) == true) {
            elementProduct.offerLabel = elementOffer.name;
          }
        });
      });
      homeScreenModel?.featuredProducts4?.items?.forEach((elementProduct) {
        offerList.forEach((elementOffer) {
          if (elementOffer.productIds?.contains(elementProduct.id) == true) {
            elementProduct.offerLabel = elementOffer.name;
          }
        });
      });
      homeScreenModel?.onSaleProducts?.items?.forEach((elementProduct) {
        offerList.forEach((elementOffer) {
          if (elementOffer.productIds?.contains(elementProduct.id) == true) {
            elementProduct.offerLabel = elementOffer.name;
          }
        });
      });
      homeScreenModel?.recentProducts?.items?.forEach((elementProduct) {
        offerList.forEach((elementOffer) {
          if (elementOffer.productIds?.contains(elementProduct.id) == true) {
            elementProduct.offerLabel = elementOffer.name;
          }
        });
      });
      homeScreenModel?.recentProducts?.items?.forEach((elementProduct) {
        offerList.forEach((elementOffer) {
          if (elementOffer.productIds?.contains(elementProduct.id) == true) {
            elementProduct.offerLabel = elementOffer.name;
          }
        });
      });
      homeScreenOldThemeModel?.payload?.files?.forEach((element) {
        if (element.name == 'category-products-section.twig') {
          element.modules?.forEach((element2) {
            element2.settings?.category?.items?.forEach((element3) {

              offerList.forEach((elementOffer) {
                if (elementOffer.productIds?.contains(element3.id) == true) {
                  element3.offerLabel = elementOffer.name;
                }
              });
            });
          });
        }
      });

    } catch (e) {}
  }
}
