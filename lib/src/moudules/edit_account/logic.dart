import '../../data/remote/api_requests.dart';
import '../../entities/user_model.dart';
import '../../utils/error_handler/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../_main/tabs/account/logic.dart';

class EditAccountLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final AccountLogic logic = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  void setData() {
    nameController.text = logic.userModel?.name ?? '';
    emailController.text = logic.userModel?.email ?? '';
    phoneController.text = logic.userModel?.mobile
            ?.substring(3, logic.userModel?.mobile?.length) ??
        '';
  }

  Future<void> editAccountDetails() async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.editAccountDetails(
          nameController.text, emailController.text);

      logic.userModel = UserModel.fromJson(response.data['payload']);
      logic.update();
      Get.back();
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }
}
