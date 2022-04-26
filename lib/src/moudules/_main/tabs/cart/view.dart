import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';
import '../../../../app_config.dart';
import '../../../../colors.dart';
import '../../../../images.dart';
import '../../../../services/app_events.dart';
import '../../../../utils/custom_widget/custom_button_widget.dart';
import '../../../../utils/custom_widget/custom_text.dart';
import '../../../../utils/item_widget/item_cart.dart';
import 'logic.dart';

class CartPage extends StatelessWidget {
  final CartLogic logic = Get.find();
  final AppEvents _appEvents = Get.find();

  CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _appEvents.logScreenOpenEvent('CartTab');
    logic.isRequestToCouponLoading = false;
    logic.couponError = null;
    logic.getCartItems(true);
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: GetBuilder<CartLogic>(
          id: 'cart',
          init: Get.find<CartLogic>(),
          builder: (logic) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AppBar(
                  backgroundColor: headerBackgroundColor,
                  foregroundColor: headerForegroundColor,
                  title: CustomText(
                    "السلة".tr,
                    fontSize: 16,
                    color: headerForegroundColor,
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      child: Image.asset(
                        iconLogoText,
                        color: headerLogoColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                logic.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : (logic.cartModel?.products?.isNotEmpty == false ||
                            logic.cartModel == null)
                        ? buildEmptyCartWidget()
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async =>
                                  await logic.getCartItems(false),
                              child: SizedBox(
                                height: Get.height,
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: GetBuilder<CartLogic>(
                                      autoRemove: false,
                                      id: 'cart',
                                      init: Get.find<CartLogic>(),
                                      builder: (logic) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListView.builder(
                                              itemCount: logic.cartModel
                                                      ?.products?.length ??
                                                  0,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              itemBuilder: (context, index) =>
                                                  ItemCart(logic.cartModel!
                                                      .products![index]),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            buildCoupon(logic),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            buildTotalList(logic),
                                            buildDiscounts(logic),
                                            buildBottomTotal(logic)
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ),
                          )
              ],
            );
          }),
    );
  }

  Container buildBottomTotal(CartLogic logic) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade200,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "الإجمالي".tr,
                  fontSize: 14,
                ),
                if (logic.cartModel?.totals?.isNotEmpty == true)
                  CustomText(
                    logic.getTotal(),
                    fontSize: 16,
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                  )
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: GetBuilder<CartLogic>(
                  id: 'checkout',
                  init: Get.find<CartLogic>(),
                  autoRemove: false,
                  builder: (logic) {
                    return CustomButtonWidget(
                      title: "إتمام الدفع".tr,
                      loading: logic.checkoutLoading,
                      onClick: () => logic.generateCheckoutToken(),
                      color: buttonBackgroundCheckoutColor,
                      textColor: buttonTextCheckoutColor,
                    );
                  }))
        ],
      ),
    );
  }

  GetBuilder buildEmptyCartWidget() {
    return GetBuilder<CartLogic>(
        init: Get.find<CartLogic>(),
        id: 'cart',
        builder: (logic) {
          return Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logic.hasInternet
                      ? Image.asset(
                          iconCart,
                        )
                      : const Icon(
                          Icons.wifi_off,
                          color: Colors.grey,
                          size: 60,
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    logic.hasInternet
                        ? "لم تقم بإضافة أي منتج للسلة".tr
                        : 'يرجى التأكد من اتصالك بالإنترنت'.tr,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          );
        });
  }

  Container buildTotalList(CartLogic logic) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.sp),
              topRight: Radius.circular(15.sp))),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: logic.cartModel?.totals?.length ?? 0,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomText(
                  logic.cartModel!.totals?[index].title,
                  fontWeight: (index == logic.cartModel!.totals!.length - 1)
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
              CustomText(
                logic.cartModel!.totals![index].valueString,
                fontWeight: logic.cartModel!.totals![index].code == 'total'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCoupon(CartLogic logic) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            "كوبون الخصم".tr,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          !logic.clickOnAddCoupon
              ? CustomButtonWidget(
                  title: "أضف كوبون".tr,
                  onClick: () => logic.clickToAddCoupon(),
                  color: buttonBackgroundCouponColor,
                  textColor: buttonTextCouponColor )
              : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      color: Colors.grey.shade100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: TextField(
                              controller: logic.couponController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: logic.isRequestToCouponLoading ||
                                          logic.cartModel?.coupon != null
                                      ? logic.isCouponLoading
                                          ? null
                                          : logic.couponError != null
                                              ? InkWell(
                                                  onTap: () =>
                                                      logic.clearCoupon(),
                                                  child: Image.asset(
                                                    iconClose,
                                                    scale: 1.5,
                                                  ),
                                                )
                                              : Image.asset(
                                                  iconCheck,
                                                  scale: 1.5,
                                                )
                                      : null,
                                  labelText: "أدخل الكوبون".tr),
                            )),
                        Expanded(
                            flex: 2,
                            child: logic.cartModel?.coupon != null
                                ? CustomButtonWidget(
                                    title: "حذف".tr,
                                    onClick: () => logic.removeCoupon(),
                                    color: moveColor.withOpacity(0.35),
                                    textColor: buttonTextCouponColor,
                                    loading: logic.isCouponLoading,
                                    textSize: 10,
                                  )
                                : CustomButtonWidget(
                                    title: "تطبيق الكوبون".tr,
                                    onClick: () => logic.redeemCoupon(),
                                    color: buttonBackgroundCouponColor,
                                    loading: logic.isCouponLoading,
                                    textColor: buttonTextCouponColor,
                                    textSize: 10,
                                  ))
                      ],
                    ),
                  ),
                ),
          Visibility(
            visible: logic.cartModel?.coupon != null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                "تم خصم ".tr +
                    "${logic.cartModel?.coupon?.discountAmountString}",
                color: greenLightColor,
              ),
            ),
          ),
          Visibility(
            visible: logic.couponError != null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                logic.couponError,
                color: moveColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildDiscounts(CartLogic logic) {
    return logic.isDiscountLoading
        ? const Center(
            child: SizedBox(
                width: 15,
                height: 15,
                child: Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 1,
                ))))
        : Column(
            children: [
              if (logic.discountResponseModel != null)
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: yalowColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        iconDelivery,
                        scale: 1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      logic.getShippingFreeTarget() == 0
                          ? CustomText(
                              "قيمة الشحن مجانية الآن".tr,
                              fontWeight: FontWeight.bold,
                            )
                          : CustomText(
                              'متبقي على الشحن المجاني @discount ر.س'.trParams({
                                'discount':
                                    logic.getShippingFreeTarget().toString()
                              }),
                              fontWeight: FontWeight.bold,
                            )
                    ],
                  ),
                ),
              if (logic.mobileDiscountResponseModel != null)
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: yalowColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: Icon(
                            Icons.phone_android,
                            size: 20,
                            color: Colors.black,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomText(
                          !isArabicLanguage
                              ? 'The mobile app ${logic.mobileDiscountResponseModel?.actions?.first.value}% discount will be activated upon payment completion'
                              : 'سيتم تفعيل خصم التطبيق ${logic.mobileDiscountResponseModel?.actions?.first.value}% عند اتمام الدفع',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
            ],
          );
  }
}
