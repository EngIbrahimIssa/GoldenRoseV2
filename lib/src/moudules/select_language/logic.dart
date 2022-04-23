import 'dart:ui';

import 'package:entaj/src/binding.dart';
import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/data/shared_preferences/pref_manger.dart';
import 'package:entaj/src/moudules/_main/logic.dart';
import 'package:entaj/src/moudules/_main/view.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../.env.dart';

class SelectLanguageLogic extends GetxController {
  final PrefManger _prefManger = Get.find();
  final ApiRequests _apiRequests = Get.find();
  final MainLogic _mainLogic = Get.find();

  changeLanguage(bool mIsArabic) async {
    await _prefManger.setIsArabic(mIsArabic);
    isArabicLanguage = mIsArabic;
    Get.updateLocale(Locale(isArabicLanguage ? 'ar' : 'en'));
    await _apiRequests.onInit();
    _mainLogic.getHomeScreen();
    _mainLogic.getStoreSetting();
    _mainLogic.getCategories();
    _mainLogic.getPages(false);
    update();
  }

  goToMainPage() async {
   await _prefManger.setIsNotFirstTime(true);
    Get.off(const MainPage(), binding: Binding());
  }
}
