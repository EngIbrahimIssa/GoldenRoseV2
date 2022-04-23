import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import '../../images.dart';
import 'logic.dart';

class DeliveryOptionPage extends StatelessWidget {
  final DeliveryOptionLogic logic = Get.find();

  DeliveryOptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logic.getShippingMethods(false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          "خيارات الشحن".tr,
          fontSize: 16,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: GetBuilder<DeliveryOptionLogic>(builder: (logic) {
          return RefreshIndicator(
            onRefresh: () async => logic.getShippingMethods(true),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                /* Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomText(
                    "الشحن إلى".tr,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    iconSize: 0,
                    isExpanded: true,
                    hint: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            border: Border.all(color: greenColor, width: 2)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            CustomText(
                              "اختر",
                            ),
                            Icon(Icons.keyboard_arrow_down)
                          ],
                        )),
                    onChanged: logic.setSelected,
                    value: logic.selected,
                    items: logic.list.map((selectedType) {
                      return DropdownMenuItem(
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                color: blueLightColor,
                                borderRadius: BorderRadius.circular(15.sp)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  selectedType.toString(),
                                  fontSize: 10,
                                ),
                                const Icon(Icons.keyboard_arrow_down)
                              ],
                            )),
                        value: selectedType,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),*/
                Expanded(
                    child: logic.loading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: logic.listShippingMethods.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            iconCarDelivery,
                                            scale: 2,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                "خيارات الشحن".tr,
                                                fontWeight: FontWeight.bold,
                                                color: greenColor,
                                                fontSize: 10,
                                              ),
                                              CustomText(
                                                logic.listShippingMethods[index].name,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            iconCities,
                                            scale: 2,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  "المدن التي يتم تغطيتها".tr,
                                                  fontWeight: FontWeight.bold,
                                                  color: greenColor,
                                                  fontSize: 10,
                                                ),
                                                CustomText(
                                                  logic.getSelectedCities(index),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            iconCoins,
                                            scale: 2,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                "تكلفة الشحن".tr,
                                                fontWeight: FontWeight.bold,
                                                color: greenColor,
                                                fontSize: 10,
                                              ),
                                              CustomText(
                                                logic.listShippingMethods[index].costString,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                         if(logic.listShippingMethods[index].codEnabled == true) Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                "الدفع عند الإستلام".tr,
                                                fontWeight: FontWeight.bold,
                                                color: greenColor,
                                                fontSize: 10,
                                              ),
                                              CustomText(
                                                logic.listShippingMethods[index].codFeeString,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 3,
                                  color: Colors.grey.shade200,
                                )
                              ],
                            ),
                          ))
              ],
            ),
          );
        }),
      ),
    );
  }
}
