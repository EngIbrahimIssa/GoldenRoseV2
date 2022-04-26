import '../logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/custom_widget/custom_text.dart';

class ProductNotifyWidget extends StatelessWidget {
  const ProductNotifyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsLogic>(
        id: 'notify',
        init: Get.find<ProductDetailsLogic>(),
        builder: (logic) {
          return (logic.productModel?.quantity == 0)
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.sp),
                          topRight: Radius.circular(25.sp))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        "المنتج غير متوفر حالياً".tr,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      CustomText(
                        "أدخل بريدك الإلكتروني ليتم إعلامك عندما يتوفر مرة أخرى"
                            .tr,
                        fontSize: 10,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(15.sp)),
                        child: TextField(
                          controller: logic.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              hintText: "البريد الإلكتروني".tr),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              : const SizedBox();
        });
  }
}
