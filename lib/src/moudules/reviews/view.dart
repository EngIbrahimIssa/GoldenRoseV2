import '../../colors.dart';
import '../../utils/custom_widget/custom_text.dart';
import '../../utils/item_widget/item_review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ReviewsPage extends StatelessWidget {
  final String productId;
  final bool isFromOrderDetails;
  final ReviewsLogic logic = Get.put(ReviewsLogic());

  ReviewsPage(
      {required this.productId, required this.isFromOrderDetails, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    logic.clearAndFetch(mProductId: productId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          "التقييمات".tr,
          fontSize: 16,
        ),
        centerTitle: false,
        actions: [
          if (isFromOrderDetails)
            InkWell(
              onTap: () => logic.openAddReviewDialog(productId),
              child: Row(
                children: [
                  CustomText(
                    "أضف تقييم".tr,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.add_circle,
                    color: secondaryColor,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
            )
        ],
      ),
      body: GetBuilder<ReviewsLogic>(builder: (logic) {
        return logic.isLoading
            ? const Center(child: CircularProgressIndicator())
            : logic.reviewsModel == null
                ? const Center(child: CustomText("Error"))
                : Stack(
                    children: [
                      logic.reviews.isEmpty
                          ? Center(
                              child: CustomText('لا يوجد تقييمات سابقة'.tr),
                            )
                          : RefreshIndicator(
                              onRefresh: () async => logic.clearAndFetch(
                                  mProductId: productId, forRefresh: true),
                              child: ListView.builder(
                                  controller: logic.scrollController,
                                  itemCount: logic.reviews.length,
                                  itemBuilder: (context, index) => ItemReview(
                                        review: logic.reviews[index],
                                      )),
                            ),
                      if (logic.isUnderLoading)
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        )
                    ],
                  );
      }),
    );
  }
}
