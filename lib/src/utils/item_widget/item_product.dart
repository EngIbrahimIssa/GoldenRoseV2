import 'package:entaj/main.dart';
import 'package:entaj/src/entities/product_details_model.dart';
import 'package:entaj/src/utils/custom_widget/custom_image.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app_config.dart';
import '../../colors.dart';
import '../../data/hive/wishlist/hive_controller.dart';
import '../../data/hive/wishlist/wishlist_model.dart';
import '../../images.dart';
import '../../moudules/_main/tabs/cart/logic.dart';
import '../../services/app_events.dart';
import '../functions.dart';

class ItemProduct extends StatefulWidget {
  final ProductDetailsModel? product;
  final int index;
  final bool forWishlist;
  final bool horizontal;

  const ItemProduct(this.product, this.index,
      {Key? key, this.forWishlist = false, required this.horizontal})
      : super(key: key);

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  final AppEvents _appEvents = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.sp),
      onTap: () => widget.product == null
          ? () {}
          : Get.toNamed("/product-details/${widget.product!.id!}",
          preventDuplicates: false),
      // onTap: () => Get.to(ProductDetailsPage(product!.id!)),
      child: Row(
        children: [
          if (widget.horizontal)
            const SizedBox(
              width: 15,
            ),
          widget.horizontal
              ? buildContainer()
              : Expanded(
            child: buildContainer(),
          ),
        ],
      ),
    );
  }

  Container buildContainer() {
    return Container(
      width: widget.horizontal ? 190.w : null,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: widget.product == null
          ? const SizedBox(
        height: double.infinity,
      )
          : Column(
        children: [
          Expanded(
            child: Container(
                margin:
                EdgeInsets.only(top: 8.sp, left: 5.sp, right: 5.sp),
                decoration: BoxDecoration(
                  //      color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp)),
                width: double.infinity,
                child: Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.sp),
                        child: CustomImage(
                          url: widget.product?.images?.length == 0
                              ? null
                              : widget.product?.images?[0].image?.small,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    if (widget.product?.quantity == 0)
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
                                borderRadius:
                                BorderRadius.circular(15.sp)),
                            child: CustomText(
                              "نفذت الكمية".tr,
                              color: Colors.white,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    if (widget.product!.offerLabel != null && widget.product?.quantity != 0)
                      Positioned(
                        left: isArabicLanguage ? 0 : null,
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 3, right: 3),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                              BorderRadius.circular(15.sp)),
                          child: CustomText(
                            widget.product?.offerLabel,
                            color: Colors.white,
                            textAlign: TextAlign.center,
                            fontSize: 8,
                          ),
                        ),
                      )
                    /*if (widget.product!.salePrice > 0 &&
                              widget.product?.quantity != 0)
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
                                      borderRadius:
                                          BorderRadius.circular(15.sp)),
                                  child: CustomText(
                                    calculateDiscount(
                                        salePriceTotal:
                                            widget.product?.salePrice ?? 0,
                                        priceTotal:
                                            widget.product?.price ?? 0),
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),*/
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
                      widget.product?.name,
                      fontWeight: FontWeight.w800,
                      maxLines: 2,
                      fontSize: 13,
                    ),
                  ),
                  Row(
                    children: [
                      if (widget.product?.formattedSalePrice != null)
                        Expanded(
                          flex: 4,
                          child: CustomText(
                            widget.product?.formattedPrice,
                            color: moveColor,
                            lineThrough: true,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      Expanded(
                        flex: 5,
                        child: CustomText(
                          widget.product?.formattedSalePrice ??
                              widget.product?.formattedPrice,
                          color: greenColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  if (widget.product?.hasOptions == true)
                    CustomText('متوفر بعدة خيارات'.tr),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            GetBuilder<CartLogic>(
                                id: 'addToCart${widget.product!.id!}',
                                init: Get.find<CartLogic>(),
                                autoRemove: false,
                                builder: (cartLogic) {
                                  return InkWell(
                                    onTap: () {
                                      if (widget.product?.hasOptions ==
                                          true ||
                                          widget.product?.quantity == 0) {
                                        Get.toNamed(
                                            "/product-details/${widget.product!.id!}");
                                        return;
                                      }
                                      cartLogic.addToCart(
                                          widget.product?.id,
                                          quantity: 1.toString(),
                                          hasOptions: widget
                                              .product?.hasOptions ??
                                              false,
                                          hasFields:
                                          widget.product?.hasFields ??
                                              false,
                                          index: widget.index);

                                      _appEvents.logAddToCart(
                                          widget.product?.name,
                                          widget.product?.id,
                                          widget.product?.price);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 38.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppConfig
                                                  .showButtonWithBorder
                                                  ? primaryColor
                                                  : Colors.white,
                                              width: AppConfig
                                                  .showButtonWithBorder
                                                  ? 1
                                                  : 0),
                                          color: AppConfig
                                              .showButtonWithBorder
                                              ? Colors.white
                                              : primaryColor,
                                          borderRadius:
                                          BorderRadius.circular(
                                              5.sp)),
                                      padding: EdgeInsets.all(6.sp),
                                      child: cartLogic.isCartLoading
                                          ? const Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child:
                                            CircularProgressIndicator(
                                              strokeWidth: 1,
                                              valueColor:
                                              AlwaysStoppedAnimation<
                                                  Color>(
                                                  progressColor),
                                            ),
                                          ))
                                          : CustomText(
                                        widget.product?.quantity !=
                                            0
                                            ? "أضف للسلة".tr
                                            : 'نبهني عند توفر المنتج'
                                            .tr,
                                        color: AppConfig
                                            .showButtonWithBorder
                                            ? primaryColor
                                            : Colors.white,
                                        textAlign: TextAlign.center,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                            if (widget.product?.quantity != 0 &&
                                !AppConfig.isEnableWishlist)
                              Positioned(
                                  top: 0,
                                  bottom: 0,
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(
                                        start: 3),
                                    child: Image.asset(
                                      iconCart,
                                      scale: 6,
                                      color:
                                      AppConfig.showButtonWithBorder
                                          ? primaryColor
                                          : Colors.white,
                                    ),
                                  )),
                          ],
                        ),
                      ),
                      if (AppConfig.isEnableWishlist)
                        const SizedBox(
                          width: 5,
                        ),
                      if (AppConfig.isEnableWishlist)
                        GestureDetector(
                          onTap: () async {
                            _appEvents.logAddToWishlist(
                                widget.product?.name,
                                widget.product?.id,
                                widget.product?.price);
                            var model = WishlistModel(
                              productId: widget.product?.id,
                              productName: widget.product?.name,
                              productImage:
                              widget.product?.images?.isNotEmpty ==
                                  true
                                  ? (widget.product?.images?[0].image
                                  ?.small)
                                  : null,
                              productQuantity:
                              widget.product?.quantity ?? 0,
                              productPrice: widget.product?.price ?? 0,
                              productSalePrice:
                              widget.product?.salePrice ?? 0,
                              productFormattedPrice:
                              widget.product?.formattedPrice,
                              productFormattedSalePrice:
                              widget.product?.formattedSalePrice,
                              productHasFields:
                              widget.product?.hasFields ?? false,
                              productHasOptions:
                              widget.product?.hasOptions ?? false,
                            );
                            if (HiveController.getWishlist()
                                .get(widget.product?.id) ==
                                null) {
                              await HiveController.getWishlist()
                                  .put(widget.product?.id, model);
                              setState(() {});
                            } else {
                              await HiveController.getWishlist()
                                  .delete(widget.product?.id);
                              setState(() {});
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 38.h,
                            decoration: BoxDecoration(
                                color: HiveController.getWishlist()
                                    .get(widget.product?.id) !=
                                    null
                                    ? moveColor
                                    : Colors.white,
                                borderRadius:
                                BorderRadius.circular(15.sp)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6.h),
                            child: Icon(
                              Icons.favorite_sharp,
                              color: HiveController.getWishlist()
                                  .get(widget.product?.id) !=
                                  null
                                  ? Colors.white
                                  : Colors.grey.shade400,
                            ),
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
    );
  }
}
