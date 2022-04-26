import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';
import '../../app_config.dart';
import '../../entities/cart_model.dart';
import '../../images.dart';
import '../custom_widget/custom_image.dart';
import '../custom_widget/custom_text.dart';
import 'package:flutter/cupertino.dart' as cup;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import '../../moudules/_main/tabs/cart/logic.dart';
import '../functions.dart';

class ItemCart extends cup.StatefulWidget {
  final Products product;

  const ItemCart(this.product, {Key? key}) : super(key: key);

  @override
  cup.State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends cup.State<ItemCart> {
  final CartLogic _cartLogic = Get.find();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartLogic>(
        id: widget.product.id,
        autoRemove: false,
        builder: (logic) {
          return Dismissible(
            direction:
                isLoading ? DismissDirection.none : DismissDirection.endToStart,
            resizeDuration: const Duration(milliseconds: 200),
            key: UniqueKey(),
            onDismissed: (direction) {
              if (isLoading) return;
              _cartLogic.deleteItem(widget.product.id!);
            },
            child: GestureDetector(
              onTap: () =>
                  Get.toNamed('/product-details/${widget.product.productId}'),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 12),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CustomImage(
                            url: widget.product.images?.first.origin
                                        ?.contains('missing_image') ==
                                    true
                                ? ''
                                : widget.product.images?.first.origin ?? '',
                            width: 70,
                            height: 60,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                widget.product.name,
                                fontWeight: FontWeight.bold,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: CustomText(
                                      widget.product.totalBeforeString,
                                      color: moveColor,
                                      fontSize: 10,
                                      maxLines: 1,
                                      lineThrough: true,
                                    ),
                                  ),
                                  if (widget.product.totalBeforeString
                                          ?.isNotEmpty ==
                                      true)
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  Flexible(
                                    child: CustomText(
                                      widget.product.totalString,
                                      color: secondaryColor,
                                      overflow: TextOverflow.visible,
                                      fontWeight: FontWeight.bold,
                                      maxLines: 1,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              if ((widget.product.quantity ?? 0) > 1)
                                CustomText(
                                  isArabicLanguage
                                      ? '(للواحد ${widget.product.priceString})'
                                      : '(each ${widget.product.priceString})',
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: () => logic.increaseQuantity(widget.product),
                            child: Container(
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(
                                          isArabicLanguage ? 0 : 15.sp),
                                      topLeft: Radius.circular(
                                          isArabicLanguage ? 0 : 15.sp),
                                      bottomRight: Radius.circular(
                                          isArabicLanguage ? 15.sp : 0),
                                      topRight: Radius.circular(
                                          isArabicLanguage ? 15.sp : 0),
                                    )),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10.w),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                )),
                          ),
                          Container(
                              height: double.infinity,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 0.w),
                              child: Center(
                                  child: CustomText(widget.product
                                              .isOriginalQuantityFinished ==
                                          true
                                      ? '0'
                                      : widget.product.quantity.toString()))),
                          GestureDetector(
                            onTap: () => logic.decreaseQuantity(widget.product),
                            child: Container(
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        isArabicLanguage ? 15.sp : 0),
                                    topLeft: Radius.circular(
                                        isArabicLanguage ? 15.sp : 0),
                                    bottomRight: Radius.circular(
                                        isArabicLanguage ? 0 : 15.sp),
                                    topRight: Radius.circular(
                                        isArabicLanguage ? 0 : 15.sp),
                                  ),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10.w),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () async {
                                if (isLoading) return;
                                isLoading = true;
                                setState(() {});
                                await _cartLogic.deleteItem(widget.product.id!);
                                isLoading = false;
                                setState(() {});
                              },
                              child: cup.SizedBox(
                                width: 40,
                                child: isLoading
                                    ? const cup.CupertinoActivityIndicator()
                                    : Image.asset(
                                        iconDelete,
                                      ),
                              ))
                        ],
                      ),
                    ),
                    if (widget.product.isProductPriceUpdated == true ||
                        widget.product.isOriginalQuantityFinished == true)
                      Container(
                        width: double.infinity,
                        decoration: cup.BoxDecoration(
                            color: moveColor.withOpacity(0.4),
                            borderRadius: cup.BorderRadius.circular(8)),
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        child: cup.Column(
                          crossAxisAlignment: cup.CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              widget.product.isOriginalQuantityFinished == true
                                  ? 'نفذت الكمية'.tr
                                  : 'تم تغيير سعر هذا المنتج'.tr,
                              color: Colors.red.shade900,
                              fontSize: 10,
                            ),
                            CustomText(
                              widget.product.isOriginalQuantityFinished == true
                                  ? 'احذف المنتج لإتمام عملية الشراء'.tr
                                  : 'قم بإضافته مرة أخرى بالضغط على المنتج'.tr,
                              color: Colors.red.shade900,
                              fontSize: 10,
                            ),
                          ],
                        ),
                      ),
                    if(AppConfig.enhancements) ListView.builder(
                        itemCount: widget.product.customFields?.length ?? 0,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var customField = widget.product.customFields?[index];
                          return cup.Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Row(
                              children: [
                                Flexible(
                                    child: CustomText(customField?.groupName ??
                                        customField?.realName)),
                                const SizedBox(
                                  width: 10,
                                ),
                                (widget.product.customFields?[index].type ==
                                        'IMAGE')
                                    ? Flexible(
                                        child: CustomImage(
                                        url: widget.product.customFields?[index]
                                            .formattedValue,
                                        height: 70,
                                        width: 70,
                                      ))
                                    : (widget.product.customFields?[index]
                                                .type ==
                                            'FILE')
                                        ? Flexible(
                                            child: cup.GestureDetector(
                                            onTap: () => launch(widget
                                                    .product
                                                    .customFields?[index]
                                                    .formattedValue ??
                                                ''),
                                            child: CustomText(
                                              'تحميل'.tr,
                                              color: Colors.blue,
                                            ),
                                          ))
                                        : Flexible(
                                            child:
                                                CustomText(customField?.value)),
                                if ((customField?.type == 'DROPDOWN' ||
                                    customField?.type == 'CHECKBOX'))
                                  const SizedBox(
                                    width: 10,
                                  ),
                                if ((customField?.type == 'DROPDOWN' ||
                                    customField?.type == 'CHECKBOX'))
                                  Flexible(
                                      child: CustomText(customField?.realName)),
                                const SizedBox(
                                  width: 10,
                                ),
                                if (customField?.additionsPrice != null &&
                                    customField?.additionsPrice != 0)
                                  Flexible(
                                      child: CustomText(
                                          customField?.additionsPriceString))
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
