import 'dart:developer';

import '../logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../app_config.dart';
import '../../../colors.dart';
import '../../../images.dart';
import '../../../services/app_events.dart';
import '../../../utils/custom_widget/custom_button_widget.dart';
import '../../../utils/functions.dart';
import '../../_main/tabs/cart/logic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductAddToCartWidget extends StatefulWidget {
  final String mProductId;
  final AppEvents _appEvents;

  const ProductAddToCartWidget(this.mProductId, this._appEvents, {Key? key})
      : super(key: key);

  @override
  State<ProductAddToCartWidget> createState() => _ProductAddToCartWidgetState();
}

class _ProductAddToCartWidgetState extends State<ProductAddToCartWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsLogic>(
        init: Get.find<ProductDetailsLogic>(),
        id: widget.mProductId,
        builder: (logic) {
          return SizedBox(
            height: 50,
            child: Row(
              children: [
                GestureDetector(
                    onTap: () => logic.increaseQuantity(),
                    child: const Card(
                      child: Icon(Icons.add),
                      margin: EdgeInsetsDirectional.only(start: 0, end: 5),
                    )),
                SizedBox(
                  width: 55.h,
                  child: Center(
                    child: GetBuilder<ProductDetailsLogic>(
                        id: 'quantity',
                        builder: (logic) {
                          return TextField(
                            controller: logic.quantityController,
                            textAlign: TextAlign.center,
                            maxLength: 4,
                            textDirection: TextDirection.ltr,
                            onChanged: (s) {
                              if (s.isEmpty) {
                                return;
                              }
                              logic.quantityController.text =
                                  replaceArabicNumber(s);
                              logic.quantityController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: logic
                                          .quantityController.text.length));

                              var inputQty = int.parse(logic.quantityController.text.toString());
                              var maxQuantityPerCart = logic.productModel?.purchaseRestrictions?.maxQuantityPerCart;
                              var productQuantity = logic.productModel?.quantity;
                              log('productQty $productQuantity --- inputQty $inputQty');

                              if(maxQuantityPerCart != null && productQuantity !=null){
                                if(productQuantity < maxQuantityPerCart){
                                  if (inputQty >= productQuantity) {
                                    logic.quantityController.text =
                                        productQuantity.toString();

                                    return;
                                  }
                                }else{
                                  if (inputQty >= maxQuantityPerCart) {
                                    logic.quantityController.text =
                                        maxQuantityPerCart.toString();

                                    return;
                                  }
                                }
                              }
                              if (maxQuantityPerCart != null) {
                                if (inputQty >= maxQuantityPerCart) {
                                  logic.quantityController.text =
                                      maxQuantityPerCart.toString();
                                  return;
                                }
                              }
                              if(logic.productModel!.quantity == null) return;


                              if (logic.productModel?.purchaseRestrictions?.maxQuantityPerCart != null) {
                                if (inputQty >= logic.productModel!.purchaseRestrictions!.maxQuantityPerCart!) {
                                  logic.quantityController.text =
                                      logic.productModel!.purchaseRestrictions!.maxQuantityPerCart!.toString();
                                  return;
                                }
                              }else if (productQuantity < inputQty) {
                                logic.quantityController.text =
                                    (logic.productModel!.quantity)
                                        .toString();
                                return;
                              }

                            },
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              // FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                                counter: SizedBox.shrink()),
                            style: TextStyle(fontSize: 16.sp),
                          );
                        }),
                  ),
                ),
                GestureDetector(
                    onTap: () => logic.decreaseQuantity(),
                    child: const Card(child: Icon(Icons.remove))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    child: Stack(
                      children: [
                        GetBuilder<CartLogic>(
                            init: Get.find<CartLogic>(),
                            id: 'addToCart${widget.mProductId}',
                            autoRemove: false,
                            builder: (cartLogic) {
                              return CustomButtonWidget(
                                title: "أضف للسلة",
                                height: double.infinity,
                                loading: cartLogic.isCartLoading,
                                textColor: Colors.white,
                                color:  primaryColor,
                                onClick: () async {
                                  logic.update([widget.mProductId]);
                                  var minQty = logic
                                      .productModel
                                      ?.purchaseRestrictions
                                      ?.minQuantityPerCart;
                                  var maxQty = logic
                                      .productModel
                                      ?.purchaseRestrictions
                                      ?.maxQuantityPerCart;
                                  if (minQty != null) {
                                    if ((int.tryParse(logic
                                        .quantityController.text) ??
                                        0) <
                                        minQty) {
                                      Fluttertoast.showToast(
                                          msg: isArabicLanguage
                                              ? "أقل كمية مسموح بها $minQty وأقصى كمية $maxQty"
                                              : 'The minimum allowed quantity is $minQty and the maximum quantity is $maxQty');
                                      return;
                                    }
                                  }
                                  var productId = logic.getProductId();

                                  widget._appEvents.logAddToCart(
                                      logic.productModel?.name,
                                      logic.productModel?.id,
                                      logic.productModel?.price);

                                  await cartLogic.addToCart(
                                    productId,
                                    context: context,
                                    quantity: logic.quantityController.text,
                                    customUserInputFieldRequest:
                                    logic.getCustomList(),
                                    hasOptions:
                                    logic.productModel?.hasOptions ?? false,
                                    hasFields:
                                    logic.productModel?.hasFields ?? false,
                                  );

                                  logic.update([widget.mProductId]);
                                },
                              );
                            }),
                        Positioned(
                            top: 0,
                            bottom: 0,
                            child: Image.asset(
                              iconCart,
                              scale: 6,
                              color: textAddToCartColor,
                            ))
                      ],
                    ),
                  ),
                ),
                if (AppConfig.showWhatsAppIconInProductPage)
                  Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15.sp)),
                    height: double.infinity,
                    margin: const EdgeInsetsDirectional.only(start: 5),
                    child: IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      icon: Image.asset(
                        iconWhatsapp,
                        scale: 2,
                      ),
                      onPressed: () =>
                          logic.goToWhatsApp(
                              message:
                              'احتاج معلومات اكثر عن المنتج ${logic.productModel
                                  ?.htmlUrl}'),
                    ),
                  )
              ],
            ),
          );
        });
  }
}
