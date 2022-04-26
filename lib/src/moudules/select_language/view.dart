import '../../images.dart';
import '../../utils/custom_widget/custom_button_widget.dart';
import '../../utils/custom_widget/custom_sized_box.dart';
import '../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../colors.dart';
import 'logic.dart';

class SelectLanguagePage extends StatelessWidget {
  final SelectLanguageLogic logic = Get.put(SelectLanguageLogic());

  SelectLanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueLightSplashBackgroundColor,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: GetBuilder<SelectLanguageLogic>(builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Image.asset(
                      iconLogo,
                      width: 100.w,
                      height: 130.h,
                    ),
                  ),
                  const CustomSizedBox(
                    height: 50,
                  ),
                  CustomText(
                    "اختر اللغة".tr,
                    color: primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    "Select Language".tr,
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => logic.changeLanguage(true),
                    borderRadius: BorderRadius.circular(15.sp),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: isArabicLanguage
                              ? primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15.sp),
                          border: Border.all(color: isArabicLanguage
                              ? primaryColor
                              : blueLightColor, width: 2)),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Icon(
                            Icons.check_circle,
                            color: isArabicLanguage
                                ? Colors.white
                                : Colors.transparent,
                          ),
                          const CustomText(
                            "العربية",
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.transparent,
                          ),
                        ],
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => logic.changeLanguage(false),
                    borderRadius: BorderRadius.circular(15.sp),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: !isArabicLanguage
                              ? primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15.sp),
                          border: Border.all(color: !isArabicLanguage
                              ? primaryColor
                              : blueLightColor, width: 2)),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Icon(
                            Icons.check_circle,
                            color: !isArabicLanguage
                                ? Colors.white
                                : Colors.transparent,
                          ),
                          CustomText(
                            "English",
                            fontSize: 14,
                            color: !isArabicLanguage
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.transparent,
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              );
            }),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(imageSplash , height: 230.h, width: double.infinity, fit: BoxFit.fill,)),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20.sp),topLeft: Radius.circular(20.sp)),
                child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    child: CustomButtonWidget(title: 'التالي'.tr, onClick: ()=>logic.goToMainPage(), color: greenLightColor, textColor: Colors.white,)),
              )),
        ],
      ),
    );
  }
}
