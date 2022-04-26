import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../colors.dart';
import '../../../../images.dart';
import '../../../../utils/custom_widget/custom_button_widget.dart';
import '../../../../utils/custom_widget/custom_text.dart';
import '../../../../utils/item_widget/item_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../services/app_events.dart';
import 'logic.dart';

class OrdersPage extends StatelessWidget {
  final OrdersLogic logic = Get.put(OrdersLogic());
  final AppEvents _appEvents = Get.find();

  OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _appEvents.logScreenOpenEvent('OrdersTab');
    logic.selected = null;
    logic.getOrders();
    return Column(
      children: [
        AppBar(
          backgroundColor: headerBackgroundColor,
          foregroundColor: headerForegroundColor,
          title: CustomText(
            "طلباتي".tr,
            fontSize: 16,
            color: headerForegroundColor,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Image.asset(iconLogoText , color: headerLogoColor,),
            )
          ],
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => logic.getOrders(),
            child: Container(
              height: Get.height,
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Column(
                children: [
                  GetBuilder<OrdersLogic>(
                      builder: (logic) => !logic.isLogin
                          ? Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 500.h,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.only(left: 50, right: 50),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100.h,
                                    ),
                                    Image.asset(
                                      iconLogo,
                                      height: 85.h,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    SizedBox(
                                      height: 40.h,
                                    ),
                                    CustomButtonWidget(
                                      title: "تسجيل / دخول مستخدم".tr,
                                      onClick: () => logic.goToLogin(),
                                      color: greenLightColor,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : logic.loading
                              ? Shimmer.fromColors(
                                  baseColor: baseColor,
                                  highlightColor: highlightColor,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(15.sp)),
                                      padding: const EdgeInsets.all(12),
                                      child: const SizedBox(
                                        height: 30,
                                        width: double.infinity,
                                      )))
                              : logic.orderList.isEmpty
                                  ? const SizedBox()
                                  : DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        iconSize: 0,
                                        dropdownDecoration: BoxDecoration(
                                          color: dropdownColor,
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                        ),
                                        itemPadding: EdgeInsets.zero,
                                        dropdownPadding: EdgeInsets.zero,
                                        itemHeight: 60.h,
                                        scrollbarAlwaysShow: true,
                                        isExpanded: true,
                                        selectedItemBuilder: (con) {
                                          return logic.orderStatusList
                                              .map((selectedType) {
                                            return Container(
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius: BorderRadius.circular(15.sp)),
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomText(
                                                        selectedType,
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                          }).toList();
                                        },
                                        hint: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(15.sp)),
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                iconOrders,
                                                scale: 2,
                                                color: primaryColor,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              CustomText(
                                                "طلباتي".tr,
                                                color: primaryColor,
                                              ),
                                              const Spacer(),
                                              const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: primaryColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        onChanged: (newValue) {
                                          logic.setSelected(newValue);
                                        },
                                        value: logic.selected,
                                        items: logic.orderStatusList
                                            .map((selectedType) {
                                          return DropdownMenuItem(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Spacer(),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: CustomText(
                                                    selectedType,
                                                    textAlign:
                                                        TextAlign.center,
                                                    fontSize: 10,
                                                    color: dropdownTextColor,
                                                  ),
                                                ),
                                                const Spacer(),
                                                if (selectedType !=
                                                    logic.orderStatusList[
                                                        logic.orderStatusList
                                                                .length -
                                                            1])
                                                  Container(
                                                    height: 1,
                                                    color:
                                                        dropdownDividerLineColor,
                                                  )
                                              ],
                                            ),
                                            value: selectedType,
                                          );
                                        }).toList(),
                                      ),
                                    )),
                  const SizedBox(
                    height: 15,
                  ),
                  GetBuilder<OrdersLogic>(builder: (logic) {
                    return Expanded(
                        child: logic.loading
                            ? Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: ListView.builder(
                                    itemCount: 20,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) =>
                                        ItemOrder(index, null)))
                            : logic.orderList.isEmpty && logic.isLogin
                                ? Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 50, right: 50),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          iconOrders,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CustomText(
                                          "لا يوجد لديك طلبات سابقة".tr,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: logic.orderList.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) => ItemOrder(
                                        index, logic.orderList[index])));
                  })
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
