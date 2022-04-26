import '../../../colors.dart';
import '../../../utils/custom_widget/custom_button_widget.dart';
import '../../../utils/custom_widget/custom_sized_box.dart';
import '../../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../.env.dart';
import '../../../app_config.dart';
import '../../../utils/functions.dart';
import 'logic.dart';

class OtpPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final  bool isEmail;
  final  bool isForRegistration;
  OtpPage({Key? key,required this.isEmail,required this.isForRegistration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OtpLogic logic = Get.put(OtpLogic());
    logic.isEmail = isEmail;
    logic.isForRegistration = isForRegistration;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          "رمز التفعيل".tr,
          fontSize: 16,
        ),
      ),
      body: GetBuilder<OtpLogic>(
          init: Get.find<OtpLogic>(),
          builder: (logic) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const CustomSizedBox(
                              height: 60,
                            ),
                            isEmail ?CustomText(
                              "تم إرسال رمز التفعيل للبريد الإلكتروني\n".tr +
                                  logic.loginLogic.phoneController.text,
                              textAlign: TextAlign.center,
                            ) : CustomText(
                              "تم إرسال رمز التفعيل للرقم ".tr +
                                  (logic.loginLogic.selectedCode ??
                                      AppConfig.countriesCodes.first) +
                                  logic.loginLogic.phoneController.text,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: PinCodeTextField(
                                length: 4,
                                obscureText: false,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(15.sp),
                                  fieldHeight: 70.sp,
                                  fieldWidth: 70.sp,
                                  errorBorderColor: moveColor,
                                  activeColor: logic.errorText.isNotEmpty
                                      ? moveColor
                                      : primaryColor,
                                  activeFillColor: logic.errorText.isNotEmpty
                                      ? moveColor.withOpacity(0.3)
                                      : primaryColor,
                                  selectedColor: Colors.grey.shade300,
                                  selectedFillColor: Colors.grey.shade300,
                                  inactiveColor: Colors.grey.shade300,
                                  inactiveFillColor: Colors.grey.shade300,
                                ),
                                textStyle: const TextStyle(color: Colors.white),
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                keyboardType: TextInputType.number,
                                errorAnimationController: logic.errorController,
                                controller: logic.otpController,
                                onCompleted: (v) {},
                                onChanged: (value) {
                                  /*logic.otpController.text =
                                      replaceArabicNumber(value);
                                  logic.otpController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset:
                                          logic.otpController.text.length));
                                  */logic.errorText = "";
                                  logic.isFull = value.length == 4;
                                  logic.update();
                                },
                                beforeTextPaste: (text) {
                                  return true;
                                },
                                appContext: context,
                              ),
                            ),
                            Visibility(
                              visible: logic.errorText.isNotEmpty,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error,
                                    color: moveColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomText(
                                    logic.errorText,
                                    color: moveColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: false,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error,
                                    color: moveColor,
                                  ),
                                  CustomText(
                                    "رمز التفعيل المدخل غير صحيح".tr,
                                    color: moveColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GetBuilder<OtpLogic>(
                                init: Get.find<OtpLogic>(),
                                id: 'resend',
                                builder: (logic) {
                                  return logic.isResendLoading
                                      ? const CircularProgressIndicator()
                                      : InkWell(
                                          onTap: () => logic.counter == 60 || logic.counter == 0 ? logic.resendCode() : null,
                                          child: Column(
                                            children: [
                                              CustomText(
                                                "لم يصلك الرمز؟ طلب مرة أخرى".tr,
                                                color: logic.counter == 60 || logic.counter == 0 ? secondaryColor : Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                             if(logic.counter != 0 && logic.counter!=60) CustomText(
                                                '00:${logic.counter}',
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                        );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 10,
                              spreadRadius: 0.1)
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.sp),
                            topLeft: Radius.circular(25.sp)),
                        color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: CustomButtonWidget(
                        title: "تأكيد ودخول".tr,
                        loading: logic.isLoading,
                        color: !logic.isFull
                            ? Colors.grey.shade300
                            : authButtonColor,
                        textColor:
                            !logic.isFull ? Colors.grey : authTextButtonColor,
                        onClick: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          FocusScope.of(context).unfocus();

                          logic.confirmPhone();
                        })),
              ],
            );
          }),
    );
  }
}
