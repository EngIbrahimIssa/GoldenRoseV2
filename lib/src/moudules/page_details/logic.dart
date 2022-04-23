import 'dart:developer';

import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/entities/page_model.dart';
import 'package:entaj/src/utils/error_handler/error_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PageDetailsLogic extends GetxController {

  final ApiRequests _apiRequests = Get.find();
  bool isLoading = false;
  PageModel? pageModel;

  Future<void> getPageDetails(int? pageId) async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.getPagesDetails(pageId: pageId);
      log(response.data.toString());
      pageModel = PageModel.fromJson(response.data['payload']);

    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

  Future<void> getPrivacyPolicy() async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.getPrivacyPolicy();
      if(response.data.toString().contains('This store doesn')){
     //   Fluttertoast.showToast(msg: response.data['payload'].toString());
        isLoading = false;
        update();
        return;
      }
      pageModel = PageModel.fromJson(response.data['payload']);

    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

  Future<void> getRefundPolicy() async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.getRefundPolicy();
      if(response.data.toString().contains('This store doesn')){
     //   Fluttertoast.showToast(msg: response.data['payload'].toString());
        isLoading = false;
        update();
        return;
      }
      pageModel = PageModel.fromJson(response.data['payload']);
      //log(pageModel?.content ?? '');
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

  Future<void> getTermsAndConditions() async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.getTermsAndConditions();
      if(response.data.toString().contains('This store doesn')){
        Fluttertoast.showToast(msg: response.data['payload'].toString());
        isLoading = false;
        update();
        return;
      }
      pageModel = PageModel.fromJson(response.data['payload']);
      //log(pageModel?.content ?? '');
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

}
