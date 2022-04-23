import 'dart:math';

import 'package:entaj/src/entities/order_model.dart';
import 'package:entaj/src/moudules/order_details/view.dart';
import 'package:entaj/src/moudules/upload_transfer/view.dart';
import 'package:entaj/src/utils/custom_widget/custom_button_widget.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import '../../moudules/_main/tabs/orders/logic.dart';

class ItemOrder extends StatelessWidget {
  final int index;
  final OrderModel? orderModel;

  const ItemOrder(this.index, this.orderModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => orderModel == null ? null :Get.to(OrderDetailsPage(orderModel!.code!)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15.sp)),
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.sp)),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          "رقم الطلب".tr,
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        CustomText(
                          orderModel?.id.toString(),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.sp)),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          "تاريخ إنشاء الطلب".tr,
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        CustomText(
                          orderModel?.createdAt,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.sp)),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          "الإجمالي".tr,
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        CustomText(
                          orderModel?.transactionAmountString,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color:  OrdersLogic()
                            .getOrderStatusColor(orderModel?.orderStatus)
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15.sp)),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              "الحالة".tr,
                              fontSize: 10,
                              color: OrdersLogic()
                                  .getOrderStatusColor(orderModel?.orderStatus!),
                            ),
                            CustomText(
                              orderModel?.orderStatus?.name,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Visibility(
                          visible:
                              (orderModel?.orderStatus?.code == 'preparing' ||
                                  orderModel?.orderStatus?.code == 'delivered'),
                          child: Icon(
                            orderModel?.orderStatus?.code == 'preparing'
                                ? Icons.watch_later_rounded
                                : Icons.check_circle,
                            color: OrdersLogic()
                                .getOrderStatusColor(orderModel?.orderStatus!),
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            if (orderModel?.needTransfer == true)
              const SizedBox(
                height: 12,
              ),
            Visibility(
              visible: (orderModel?.needTransfer == true),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color:  OrdersLogic()
                        .getOrderStatusColor(orderModel?.orderStatus!).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15.sp)),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            "الحالة".tr,
                            fontSize: 10,
                            color:  OrdersLogic().getOrderStatusColor(orderModel?.orderStatus!),
                          ),
                          CustomText(
                            'بإنتظار إتمام الدفع'.tr,
                            fontWeight: FontWeight.bold,
                            color:  OrdersLogic()
                                .getOrderStatusColor(orderModel?.orderStatus!),
                          ),
                        ],
                      ),
                    ),
                    CustomButtonWidget(
                      title: "ادفع".tr,
                      width: 80.w,
                      onClick: () => Get.to(UploadTransferPage(
                        total:orderModel?.orderTotalString,
                        code : orderModel?.code
                      )),
                      color: Colors.white,
                      textColor: primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
