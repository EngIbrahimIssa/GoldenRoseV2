import 'package:entaj/src/images.dart';
import 'package:entaj/src/utils/custom_widget/custom_button_widget.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:entaj/src/utils/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../colors.dart';
import 'logic.dart';

class RegisterPage extends StatelessWidget {
  final RegisterLogic logic = Get.put(RegisterLogic());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool isEmail;

  RegisterPage({Key? key, required this.isEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logic.setData(isEmail);
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          "سجل دخولك".tr,
          fontSize: 16,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Image.asset(iconLogoText),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: GetBuilder<RegisterLogic>(builder: (logic) {
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 120,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  color: Colors.white.withOpacity(0.3)),
                              child: TextFormField(
                                controller: logic.nameController,
                                validator: Validation.nameValidate,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                    labelText: "الاسم".tr),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  color: Colors.white.withOpacity(0.3)),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: logic.emailController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                validator: Validation.emailValidate,
                                keyboardType: TextInputType.emailAddress,
                                enabled: !isEmail,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                    labelText: "البريد الإلكتروني".tr),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  color: Colors.white.withOpacity(0.3)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                     // maxLength: 9,
                                      controller: logic.phoneController,
                                      validator: Validation.phoneValidate,
                                      enabled: isEmail,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 10),
                                          labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          labelText: "رقم الجوال".tr),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                        color: Colors.white),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(Icons.keyboard_arrow_down),
                                        CustomText(
                                            logic.loginLogic.selectedCode ??
                                                "+966"),
                                        const SizedBox(
                                          width: 5,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                left: 15,
                right: 15,
                bottom: 20,
                child: CustomButtonWidget(
                  title: "طلب رمز التفعيل".tr,
                  loading: logic.isLoading,
                  height: 70.h,
                  color: authButtonColor,
                  textColor: authTextButtonColor,
                  onClick: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    FocusScope.of(context).unfocus();

                    logic.register();
                  },
                ))
          ],
        );
      }),
    );
  }
}
