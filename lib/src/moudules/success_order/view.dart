import '../../colors.dart';
import '../_main/logic.dart';
import '../order_details/logic.dart';
import '../order_details/view.dart';
import '../upload_transfer/view.dart';
import '../../utils/custom_widget/custom_button_widget.dart';
import '../../utils/custom_widget/custom_sized_box.dart';
import '../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../main.dart';
import '../../images.dart';

class SuccessOrderPage extends StatelessWidget {
  final String orderId;
  final OrderDetailsLogic logic = Get.put(OrderDetailsLogic());
  final MainLogic _mainLogic = Get.find();

  SuccessOrderPage({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logic.getOrdersDetails(orderId, true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: RotationTransition(
              turns: AlwaysStoppedAnimation(
                  (isArabicLanguage ? 0 : 180) / 360),
              child: Image.asset(iconBack , scale: 2,color: primaryColor,)),
          onPressed: () => logic.goToMain(),
        ) ,
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<OrderDetailsLogic>(
          builder: (logic) {
            return SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: logic.isLoading
                      ? SizedBox(
                          height: Get.height,
                          child:
                              const Center(child: CircularProgressIndicator()))
                      : Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                             iconLogo,
                              height: 60.h,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  iconBg,
                                  color: primaryColor,
                                  scale: 3,
                                ),
                                const CustomSizedBox(
                                  width: 25,
                                )
                              ],
                            ),
                            const CustomSizedBox(
                              height: 30,
                            ),
                            CustomText("تم إرسال طلبك بنجاح".tr),
                            const CustomSizedBox(
                              height: 30,
                            ),
                            CustomText("رقم الطلب: #".tr +
                                (logic.orderModel?.id ?? orderId).toString()),
                            const CustomSizedBox(
                              height: 30,
                            ),
                            CustomButtonWidget(
                              title: "عرض تفاصيل الطلب".tr,
                              color: greenLightColor,
                              width: 300.w,
                              onClick: () => Get.to(OrderDetailsPage(orderId)),
                            ),
                            const CustomSizedBox(
                              height: 30,
                            ),
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
                                      onClick: () =>
                                          Get.to(UploadTransferPage(code : orderId , total: logic.orderModel?.orderTotalString,))?.then((value) => logic.getOrdersDetails(orderId, true)),
                                      width: 200.w,
                                      textSize: 12,
                                      height: 42.h,
                                      textColor: Colors.black,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            const CustomSizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(imageTax,
                                  scale: 2,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      "الرقم الضريبي".tr,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      _mainLogic.settingModel?.settings
                                          ?.vatSettings?.vatNumber,
                                      fontWeight: FontWeight.bold,
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                ),
              ),
            );
          }),
    );
  }
}
