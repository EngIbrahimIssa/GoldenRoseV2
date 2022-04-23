import 'dart:developer';

import 'package:entaj/src/app_config.dart';
import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/entities/success_api_response.dart';
import 'package:entaj/src/utils/error_handler/error_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../otp/view.dart';
import '../register/view.dart';

class LoginLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();

  final TextEditingController phoneController = TextEditingController();
  bool isEmail = false;
  bool isLoading = false;
  String? selectedCode;

  changeCodeSelected(String? newCode) {
    selectedCode = newCode;
    update(['code']);
  }

  void login() async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.login(
          selectedCode ?? AppConfig.countriesCodes.first, phoneController.text , isEmail: isEmail);
      log(response.data.toString());
      SuccessApiResponse successApiResponse =
          SuccessApiResponse.fromJson(response.data);
      if (successApiResponse.payload?.status == 'registration_needed') {
        Get.to(RegisterPage(isEmail : isEmail));
      } else {
        Get.to(OtpPage(isEmail : isEmail , isForRegistration: false,));
      }
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

  changeEmailPhone(context) {
    isEmail = !isEmail;
    phoneController.text = '';
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      Future.delayed(const Duration(milliseconds: 100)).then((value) => currentFocus.requestFocus());
    }
    update();
  }
}
