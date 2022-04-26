import 'dart:developer';

import 'package:get/get.dart';

import '../../data/remote/api_requests.dart';
import '../../entities/faq_model.dart';
import '../../utils/error_handler/error_handler.dart';


class FaqLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  bool isLoading = false;

  List<FaqModel> list = [];
  int? selectedIndex;

  @override
  void onInit() {
    super.onInit();
  }
  void getSettingsList() async {
    isLoading = true;
    update();

    try {
      var res = await _apiRequests.getFaqs();
        list = (res.data['payload'] as List)
            .map((e) => FaqModel.fromJson(e))
            .toList();
    } catch (e) {
      ErrorHandler.handleError(e);
    }

    isLoading = false;
    update();
  }

  openTap(int index) {
    if(selectedIndex == index){
      selectedIndex = null;
      update();
      return;
    }
    selectedIndex = index;
    update();
  }

}
