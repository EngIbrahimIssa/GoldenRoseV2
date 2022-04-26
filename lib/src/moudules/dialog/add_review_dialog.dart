import '../../colors.dart';
import '../order_details/logic.dart';
import '../../utils/custom_widget/custom_button_widget.dart';
import '../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddReviewDialog extends StatelessWidget {
  final String? productId;
  const AddReviewDialog(this.productId , {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.sp),
                topLeft: Radius.circular(15.sp))),
        builder: (builder) => GetBuilder<OrderDetailsLogic>(
            init: Get.find<OrderDetailsLogic>(),
            id: 'addReview',
            builder: (logic) {
              return Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                "أضف تعليق".tr,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              InkWell(
                                onTap: () => Get.back(),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: logic.isAnonymous,
                              onChanged: logic.changeAnonymous,
                            ),
                            CustomText(
                              "لا تظهر اسمي في قائمة العملاء".tr,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        RatingBar.builder(
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: yalowColor,
                          ),
                          initialRating: logic.rating ?? 0,
                          itemSize: 50,
                          glowColor: yalowColor,
                          unratedColor: Colors.grey.shade300,
                          onRatingUpdate: (double value) {logic.rating = value;},
                        ),
                        CustomText(
                          "قيم المنتج".tr,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 86.h,
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15.sp)),
                          child: TextField(
                            maxLines: 3,
                            controller: logic.commentController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "اكتب تعليقك هنا".tr),
                          ),
                        ),
                        CustomButtonWidget(
                            title: "إرسال".tr,
                            padding: 15,
                            loading: logic.isAddReviewLoading,
                            onClick: () => logic.addProductReviews(productId)),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ));
            }));
  }
}
