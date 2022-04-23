import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/data/shared_preferences/pref_manger.dart';
import 'package:entaj/src/entities/success_api_response.dart';
import 'package:entaj/src/utils/error_handler/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../login/logic.dart';

class OtpLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final PrefManger _prefManger = Get.find();
  final TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  bool isLoading = false;
  bool isResendLoading = false;
  bool isFull = false;
  bool isEmail = false;
  bool isForRegistration = false;
  String errorText = "";
  int counter = 60;

  LoginLogic loginLogic = Get.find();

  @override
  void onInit() {
    startCounter();
    super.onInit();
  }
  void confirmPhone() async {
    isLoading = true;
    update();
    try {
      log(isEmail.toString());
      var response = await _apiRequests.confirmAccount(otpController.text,
          (isEmail ? '':loginLogic.selectedCode ?? "+966" ) + loginLogic.phoneController.text , isEmail: isEmail);

      log(response.data.toString());
      SuccessApiResponse successApiResponse =
          SuccessApiResponse.fromJson(response.data);

      await _prefManger
          .setToken(successApiResponse.payload?.customerAccessToken);
      await _prefManger.setSession(successApiResponse.payload?.cartSessionId);
      await _prefManger.setIsLogin(true);
      await _apiRequests.onInit();

      if(isForRegistration) Get.back();
      Get.back();
      Get.back();
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          errorController.add(ErrorAnimationType.shake);
          try {
            errorText = e.response!.data['message']['description'].toString();
          } catch (ee) {}
        }
      }
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

  Future<void> resendCode() async {
    isResendLoading = true;
    update(['resend']);
    try {
      var response = await _apiRequests.login(
          loginLogic.selectedCode ?? "+966", loginLogic.phoneController.text , isEmail: isEmail);

      startCounter();
      log(response.data.toString());
    } catch (e) {
      ErrorHandler.handleError(e);
    }

    isResendLoading = false;
    update(['resend']);
  }

  void startCounter() async {
    counter = 60;
    while(counter>0){
      counter --;
      update(['resend']);
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
