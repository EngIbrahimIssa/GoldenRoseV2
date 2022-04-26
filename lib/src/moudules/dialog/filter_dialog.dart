import '../../data/hive/wishlist/hive_controller.dart';

import '../../colors.dart';
import '../category_details/logic.dart';
import '../../utils/custom_widget/custom_button_widget.dart';
import '../../utils/custom_widget/custom_sized_box.dart';
import '../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/functions.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
      backgroundColor: Colors.grey.shade100,
      child: SizedBox(
        height: 230.sp,
        width: 300.sp,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.sp),
          child: GetBuilder<CategoryDetailsLogic>(
              id: 'dialog',
              init: Get.find<CategoryDetailsLogic>(),
              builder: (logic) {
                return Column(
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(15.sp),
                      child: Row(
                        children: [
                          CustomText("السعر".tr, fontWeight: FontWeight.bold),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => logic.restPrice(),
                            child: CustomText(
                              "إعادة ضبط".tr,
                              color: secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CustomSizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText("من".tr),
                                  const SizedBox(height: 10,),
                                  TextField(
                                    controller: logic.startPriceController,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,

                                    textDirection: TextDirection.ltr,
                                    onChanged: (s) {
                                      logic.startPriceController.text =
                                          replaceArabicNumber(s);
                                      logic.startPriceController.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: logic
                                                      .startPriceController
                                                      .text
                                                      .length));
                                    },
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: const <TextInputFormatter>[
                                      // FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: InputDecoration(
                                        counter: const SizedBox.shrink(),
                                        hintText: HiveController.generalBox.get('currency') ?? 'SAR',
                                        contentPadding: EdgeInsets.zero,
                                        border: const OutlineInputBorder()),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText("إلى".tr),
                                  const SizedBox(height: 10,),
                                  TextField(
                                    controller: logic.endPriceController,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    textDirection: TextDirection.ltr,
                                    onChanged: (s) {
                                      logic.endPriceController.text =
                                          replaceArabicNumber(s);
                                      logic.endPriceController.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: logic
                                                      .endPriceController
                                                      .text
                                                      .length));
                                    },
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: const <TextInputFormatter>[
                                      // FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: InputDecoration(
                                        counter: const SizedBox.shrink(),
                                        hintText: HiveController.generalBox.get('currency') ?? 'SAR',
                                        contentPadding: EdgeInsets.zero,
                                        border: const OutlineInputBorder()),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          border: Border.all(color: Colors.grey.shade400),
                          color: Colors.grey.shade200),
                      child: Column(
                        children: [
                          SliderTheme(
                            data: SliderThemeData(
                              thumbColor: Colors.white,
                              overlayColor: Colors.grey,
                              activeTrackColor: Colors.grey,
                              inactiveTrackColor: Colors.grey.shade400,
                            ),
                            child: RangeSlider(
                              values: logic.rangeValues,
                              onChanged: logic.changeRange,
                            ),
                          ),
                          Row(
                            children: [
                              CustomText(
                                logic.startPriceValue() + " " +"ر.س".tr,
                                fontSize: 10,
                              ),
                              const Spacer(),
                              CustomText(
                                logic.endPriceValue()+ " " +"ر.س".tr,
                                fontSize: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Spacer(),*/
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomButtonWidget(
                        title: "تصفية".tr,
                        onClick: () => logic.filterPrices(),
                        color: Colors.white,
                        textColor: secondaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
