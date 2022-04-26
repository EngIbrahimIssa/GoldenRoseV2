import 'dart:developer';

import '../../data/remote/api_requests.dart';
import '../../entities/order_model.dart';
import '../../entities/reviews_model.dart';
import '../dialog/add_review_dialog.dart';
import '../_main/logic.dart';
import '../_main/view.dart';
import '../../utils/error_handler/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../binding.dart';

class OrderDetailsLogic extends GetxController {
  final MainLogic mainLogic = Get.find();
  final ApiRequests _apiRequests = Get.find();
  final TextEditingController commentController = TextEditingController();
  double? rating;
  bool isAnonymous = false;
  bool isLoading = true;
  bool isReviewsLoading = true;
  bool isAddReviewLoading = false;
  OrderModel? orderModel;
  String? lastOrderCode;

  getOrdersDetails(String orderCode, bool forceLoading) async {
    if (orderCode == lastOrderCode && !forceLoading) {
      return;
    }
    isLoading = true;
    update();

    lastOrderCode = orderCode;
    try {
      var response = await _apiRequests.getOrdersDetails(orderCode);
     // log(response.data.toString());
      orderModel = OrderModel.fromJson(response.data['payload']);
      orderModel?.products?.forEach((element) {
        getProductReviews(element.parentId ?? element.id , element.id);
      });
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

  Future<void> getProductReviews(String? productId, String? id) async {
    isReviewsLoading = true;
    update([id ?? '']);
    try {
      var response = await _apiRequests.getCustomerProductReviews(productId);
      log(response.data.toString());
      var payload = response.data['payload'] as List;
      if (payload.isNotEmpty) {
        orderModel?.products
            ?.singleWhere((element) {
              if(element.parentId != null) {
                return element.parentId == productId;
              }
              return element.id == productId;
            })
            .reviews = Reviews.fromJson(response.data['payload'][0]);
      }
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isReviewsLoading = false;
    update([id ?? '']);
  }

  void addProductReviews(String? productId) async {
    if (productId == null) {
      return;
    }
    if (rating == null || rating == 0) {
      Fluttertoast.showToast(msg: "يجب ادخال تقييم أولاً");
      return;
    }
    isAddReviewLoading = true;
    update(['addReview']);
    try {
      var response = await _apiRequests.addProductReviews(
          productId: productId,
          comment: commentController.text,
          rating: rating,
          isAnonymous: isAnonymous ? 1 : 0);
      await getProductReviews(productId , productId);
      Get.back();
      Fluttertoast.showToast(msg: "تم اضافة مراجعتك بنجاح".tr);
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isAddReviewLoading = false;
    update(['addReview']);
  }

  void changeAnonymous(bool? val) {
    isAnonymous = val!;
    update(['addReview']);
  }

  void onRatingUpdate(double value) {
    rating = value;
    update(['addReview']);
  }

  goToMain() {
    mainLogic.changeSelectedValue(3, false, backCount: 0);
    Get.offAll(const MainPage(), binding: Binding());
  }

  void openAddReviewDialog(String? productId) {
    commentController.text = '';
    rating = null;
    isAnonymous = false;
    Get.bottomSheet(AddReviewDialog(productId));
  }
}
