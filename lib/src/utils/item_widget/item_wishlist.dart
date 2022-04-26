import '../../data/hive/wishlist/hive_controller.dart';
import '../custom_widget/custom_image.dart';
import '../custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app_config.dart';
import '../../colors.dart';
import '../../data/hive/wishlist/wishlist_model.dart';
import '../../images.dart';
import '../../moudules/_main/tabs/cart/logic.dart';
import '../../services/app_events.dart';
import '../functions.dart';

class ItemWishlist extends StatelessWidget {
  final WishlistModel? product;
  final int index;
  final bool horizontal;

  ItemWishlist(this.product, this.index, {Key? key, required this.horizontal})
      : super(key: key);

  final AppEvents _appEvents = Get.find();


  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.sp),
      onTap: () => Get.toNamed("/product-details/${product!.productId!}"),
      child: Row(
        children: [
          if (horizontal)
            const SizedBox(
              width: 15,
            ),
          horizontal
              ? buildContainer()
              : Expanded(
                  child: buildContainer(),
                ),
        ],
      ),
    );
  }

  ClipRRect buildContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.sp),
      child: Container(
        width: horizontal ? 190.w : null,
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 8.sp, left: 8.sp, right: 8.sp),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.sp)),
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.sp),
                          child: CustomImage(
                            url: product?.productImage,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      if (product?.productQuantity == 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(15.sp)),
                              child: CustomText(
                                "نفذت الكمية".tr,
                                color: Colors.white,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      if (product!.productSalePrice > 0 &&
                          product?.productQuantity != 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                  color: moveColor,
                                  borderRadius: BorderRadius.circular(15.sp)),
                              child: CustomText(
                                calculateDiscount(salePriceTotal:product!.productSalePrice, priceTotal: product!.productPrice),
                                color: Colors.white,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                    ],
                  )),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(6.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomText(
                        product?.productName,
                        fontWeight: FontWeight.w800,
                        maxLines: 2,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        if (product?.productFormattedSalePrice != null)
                          Expanded(
                            flex: 4,
                            child: CustomText(
                              product?.productFormattedPrice,
                              color: moveColor,
                              lineThrough: true,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        Expanded(
                          flex: 5,
                          child: CustomText(
                            product?.productFormattedSalePrice ??
                                product?.productFormattedPrice,
                            color: secondaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              GetBuilder<CartLogic>(
                                  id: 'addToCart${product!.productId!}',
                                  init: Get.find<CartLogic>(),
                                  autoRemove: false,
                                  builder: (logic) {
                                    return InkWell(
                                      onTap: () {
                                        if (product?.productHasOptions ==
                                                true ||
                                            product?.productQuantity == 0) {
                                          Get.toNamed(
                                              "/product-details/${product?.productId}");
                                          return;
                                        }
                                        logic.addToCart(product?.productId,
                                            quantity: 1.toString(),
                                            hasOptions:
                                                product!.productHasOptions,
                                            hasFields:
                                                product!.productHasFields,
                                            index: index);

                                        _appEvents.logAddToCart(
                                            product?.productName,
                                            product?.productId,
                                            product?.productPrice);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 38.h,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppConfig.showButtonWithBorder ? primaryColor : Colors.white , width: AppConfig.showButtonWithBorder ? 1 : 0),
                                            color: AppConfig.showButtonWithBorder ? Colors.white : primaryColor,
                                            borderRadius:
                                            BorderRadius.circular(15.sp)),
                                        padding: EdgeInsets.all(6.sp),
                                        child: logic.isCartLoading
                                            ? const Center(
                                            child:
                                            CircularProgressIndicator(
                                              strokeWidth: 1,
                                              valueColor:
                                              AlwaysStoppedAnimation<
                                                  Color>(secondaryColor),
                                            ))
                                            : CustomText(
                                          product?.productQuantity != 0
                                              ? "أضف للسلة".tr
                                              : 'نبهني عند توفر المنتج'
                                              .tr,
                                          color:  AppConfig.showButtonWithBorder ? primaryColor : Colors.white,
                                          textAlign: TextAlign.center,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }),
                              if (product?.productQuantity != 0 && !AppConfig.isEnableWishlist)
                                Positioned(
                                    top: 0,
                                    bottom: 0,
                                    child: Image.asset(
                                      iconCart,
                                      scale: 6,
                                      color: AppConfig.showButtonWithBorder ? primaryColor : Colors.white,
                                    )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            HiveController.getWishlist()
                                .delete(product?.productId);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 38.h,
                            decoration: BoxDecoration(
                                color: moveColor,
                                borderRadius: BorderRadius.circular(15.sp)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6.h),
                            child: const Icon(Icons.favorite_sharp,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
