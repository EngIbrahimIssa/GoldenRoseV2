import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:entaj/src/colors.dart';
import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/data/shared_preferences/pref_manger.dart';
import 'package:entaj/src/entities/cart_model.dart';
import 'package:entaj/src/entities/discount_response_model.dart';
import 'package:entaj/src/moudules/payment/view.dart';
import 'package:entaj/src/services/app_events.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:entaj/src/utils/error_handler/error_handler.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import '../../../../.env.dart';
import '../../../_auth/login/view.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final PrefManger _prefManger = Get.find();
  final AppEvents _appEvents = Get.find();
  final TextEditingController couponController = TextEditingController();

  bool hasInternet = true;
  bool isCartLoading = false;
  bool isCartItemLoading = false;
  bool checkoutLoading = false;
  bool isCouponLoading = false;
  bool isRequestToCouponLoading = false;
  bool isLoading = false;
  bool isDiscountLoading = false;
  bool clickOnAddCoupon = false;
  CartModel? cartModel;
  String? couponError;
  DiscountResponseModel? discountResponseModel;
  DiscountResponseModel? mobileDiscountResponseModel;

  @override
  void onInit() {
    super.onInit();
    getCartItems(true);
  }

  Future<bool> checkInternetConnection() async {
    var connection =
        (await Connectivity().checkConnectivity() != ConnectivityResult.none);
    hasInternet = connection;
    update(['cart']);
    return connection;
  }

  double getShippingFreeTarget() {
    try {
      var target = discountResponseModel!.conditions!.first.value!.first;
      var discount = (target - cartModel!.productsSubtotal).floorToDouble();
      if (discount < 0) {
        return 0;
      }
      return discount;
    } catch (e) {
      return 0.0;
    }
  }

  void clickToAddCoupon() {
    clickOnAddCoupon = true;
    update(['cart']);
  }

  void goToCheckout() {
    generateCheckoutToken();
    // Get.to(SuccessOrderPage());
  }

  Future<void> getCartItems(bool withLoading) async {
    if (!await checkInternetConnection()) return;
    if (withLoading) {
      isLoading = true;
      // update();
    }

    try {
      isCartItemLoading = false;
      var response = await _apiRequests.getCart();
      cartModel = CartModel.fromJson(response.data['payload']);

      clickOnAddCoupon = cartModel?.coupon != null;
      couponController.text = cartModel?.coupon?.code ?? '';
      getDiscountRules();
    } catch (e) {
      hasInternet = await ErrorHandler.handleError(e);
    }

    if (withLoading) {
      isLoading = false;
    }
    update(['cart1']);
  }

  Future<void> getDiscountRules() async {
    discountResponseModel = null;
    isDiscountLoading = true;
    update(['cart']);

    try {
      var response = await _apiRequests.getDiscountRules();

      var list = (response.data['payload'] as List);
      list.forEach((element) {
        if (element['code'] == 'free_shipping') {
          discountResponseModel = DiscountResponseModel.fromJson(element);
        }
        if (element['code'] == 'mobile_app') {
          mobileDiscountResponseModel = DiscountResponseModel.fromJson(element);
        }
      });
    } catch (e) {
      await ErrorHandler.handleError(e);
    }

    isDiscountLoading = false;
    update(['cart']);
  }

  Future<void> deleteItem(int id) async {
    if (isCartItemLoading) return;
    isCartItemLoading = true;

    try {
      var response = await _apiRequests.deleteCartItem(id);
      cartModel?.products?.removeWhere((element) => element.id == id);
      getCartItems(false);
    } catch (e) {
      //ErrorHandler.handleError(e);
    }

    isCartItemLoading = false;
  }

  void redeemCoupon() async {
    couponError = null;
    if (couponController.text.isEmpty) {
      Fluttertoast.showToast(msg: "يرجى ادخال رمز الكوبون".tr);
      return;
    }
    isCouponLoading = true;
    update(['cart']);

    try {
      var response = await _apiRequests.redeemCoupon(couponController.text);
      await getCartItems(false);
    } catch (e) {
      try {
        if (e is DioError) {
          couponError = e.response?.data['message']['description'];
        }
      } catch (e) {
        ErrorHandler.handleError(e);
      }
    }

    isCouponLoading = false;
    isRequestToCouponLoading = true;
    update(['cart']);
  }

  void removeCoupon() async {
    isCouponLoading = true;
    update(['cart']);

    try {
      var response = await _apiRequests.removeCoupon();
      await getCartItems(false);
    } catch (e) {
      ErrorHandler.handleError(e);
    }

    isCouponLoading = false;
    update(['cart']);
  }

  Future<void> addToCart(String? productId,
      {required bool hasOptions,
      required String quantity,
      required bool hasFields,
      int? index,
      BuildContext? context,
      List? customUserInputFieldRequest}) async {
    if (productId == null) {
      Fluttertoast.showToast(
          msg: "يرجى اختيار جميع الخيارات".tr, backgroundColor: Colors.orange);
      return;
    }
    if (quantity == null || quantity == '' || quantity == '0') {
      Fluttertoast.showToast(
          msg: "يرجى ادخال الكمية".tr, backgroundColor: Colors.orange);
      return;
    }
    if (context != null) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    isCartLoading = true;
    update(['addToCart$productId']);

    try {
      var response = await _apiRequests.addCartItem(
          productId: productId,
          quantity: quantity.toString(),
          hasFields: hasFields,
          customFieldsList: customUserInputFieldRequest);
      await getCartItems(false);
      Widget widget = Container(
        height: 40.0.h,
        margin: EdgeInsets.only(left: 55.w, right: 55.w, bottom: 60.h),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.add_shopping_cart_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
                child: Center(
                    child: CustomText(
              "تم اضافة المنتج إلى السلة".tr,
              color: Colors.white,
            ))),
          ],
        ),
      );
      showToastWidget(widget, position: ToastPosition.bottom);
      // Fluttertoast.showToast(msg: "تم اضافة المنتج إلى السلة".tr, backgroundColor: greenColor , gravity: ToastGravity.TOP );
      if (await Vibration.hasVibrator() == true) {
        Vibration.vibrate(duration: 200);
      }
    } catch (e) {
      await ErrorHandler.handleError(e);
    }

    isCartLoading = false;
    update(['addToCart$productId']);
  }

  void updateCartItem(int id, int quantity, {int? index}) async {
    if(isCartItemLoading) return;
    isCartItemLoading = true;
 //   update([id]);

    try {
      var response =
          await _apiRequests.updateCartItem(id.toString(), quantity.toString());
      await getCartItems(false);
    } catch (e) {
      ErrorHandler.handleError(e);
    }

    isCartItemLoading = false;
//    update([id]);
  }


  clearCoupon() {
    couponController.text = '';
    couponError = null;
    isRequestToCouponLoading = false;
    update(['cart']);
  }

  decreaseQuantity(Products product) {
    if (isCartItemLoading) return;
    if (product.quantity == 1) {
      return;
    }
    int newQty = product.quantity! - 1;
    product.quantity = newQty;
    update([product.id!]);
    startCount(product, newQty);
  }

  increaseQuantity(Products product) {
    if (isCartItemLoading) return;
    int newQty = product.quantity! + 1;
    product.quantity = newQty;
    update([product.id!]);
    startCount(product, newQty);
  }

  Timer? _timer;
  void startCount(Products product, newQty) async {
    if(_timer != null) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500) ,(){
      updateCartItem(product.id!, newQty);
    });

  }

  void generateCheckoutToken() async {
    if (!await _prefManger.getIsLogin()) {
      Get.to(LoginPage())?.then((value) async {
        isLoading = true;
        update(['cart']);
        await Future.delayed(const Duration(seconds: 3));
        getCartItems(true);
      });
      return;
    }

    checkoutLoading = true;
    update(['checkout']);

    try {
      var response = await _apiRequests.verifyCart();
    } catch (e) {
      if (e is DioError) {
        if (e.response.toString().contains('ERROR_CART_IS_RESERVED')) {
          ErrorHandler.handleError(e);

          checkoutLoading = false;
          update(['checkout']);
          return;
        }
      }
    }
    try {
      var response = await _apiRequests.generateCheckoutToken();

      String checkoutToken =
      response.data['payload']['checkout_token'].toString();
      String checkoutUrl =
          '$storeUrl/checkout/from-token?hide-header-footer=true&checkout-token=$checkoutToken';
      log(checkoutUrl);

      _appEvents.logCheckout(
          coupon: cartModel?.coupon?.code,
          value: cartModel?.productsSubtotal,
          items: cartModel?.products
              ?.map((e) => AnalyticsEventItem(
              itemId: e.productId, itemName: e.name, price: e.total))
              .toList());

      Get.to(PaymentScreen(url: checkoutUrl),
          transition: Transition.downToUp, fullscreenDialog: true)
          ?.then((value) async {
        isLoading = true;
        update();
        await Future.delayed(const Duration(seconds: 3));
        await getCartItems(true);
      });
    } catch (e) {
      ErrorHandler.handleError(e);
    }

    checkoutLoading = false;
    update(['checkout']);
  }

}
