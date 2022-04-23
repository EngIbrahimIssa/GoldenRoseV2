import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/utils/error_handler/error_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../login/logic.dart';
import '../otp/view.dart';

class RegisterLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final LoginLogic loginLogic = Get.find();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isEmail = false;
  bool isLoading = false;

  setData(bool misEmail){
    isEmail = misEmail;
    if(isEmail){
     // phoneController.text = '';
      emailController.text = loginLogic.phoneController.text;
    }else{

      phoneController.text = loginLogic.phoneController.text;
    //  emailController.text = '';
    }
  }
  void register() async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.register(loginLogic.selectedCode ?? "+966", phoneController.text,
          nameController.text, emailController.text,isEmail:isEmail);

      Get.to(OtpPage(isEmail: isEmail , isForRegistration:true));
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }
}
