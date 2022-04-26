import 'package:url_launcher/url_launcher.dart';

import '../../app_config.dart';
import '../../colors.dart';
import '../upload_transfer/view.dart';
import '../../utils/custom_widget/custom_button_widget.dart';
import '../../utils/custom_widget/custom_image.dart';
import '../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../_main/tabs/orders/logic.dart';
import 'logic.dart';

class OrderDetailsPage extends StatelessWidget {
  final String code;
  final OrderDetailsLogic logic = Get.put(OrderDetailsLogic());

  OrderDetailsPage(this.code, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logic.getOrdersDetails(code, false);
    var index = 1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          "تفاصيل الطلب".tr,
          fontSize: 16,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => logic.getOrdersDetails(code, true),
        child: SingleChildScrollView(
          child: GetBuilder<OrderDetailsLogic>(builder: (logic) {
            return logic.isLoading
                ? const Center(child: CircularProgressIndicator())
                : logic.orderModel == null
                    ? Center(child: CustomText("Error".tr))
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: CustomText(
                              "رقم الطلب: #".tr +
                                  logic.orderModel!.id.toString(),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )),
                            if (logic.orderModel?.needTransfer == true)
                              Container(
                                padding: const EdgeInsets.all(15),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                    color: blueLightColor,
                                    borderRadius: BorderRadius.circular(15.sp)),
                                child: Column(
                                  children: [
                                    CustomText(
                                      "بإنتظار إتمام الدفع لتجهيز طلبك، لإتمام الدفع ومعرفة معلومات الحساب البنكي"
                                          .tr,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomButtonWidget(
                                      title: "إضغط هنا".tr,
                                      onClick: () => Get.to(UploadTransferPage(
                                          total: logic
                                              .orderModel?.orderTotalString,
                                          code: logic.orderModel?.code)),
                                      width: 200.w,
                                      textSize: 12,
                                      textColor: Colors.black,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            CustomText(
                              "المنتجات".tr,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                                itemCount:
                                    logic.orderModel?.products?.length ?? 0,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    buildProductItem(
                                        logic.orderModel!.products![index].id,
                                        index,
                                        logic.orderModel?.orderStatus?.code ==
                                            'delivered')),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          "طريقة التوصيل".tr,
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                        CustomText(
                                          logic.orderModel?.shipping?.method
                                              ?.name,
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
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          "تاريخ إنشاء الطلب".tr,
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                        CustomText(
                                          logic.orderModel?.createdAt,
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
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          "طريقة الدفع".tr,
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                        CustomText(
                                          logic.orderModel?.payment?.method
                                              ?.name,
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
                                        color: OrdersLogic()
                                            .getOrderStatusColor(
                                                logic.orderModel!.orderStatus!)
                                            .withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              "الحالة".tr,
                                              fontSize: 10,
                                              color: OrdersLogic()
                                                  .getOrderStatusColor(logic
                                                      .orderModel!
                                                      .orderStatus!),
                                            ),
                                            CustomText(
                                              logic.orderModel?.orderStatus
                                                  ?.name,
                                              fontWeight: FontWeight.bold,
                                              color: OrdersLogic()
                                                  .getOrderStatusColor(logic
                                                      .orderModel!
                                                      .orderStatus!),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        index != 0
                                            ? Visibility(
                                                visible: (logic
                                                            .orderModel!
                                                            .orderStatus
                                                            ?.code ==
                                                        'preparing' ||
                                                    logic
                                                            .orderModel!
                                                            .orderStatus
                                                            ?.code ==
                                                        'delivered'),
                                                child: Icon(
                                                  logic.orderModel!.orderStatus
                                                              ?.code ==
                                                          'preparing'
                                                      ? Icons
                                                          .watch_later_rounded
                                                      : Icons.check_circle,
                                                  color: OrdersLogic()
                                                      .getOrderStatusColor(logic
                                                          .orderModel!
                                                          .orderStatus!),
                                                  size: 30,
                                                ),
                                              )
                                            : CustomButtonWidget(
                                                title: "ادفع",
                                                width: 80.w,
                                                onClick: () {},
                                                color: Colors.white,
                                                textColor: primaryColor,
                                                height: 32.h,
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(15.sp)),
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    "التوصيل".tr,
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        "الدولة".tr,
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          logic.orderModel?.shipping?.address
                                              ?.country?.name,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        "المدينة".tr,
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          logic.orderModel?.shipping?.address
                                              ?.city?.name,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        "الحي".tr,
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          logic.orderModel?.shipping?.address
                                              ?.district,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        "الشارع".tr,
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          logic.orderModel?.shipping?.address
                                              ?.street,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(15.sp)),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: logic
                                        .orderModel?.payment?.invoice?.length ??
                                    0,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: CustomText(
                                          logic.orderModel?.payment
                                              ?.invoice?[index].title,
                                          fontWeight: (index ==
                                                  logic.orderModel!.payment!
                                                          .invoice!.length -
                                                      1)
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 13,
                                        ),
                                      ),
                                      CustomText(
                                        logic.orderModel?.payment
                                            ?.invoice?[index].valueString,
                                        fontWeight: (index ==
                                                logic.orderModel!.payment!
                                                        .invoice!.length -
                                                    1)
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      );
          }),
        ),
      ),
    );
  }

  GetBuilder buildProductItem(id, int index, bool isDelivered) {
    return GetBuilder<OrderDetailsLogic>(
        init: Get.find<OrderDetailsLogic>(),
        id: id ?? '',
        builder: (logic) {
          var product = logic.orderModel?.products?[index];
          return InkWell(
            onTap: () => Get.toNamed(
                "/product-details/${product?.parentId ?? product?.id}"),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15.sp)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15.sp),
                          child: product?.images?.isNotEmpty == true
                              ? CustomImage(
                                  url: product?.images?.first.origin
                                              ?.contains('missing_image') ==
                                          true
                                      ? ''
                                      : product?.images?.first.origin,
                                  fit: BoxFit.contain,
                                  width: 80,
                                  height: 80,
                                  size: 40,
                                  loading: false,
                                )
                              : const CustomImage(
                                  url: '',
                                  fit: BoxFit.contain,
                                  width: 80,
                                  height: 80,
                                  size: 40,
                                  loading: false,
                                )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            product?.name,
                            fontWeight: FontWeight.bold,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: CustomText(
                                  product?.totalBeforeString,
                                  color: moveColor,
                                  lineThrough: true,
                                ),
                              ),
                              if (product?.totalBeforeString != null)
                                const SizedBox(
                                  width: 10,
                                ),
                              Flexible(
                                child: CustomText(
                                  product?.totalString,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor,
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: ((product?.quantity?.bitLength ?? 0) * 4.w) < 50
                            ? 50.sp
                            : ((product?.quantity?.bitLength ?? 0) * 4.w),
                        height: 50.sp,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15.sp)),
                        child: CustomText(
                          product?.quantity.toString(),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  logic.isReviewsLoading || !isDelivered
                      ? const SizedBox()
                      : (product?.reviews == null)
                          ? InkWell(
                              onTap: () =>
                                  logic.openAddReviewDialog(product?.id),
                              child: Container(
                                alignment: Alignment.center,
                                height: 38.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.sp)),
                                padding: EdgeInsets.all(6.sp),
                                child: CustomText(
                                  'قيّم المنتج'.tr,
                                  color: primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Row(
                              children: [
                                const SizedBox(
                                  width: 100,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Divider(),
                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: yalowColor,
                                            ),
                                            itemSize: 20,
                                            rating:
                                                product?.reviews?.rating ?? 0.0,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          CustomText(
                                              product?.reviews?.ratingString)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (product?.reviews?.status ==
                                          'approved')
                                        CustomText(
                                          product?.reviews?.comment,
                                          color: Colors.grey.shade800,
                                        ),
                                      if (product?.reviews?.status ==
                                          'approved')
                                        const SizedBox(
                                          height: 10,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                  if (AppConfig.enhancements)
                    ListView.builder(
                        itemCount: product?.customFields?.length ?? 0,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var customField = product?.customFields?[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Row(
                              children: [
                                Flexible(
                                    child: CustomText(customField?.groupName ??
                                        customField?.realName)),
                                const SizedBox(
                                  width: 10,
                                ),
                                (product?.customFields?[index].type == 'IMAGE')
                                    ? Flexible(
                                        child: CustomImage(
                                        url: product?.customFields?[index]
                                            .formattedValue,
                                        height: 70,
                                        width: 70,
                                      ))
                                    : (customField?.type == 'FILE')
                                        ? Flexible(
                                            child: GestureDetector(
                                            onTap: () => launch(
                                                customField?.formattedValue ??
                                                    ''),
                                            child: CustomText(
                                              'تحميل'.tr,
                                              color: Colors.blue,
                                            ),
                                          ))
                                        : Flexible(
                                            child:
                                                CustomText(customField?.value)),
                                if ((customField?.type == 'DROPDOWN' ||
                                    customField?.type == 'CHECKBOX'))
                                  const SizedBox(
                                    width: 10,
                                  ),
                                if ((customField?.type == 'DROPDOWN' ||
                                    customField?.type == 'CHECKBOX'))
                                  Flexible(
                                      child: CustomText(customField?.realName)),
                                const SizedBox(
                                  width: 10,
                                ),
                                if (customField?.additionsPrice != null &&
                                    customField?.additionsPrice != 0)
                                  Flexible(
                                      child: CustomText(
                                          customField?.additionsPriceString))
                              ],
                            ),
                          );
                        }),
                ],
              ),
            ),
          );
        });
  }
}
