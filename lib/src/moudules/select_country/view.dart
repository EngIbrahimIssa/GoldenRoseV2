import '../../utils/custom_widget/custom_button_widget.dart';
import '../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import '../_main/logic.dart';
import 'logic.dart';

class SelectCountryPage extends StatelessWidget {
  final SelectCountryLogic logic = Get.put(SelectCountryLogic());

  SelectCountryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        title: CustomText(
          "الشحن إلى".tr,
          fontSize: 16,
        ),
      ),
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: GetBuilder<MainLogic>(
                init: Get.find<MainLogic>(),
                id:'countries',
                builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "اختر الدولة".tr,
                    color: primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    "حدد وجهة التسوق الخاصة بك".tr,
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: logic.settingModel?.settings
                              ?.currencies?.length ??
                              0,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: ()=>logic.changeCountrySelected(index),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: logic.selectedCountry == index
                                    ? primaryColor.withOpacity(0.2)
                                    : Colors.white,
                                borderRadius:
                                BorderRadius.circular(15.sp),
                              ),
                              child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        logic
                                            .settingModel
                                            ?.settings
                                            ?.currencies?[index]
                                            .country
                                            ?.name,
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  )),
                            ),
                          ))),
                  const SizedBox(height: 15,),
                  CustomButtonWidget(
                    title: 'حفظ'.tr,
                    onClick: () => logic.saveCountry(),
                    color: greenLightColor,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 15,)
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
