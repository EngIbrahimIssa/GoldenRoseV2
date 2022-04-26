import 'dart:ui';

import '../../binding.dart';
import '../../data/remote/api_requests.dart';
import '../../data/shared_preferences/pref_manger.dart';
import '../_main/logic.dart';
import '../_main/view.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class SelectLanguageLogic extends GetxController {
  final PrefManger _prefManger = Get.find();
  final ApiRequests _apiRequests = Get.find();
  final MainLogic _mainLogic = Get.find();

  changeLanguage(bool mIsArabic) async {
    await _prefManger.setIsArabic(mIsArabic);
    isArabicLanguage = mIsArabic;
    Get.updateLocale(Locale(isArabicLanguage ? 'ar' : 'en'));
    await _apiRequests.onInit();
  //  _mainLogic.getHomeScreen();
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
