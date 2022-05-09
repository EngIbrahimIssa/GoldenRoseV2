import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:entaj/src/app_config.dart';
import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/data/shared_preferences/pref_manger.dart';
import 'package:entaj/src/moudules/_main/logic.dart';
import 'package:entaj/src/moudules/_main/view.dart';
import 'package:entaj/src/moudules/select_language/view.dart';
import 'package:entaj/src/utils/error_handler/error_handler.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../binding.dart';
import '../moudules/unauthenticated/view.dart';

class SplashLogic extends GetxController {
  final PrefManger _prefManger = Get.find();
  final ApiRequests _apiRequests = Get.find();
  final MainLogic _mainLogic = Get.find();

  int seconds = 3;

  @override
  void onInit() async {
    await _apiRequests.onInit();
    seconds--;
    if (!await checkToken()) {
      log('Unauthenticated1');
      String accessToken = await _prefManger.getAccessToken();
      String authorizationToken = await _prefManger.getAuthorizationToken();

      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 1),
      ));
      await remoteConfig.ensureInitialized();
      try {
        await remoteConfig.fetchAndActivate();
      } catch (e) {
        log(e.toString());
      }
      seconds--;

      accessToken = remoteConfig.getString('ACCESS_TOKEN');
      await _prefManger.setAccessToken(accessToken);
      authorizationToken = remoteConfig.getString('AUTHORIZATION_TOKEN');
      await _prefManger.setAuthorizationToken(authorizationToken);
      await _prefManger.setIsFromRemote(true);

      if (!await checkToken()) {
        log('Unauthenticated2');
        Get.offAll(UnauthenticatedPage(), binding: Binding());
        super.onInit();
        return;
      }
    }
    await _mainLogic.getStoreSetting();
    _mainLogic.getPages(false);
    _mainLogic.getCategories();
    _mainLogic.getPrivacyPolicy();
    _mainLogic.getRefundPolicy();
    _mainLogic.getComplaintsAndSuggestions();
    _mainLogic.getTermsAndConditions();
    await getSession();
    seconds--;
    await Future.delayed(Duration(seconds: seconds < 0 ? 0 : seconds));
    if (AppConfig.isEnglishLanguageEnable) {
      bool isNotFirstTime = await _prefManger.getIsNotFirstTime();
      Get.off(isNotFirstTime ? const MainPage() : SelectLanguagePage(),
          binding: Binding());
    } else {
      Get.off(const MainPage(), binding: Binding());
    }

    super.onInit();
  }

  Future<void> getSession() async {
    if (await _prefManger.getSession() == '') {
      try {
        seconds--;
        var response = await _apiRequests.createSession();
        var session = response.data['payload']['cart_session_id'];
        log("new session => $session");
        await _prefManger.setSession(session);
        await _apiRequests.onInit();
      } catch (e) {
        ErrorHandler.handleError(e);
      }
    } else {
      log("old session => ${await _prefManger.getSession()}");
      log("old token => ${await _prefManger.getToken()}");
    }
  }

  Future<bool> checkToken() async {
    try {
      await _apiRequests.onInit();
      var response = await _apiRequests.getPages();
      return true;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data['message']['description'] == 'Unauthenticated') {
          return false;
        }else if (e.response?.data['message']['code'] == 'ERROR_SESSION_INVALID') {
          return false;
        }
      }
      return true;
    }
  }
}
