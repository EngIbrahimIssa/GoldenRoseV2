import 'dart:developer';
import 'dart:io';

import '../../data/remote/api_requests.dart';
import '../../entities/reviews_model.dart';
import '../dialog/add_review_dialog.dart';
import '../../utils/error_handler/error_handler.dart';
import 'package:flutter/material.dart';
  import 'package:get/get.dart';

class ReviewsLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  bool isLoading = false;
  bool isUnderLoading = false;
  ReviewsModel? reviewsModel;
  List<Reviews?> reviews = [];

  String? productId;
  int mPage = 1;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_reviewsScrollListener);
  }

  void _reviewsScrollListener() async {
    var scrollable = Platform.isAndroid ? !scrollController.position.outOfRange : scrollController.position.outOfRange;
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        scrollable && isUnderLoading == false) {
      if(reviewsModel?.pagination?.resultCount != reviews.length){
        getProductReviews(page: ++mPage);
      }
    }
  }

  void openAddReviewDialog(String? productId) {
    Get.bottomSheet(AddReviewDialog(productId));
  }

  void getProductReviews(
      {String? mProductId, int page = 1}) async {
    if (mProductId != null) {
      productId = mProductId;
    }
    if(reviews.isEmpty) isLoading = true;
    if(reviews.isNotEmpty) isUnderLoading = true;
    update();
    try {
      var response = await _apiRequests.getProductReviews(
          productId: productId, page: page);
      log(response.data.toString());
      reviewsModel = ReviewsModel.fromJson(response.data['payload']);
      reviews.addAll(reviewsModel?.reviews ?? []);
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    isUnderLoading = false;
    update();
  }

  void clearAndFetch({String? mProductId  , bool forRefresh = false}) {

    if(mProductId != productId || forRefresh) {
      reviews = [];
      reviewsModel = null;
      mPage = 1;
      getProductReviews(mProductId: mProductId);
    }
  }
}
