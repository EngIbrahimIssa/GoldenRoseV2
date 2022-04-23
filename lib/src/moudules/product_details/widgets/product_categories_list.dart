import 'package:entaj/src/moudules/category_details/view.dart';
import 'package:entaj/src/moudules/product_details/logic.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductCategoriesList extends StatelessWidget {
  const ProductCategoriesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsLogic>(
        init: Get.find<ProductDetailsLogic>(),
        builder: (logic) {
          return SizedBox(
            height: (logic.productModel?.categories?.length ?? 0) == 0 ? 0 : 30.h,
            child: ListView.builder(
                itemCount: logic.productModel?.categories?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.toNamed("/category-details/${logic.productModel?.categories?[index].id}"),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  color: Colors.grey.shade400),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              child: CustomText(
                                logic.productModel?.categories?[index].name,
                                fontSize: 10,
                              )),
                        ),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    )),
          );
        });
  }
}
