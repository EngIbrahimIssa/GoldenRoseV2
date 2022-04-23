import 'package:entaj/src/moudules/product_details/logic.dart';
import 'package:entaj/src/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colors.dart';
import '../../../utils/custom_widget/custom_text.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsLogic>(
        id: 'price',
        init: Get.find<ProductDetailsLogic>(),
        builder: (logic) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CustomText(logic.productModel!.salePrice.toString()),
               // if (logic.salePriceTotal > 0.0 && logic.priceTotal > 0.0)
               //   CustomText(calculateDiscount(salePriceTotal: logic.salePriceTotal, priceTotal: logic.priceTotal)),
                Row(
                  children: [
                    if (logic.productModel?.formattedSalePrice != null)
                      CustomText(
                        logic.formattedPrice,
                        color: moveColor,
                        fontSize: 14,
                        lineThrough: true,
                        fontWeight: FontWeight.w800,
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      logic.salePriceTotal != 0
                          ? logic.formattedSalePrice
                          : logic.formattedPrice,
                      color: greenColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
