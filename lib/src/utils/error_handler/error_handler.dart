import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/data/shared_preferences/pref_manger.dart';
import 'package:entaj/src/moudules/_main/tabs/cart/logic.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../../colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorHandler {
  static Future<bool> handleError(
    Object e, {
    bool? showToast,
  }) async {
    if (e is DioError) {
      if (e.response != null && showToast == null) {
        try {
          if (e.response!.data['message']['description']
                  .toString()
                  .contains('Error in cart session') ||
              e.response!.data['message']['description']
                  .toString()
                  .contains('خطأ في سلة الشراء')) {
            await generateSession(false);
          } else if (e.response!.data['message']['code'] ==
              'ERROR_CART_IS_RESERVED') {
            Get.snackbar(e.response!.data['message']['name'],
                e.response!.data['message']['description'],
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(20),
                duration: const Duration(seconds: 4),
                mainButton: TextButton(
                  child: CustomText(
                    'إلغاء السلة'.tr,
                    fontWeight: FontWeight.w900,
                  ),
                  onPressed: () {
                    Get.back();
                    generateSession(true);
                  },
                ));
            //refreshToken();
          } else if (e.response!.data['message']['description'] ==
              'Unauthenticated') {
            //refreshToken();
          } else {
            int errorLength =  e.response!.data['message']['description'].toString().length;
            Widget widget = Container(
              height: errorLength < 40 ? 40.0.h : errorLength < 80  ? 70 : 100,
              margin:  EdgeInsets.only(left: 50.w , right: 50.w , bottom: 60.h),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                      child: Center(
                          child: CustomText(
                           e.response!.data['message']['description'].toString(),
                            color: Colors.white,
                            textAlign: TextAlign.center,
                          ))),
                ],
              ),
            );
           showToastWidget(widget, position: ToastPosition.bottom);
           /*Fluttertoast.showToast(
                msg: e.response!.data['message']['description'].toString(),
                toastLength: Toast.LENGTH_LONG);*/
          }
        } catch (ee) {
          log("ErrorHandler catch ==>  "+ ee.toString());
          Fluttertoast.showToast(msg: e.response!.data.toString());
        }
        log("ErrorHandler DioError ==> " + e.response!.data.toString());
      } else {
        final ConnectivityResult result =
            await Connectivity().checkConnectivity();
        if (result == ConnectivityResult.none) {
          Fluttertoast.showToast(
              msg: 'يرجى التأكد من اتصالك بالإنترنت'.tr,
              toastLength: Toast.LENGTH_SHORT);
          return false;
        }
      }
      return true;
    } else {
      log("ErrorHandler ==> " + e.toString());
      return true;
    }
  }

  static Future<void> generateSession(bool isCancel) async {
    try {
      final ApiRequests _apiRequests = Get.find();
      final PrefManger _prefManger = Get.find();
      final CartLogic _cartLogic = Get.find();
      var response = isCancel ? await _apiRequests.cloneCart() :await _apiRequests.createSession();
      var session = response.data['payload'][isCancel ? 'session_id':'cart_session_id'];
      log("new session => $session");
      await _prefManger.setSession(session);
      await _apiRequests.onInit();
      if (isCancel) {
        _cartLogic.getCartItems(true);
      } else {
        Fluttertoast.showToast(
            msg: 'حاول مجدداً', toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }
}
