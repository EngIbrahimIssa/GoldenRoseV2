import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/data/shared_preferences/pref_manger.dart';
import 'package:entaj/src/entities/user_model.dart';
import 'package:entaj/src/moudules/about_us/view.dart';
import 'package:entaj/src/moudules/delivery_option/view.dart';
import 'package:entaj/src/moudules/edit_account/view.dart';
import 'package:entaj/src/moudules/_main/logic.dart';
import 'package:entaj/src/moudules/page_details/view.dart';
import 'package:entaj/src/moudules/pages/view.dart';
import 'package:entaj/src/moudules/select_country/view.dart';
import 'package:entaj/src/utils/error_handler/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/functions.dart';
import '../../../_auth/login/view.dart';
import '../../../wishlist/view.dart';
import '/main.dart';
import '../../../../.env.dart';

class AccountLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final MainLogic _mainLogic = Get.find();
  final PrefManger _prefManger = Get.find();
  bool isLogin = false;
  bool isLoading = false;
  bool isPrivacyLoading = false;
  bool isRefundLoading = false;
  UserModel? userModel;

  Future<void> checkLoginState() async {
    isLogin = await _prefManger.getIsLogin();
    update();
    if (isLogin) await getAccountDetails();
  }

  void goToEditAccount() {
    Get.to(EditAccountPage());
  }

  void goToLogin() {
    Get.to(LoginPage())?.then((value) {
      checkLoginState();
    });
  }

  void goWishlistPage() {
 //   Get.to(LoginPage());
    Get.to(WishlistPage());
  }

  void goToAboutUsPage() async {
    if(!await checkInternet()) return;
    Get.to(AboutUsPage());
  }

  void goToPagesPage() {
    Get.to(PagesPage());
  }

  changeLanguage() async {
    var lang = await _prefManger.getIsArabic();
    await _prefManger.setIsArabic(!lang);
    isArabicLanguage = !lang;
    Get.updateLocale(Locale(isArabicLanguage ? 'ar' : 'en'));
    await _apiRequests.onInit();
    _mainLogic.getHomeScreen();
    _mainLogic.getStoreSetting();
    _mainLogic.getCategories();
    _mainLogic.getPages(false);
    update();
  }

  getAccountDetails() async {
    isLoading = true;
    update(['account']);
    try {
      var response = await _apiRequests.getAccountDetails();
      log(response.data.toString());
      userModel = UserModel.fromJson(response.data['payload']);
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update(['account']);
    update();
  }

  logout() {
    _prefManger.setIsLogin(false);
    _prefManger.setToken(null);
    isLogin = false;
    _apiRequests.onInit();
    userModel = null;
    update();
  }

  void goToWhatsApp() async {
    String whatsAppUrl = "";

    String phoneNumber =
        _mainLogic.settingModel?.footer?.socialMedia?.items?.phone ?? '';
    String description = "Hello, From App".tr;

    whatsAppUrl = 'https://wa.me/+$phoneNumber?text=${Uri.parse(description)}';

    if (await canLaunch(whatsAppUrl)) {
      await launch(whatsAppUrl);
    } else {
      Get.snackbar("Whats App Error".tr, "Install WhatsApp First Please".tr);
    }
  }

  goToTwitter() {
    log(_mainLogic.settingModel?.footer?.socialMedia?.items?.twitter ?? '');
    launch(
        "https://www.twitter.com/${_mainLogic.settingModel?.footer?.socialMedia?.items?.twitter}");
  }

  goToLinkedin() {
    log(_mainLogic.settingModel?.footer?.socialMedia?.items?.snapchat ?? '');
    launch(
        "https://www.snapchat.com/add/${_mainLogic.settingModel?.footer?.socialMedia?.items?.snapchat}");
  }

  goToInstagram() {
    log(_mainLogic.settingModel?.footer?.socialMedia?.items?.instagram ?? '');
    launch(
        "https://www.instagram.com/${_mainLogic.settingModel?.footer?.socialMedia?.items?.instagram}");
  }

  goToFacebook() {
    log(_mainLogic.settingModel?.footer?.socialMedia?.items?.facebook ?? '');
    launch(
        "https://www.facebook.com/${_mainLogic.settingModel?.footer?.socialMedia?.items?.facebook}");
  }

  goToPhone() {
      log(_mainLogic.settingModel?.footer?.socialMedia?.items?.phone ?? '');
      launch("tel:${_mainLogic.settingModel?.footer?.socialMedia?.items?.phone}");
    }

  goToEmail() {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: _mainLogic.settingModel?.footer?.socialMedia?.items?.email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'رسالة من تطبيق $appName'
      }),
    );

    log(_mainLogic.settingModel?.footer?.socialMedia?.items?.email ?? '');
    launch(emailLaunchUri.toString());
  }

  goToShippingMethod() async {
    Get.to(DeliveryOptionPage());
  }

  void goToAppBunchesSite() async {
    String urlString = appsBunchesUrl;
    if (await canLaunch(urlString)) launch(urlString);
  }

  goToPrivacyPolicy() async {
    if(!await checkInternet()) return;
    Get.to(PageDetailsPage(null, 1));
  }

  getRefundPolicy() async {
    if(!await checkInternet()) return;
    Get.to(PageDetailsPage(null, 2));
  }

  shareApp() {
    Share.share(shareLink);
  }

  goToTermsAndConditions()async {
    if(!await checkInternet()) return;
    Get.to(PageDetailsPage(null, 3));
  }

  goToCountries() {
    Get.to(SelectCountryPage());
  }

}
