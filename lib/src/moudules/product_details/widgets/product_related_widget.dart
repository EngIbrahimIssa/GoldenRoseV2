import '../logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/custom_widget/custom_text.dart';
import '../../../utils/item_widget/item_product.dart';

class ProductRelatedWidget extends StatelessWidget {
  final String productId;

  const ProductRelatedWidget({required this.productId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsLogic>(
        init: Get.find<ProductDetailsLogic>(),
        id: productId,
        builder: (logic) {
          return Container(
            color: Colors.grey.shade50,
            child: ((logic.productModel?.relatedProducts?.length ?? 0) != 0)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 3, color: Colors.grey.shade300),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CustomText(
                          "منتجات مشابهة".tr,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 290.h,
                        child: ListView.builder(
                            itemCount:
                                logic.productModel?.relatedProducts?.length ??
                                    0,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => ItemProduct(
                                logic.productModel?.relatedProducts?[index],
                                index,
                                forWishlist: false,
                                horizontal: true)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : const SizedBox(),
          );
        });
  }
}
