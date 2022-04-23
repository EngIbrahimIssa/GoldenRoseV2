import 'package:entaj/src/colors.dart';
import 'package:entaj/src/images.dart';
import 'package:entaj/src/moudules/_main/logic.dart';
import 'package:entaj/src/utils/custom_widget/custom_button_widget.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:entaj/src/utils/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app_config.dart';
import '../../../utils/functions.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  final LoginLogic logic = Get.put(LoginLogic());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: authForegroundAppbarColor,
        backgroundColor: authBackgroundAppbarColor,
        title: CustomText(
          "سجل دخولك".tr,
          fontSize: 16,
          color: authForegroundAppbarColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Image.asset(iconLogoText),
          ),
        ],
      ),
      body: GetBuilder<LoginLogic>(builder: (logic) {
        return Stack(
          children: [
            Container(
              color: authBackgroundColor,
            ),
            Positioned(
                left: -50.w,
                right: -50.w,
                top: -120.h,
                child: Image.asset(
                  imageArt,
                  color: authBackgroundAppbarColor,
                  height: 220.h,
                )),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp)),
                    height: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      validator: logic.isEmail
                          ? Validation.emailValidate
                          : Validation.phoneValidate,
                      keyboardType: logic.isEmail
                          ? TextInputType.emailAddress
                          : TextInputType.phone,
                      controller: logic.phoneController,
                      maxLength: logic.isEmail ? null : 9,
                      onChanged: (s) {
                        logic.phoneController.text = replaceArabicNumber(s);
                        logic.phoneController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: logic.phoneController.text.length));
                      },
                      decoration: InputDecoration(
                          labelText: logic.isEmail
                              ? 'البريد الإلكتروني'.tr
                              : "رقم الجوال".tr,
                          labelStyle: const TextStyle(color: Colors.black),
                          fillColor: Colors.white.withOpacity(0.2),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.sp),
                              borderSide: const BorderSide(
                                  color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.sp),
                              borderSide: const BorderSide(
                                  color: Colors.black)),
                          suffixIconConstraints:
                              BoxConstraints(maxHeight: 60.h, minHeight: 50.h),
                          suffixIcon: logic.isEmail
                              ? null
                              : GetBuilder<LoginLogic>(
                                  id: 'code',
                                  builder: (logic) {
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        iconSize: 0,
                                        isExpanded: false,
                                        hint: buildIcon(
                                            AppConfig.countriesCodes.first),
                                        onChanged: logic.changeCodeSelected,
                                        value: logic.selectedCode,
                                        items: AppConfig.countriesCodes
                                            .map((selectedType) {
                                          return DropdownMenuItem(
                                            child: buildIcon(selectedType),
                                            value: selectedType,
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  }),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10)),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  GetBuilder<MainLogic>(
                      init: Get.find<MainLogic>(),
                      builder: (mainLogic) {
                        return (mainLogic.settingModel?.settings
                                    ?.customersLoginByEmailStatus ==
                                true)
                            ? GestureDetector(
                                onTap: () => logic.changeEmailPhone(context),
                                child: CustomText(
                                  logic.isEmail
                                      ? "تسجيل الدخول عن طريق رقم الجوال".tr
                                      : "تسجيل الدخول عن طريق البريد الإلكتروني"
                                          .tr,
                                  color: Colors.black,
                                  fontSize: 11,
                                ))
                            : const SizedBox();
                      })
                ],
              ),
            ),
            Positioned(
                left: 15,
                right: 15,
                bottom: 20,
                child: CustomButtonWidget(
                  title: "طلب رمز التفعيل".tr,
                  loading: logic.isLoading,
                  color: authButtonColor,
                  textColor: authTextButtonColor,
                  onClick: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    FocusScope.of(context).unfocus();

                    logic.login();
                  },
                ))
          ],
        );
      }),
    );
  }

  Container buildIcon(String? text) {
    return Container(
      width: 80.w,
      height: 30.h,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 5,
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
            size: 20,
          ),
          CustomText(
            text,
            fontSize: 10,
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
    );
  }
}
