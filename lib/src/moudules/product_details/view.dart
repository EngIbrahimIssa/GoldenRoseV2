import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:entaj/src/binding.dart';
import 'package:entaj/src/colors.dart';
import 'package:entaj/src/entities/product_details_model.dart';
import 'package:entaj/src/images.dart';
import 'package:entaj/src/moudules/_main/view.dart';
import 'package:entaj/src/moudules/product_details/widgets/product_add_to_cart_widget.dart';
import 'package:entaj/src/moudules/product_details/widgets/product_image_widget.dart';
import 'package:entaj/src/moudules/product_details/widgets/product_price.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../services/app_events.dart';
import '../../utils/functions.dart';
import '../_main/tabs/cart/logic.dart';
import 'widgets/product_categories_list.dart';
import 'package:entaj/src/utils/custom_widget/custom_button_widget.dart';
import 'package:entaj/src/utils/custom_widget/custom_image.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:entaj/src/utils/item_widget/item_option.dart';
import 'package:entaj/src/utils/item_widget/item_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../main.dart';
import 'logic.dart';
import 'widgets/product_description_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductDetailsLogic logic = Get.put(ProductDetailsLogic());

  final AppEvents _appEvents = Get.find();

  ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productId = Get.parameters['productId'] ?? 'unknown';
    logic.getProductDetails(productId);
    logic.selectedImageIndex = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.offAll(const MainPage(), binding: Binding());
              },
              icon: GetBuilder<ProductDetailsLogic>(
                  id: productId,
                  builder: (logic) {
                    return logic.productModel == null
                        ? const SizedBox()
                        : Image.asset(
                            iconHome,
                            color: primaryColor,
                            scale: 2,
                          );
                  })),
          GetBuilder<ProductDetailsLogic>(
              id: productId,
              builder: (logic) {
                return logic.productModel == null
                    ? const SizedBox()
                    : InkWell(
                        onTap: () =>
                            Share.share(logic.productModel?.htmlUrl ?? ''),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText("مشاركة".tr),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.share)
                            ],
                          ),
                        ),
                      );
              })
        ],
      ),
      body: GetBuilder<ProductDetailsLogic>(
          // assignId: false,
          id: productId,
          builder: (logic) {
            return logic.isLoading
                ? const Center(child: CircularProgressIndicator())
                : !logic.hasInternet
                    ? Container(
                        width: double.infinity,
                        height: 600.h,
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.wifi_off,
                              color: Colors.grey,
                              size: 60,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomText(
                              'يرجى التأكد من اتصالك بالإنترنت'.tr,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      )
                    : (logic.productModel == null && logic.isProductDeleted)
                        ? Center(
                            child: CustomText("Product has been deleted".tr))
                        : logic.productModel == null
                            ? const SizedBox()
                            : Column(
                                children: [
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async =>
                                          logic.getProductDetails(productId),
                                      child: SingleChildScrollView(
                                        child: GetBuilder<ProductDetailsLogic>(
                                            builder: (logic) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ProductImageWidget(productId: productId),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      logic.productModel?.name,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const ProductCategoriesList(),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        RatingBarIndicator(
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              const Icon(
                                                            Icons.star,
                                                            color: yalowColor,
                                                          ),
                                                          itemSize: 20,
                                                          rating: logic
                                                                  .productModel
                                                                  ?.rating
                                                                  ?.average ??
                                                              0.0,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        CustomText(
                                                          '(${logic.productModel?.rating?.totalCount})',
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontSize: 11,
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    CustomText(
                                                      "رمز المنتج: ".tr +
                                                          logic
                                                              .productModel!.sku
                                                              .toString(),
                                                      fontSize: 10,
                                                    ),
                                                    const ProductDescriptionWidget()
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Divider(
                                                thickness: 3,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (logic.productModel
                                                            ?.options?.length !=
                                                        0)
                                                      GridView.builder(
                                                        itemCount: logic
                                                                .productModel
                                                                ?.options
                                                                ?.length ??
                                                            0,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemBuilder: (BuildContext
                                                                    context,
                                                                int index) =>
                                                            ItemOption(
                                                                logic
                                                                    .productModel
                                                                    ?.options?[
                                                                        index]
                                                                    .choices,
                                                                logic.productModel
                                                                        ?.options?[
                                                                    index]),
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    2,
                                                                childAspectRatio:
                                                                    1.7,
                                                                crossAxisSpacing:
                                                                    15),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              const ProductPrice(),
                                              buildCustomUserInputField(
                                                  logic.productModel!),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Divider(
                                                thickness: 3,
                                              ),
                                              Center(
                                                child: InkWell(
                                                  onTap: () =>
                                                      logic.goToReviews(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CustomText(
                                                          "عرض جميع التقييمات"
                                                              .tr,
                                                          color: greenColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        RotationTransition(
                                                            turns: AlwaysStoppedAnimation(
                                                                (isArabicLanguage
                                                                        ? 180
                                                                        : 0) /
                                                                    360),
                                                            child: Image.asset(
                                                              iconBack,
                                                              scale: 2,
                                                              color: greenColor,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Divider(
                                                thickness: 3,
                                              ),
                                              if (logic
                                                      .productModel
                                                      ?.relatedProducts
                                                      ?.length !=
                                                  0)
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: CustomText(
                                                    "منتجات مشابهة".tr,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              if (logic
                                                      .productModel
                                                      ?.relatedProducts
                                                      ?.length !=
                                                  0)
                                                SizedBox(
                                                  height: 290.h,
                                                  child: ListView.builder(
                                                      itemCount: logic
                                                              .productModel
                                                              ?.relatedProducts
                                                              ?.length ??
                                                          0,
                                                      padding: EdgeInsets.zero,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder: (context,
                                                              index) =>
                                                          ItemProduct(
                                                              logic.productModel
                                                                      ?.relatedProducts?[
                                                                  index],
                                                              index,
                                                              forWishlist:
                                                                  false,
                                                              horizontal: true)),
                                                ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      if (logic.productModel?.quantity == 0)
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(25.sp),
                                                  topRight:
                                                      Radius.circular(25.sp))),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              CustomText(
                                                "المنتج غير متوفر حالياً".tr,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                              CustomText(
                                                "أدخل بريدك الإلكتروني ليتم إعلامك عندما يتوفر مرة أخرى"
                                                    .tr,
                                                fontSize: 10,
                                                textAlign: TextAlign.center,
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade50,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.sp)),
                                                child: TextField(
                                                  controller:
                                                      logic.emailController,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      hintText:
                                                          "البريد الإلكتروني"
                                                              .tr),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  blurRadius: 10,
                                                  spreadRadius: 0.1)
                                            ],
                                            borderRadius: BorderRadius.only(
                                                topRight:
                                                    Radius.circular(25.sp),
                                                topLeft:
                                                    Radius.circular(25.sp)),
                                            color: Colors.white),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        child: logic.productModel?.quantity == 0
                                            ? GetBuilder<ProductDetailsLogic>(
                                                id: "isEmpty",
                                                builder: (logic) {
                                                  return CustomButtonWidget(
                                                      title: "ارسل",
                                                      color: !logic.isEmpty
                                                          ? primaryColor
                                                          : Colors
                                                              .grey.shade300,
                                                      textColor: !logic.isEmpty
                                                          ? Colors.white
                                                          : Colors.grey,
                                                      //textColor: Colors.grey,
                                                      loading: logic
                                                          .isNotifyMeLoading,
                                                      onClick: logic.isEmpty
                                                          ? null
                                                          : () => logic
                                                              .sentNotification());
                                                })
                                            : ProductAddToCartWidget(
                                                productId, _appEvents),
                                      ),
                                    ],
                                  ),
                                ],
                              );
          }),
    );
  }


  Widget buildCustomUserInputField(ProductDetailsModel productDetailsModel) {
    if (productDetailsModel.customFields?.length == 0) {
      return const SizedBox();
    } else {
      return ListView.builder(
          itemCount: productDetailsModel.customFields?.length ?? 0,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return userInputWidget(productDetailsModel.customFields![index]);
          });
    }
  }

  Widget userInputWidget(CustomFields customField) {
    switch (customField.type) {
      case 'TEXT':
        logic.mapTextEditController[customField.id!] = TextEditingController();
        logic.observeTextEdit(logic.mapTextEditController[customField.id!],
            customField.price ?? 0);
        var required = customField.isRequired ?? false ? '*' : '';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CustomText("${customField.label}"),
                const SizedBox(
                  width: 5,
                ),
                CustomText(
                  required,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 5,
                ),
                if (customField.price != null && customField.price != 0.0)
                  CustomText(
                    "السعر ".tr + '( ${customField.formattedPrice})',
                    color: greenColor,
                  )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: logic.mapTextEditController[customField.id!],
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: customField.label ?? '',
                hintText: customField.hint ?? '',
              ),
            ),
          ],
        );
      case 'NUMBER':
        logic.mapTextEditController[customField.id!] = TextEditingController();
        logic.observeTextEdit(logic.mapTextEditController[customField.id!],
            customField.price ?? 0);
        var required = customField.isRequired ?? false ? '*' : '';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CustomText("${customField.label}"),
                const SizedBox(
                  width: 5,
                ),
                CustomText(
                  required,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 5,
                ),
                if (customField.price != null && customField.price != 0.0)
                  CustomText(
                    "السعر ".tr + '( ${customField.formattedPrice})',
                    color: greenColor,
                  )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: logic.mapTextEditController[customField.id!],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: customField.label ?? '',
                hintText: customField.hint ?? '',
              ),
            ),
          ],
        );

      case 'TIME':
        logic.mapTextEditController[customField.id!] = TextEditingController();
        var required = customField.isRequired ?? false ? '*' : '';
        return GetBuilder<ProductDetailsLogic>(
            id: customField.id!,
            builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CustomText("${customField.label}"),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        required,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: logic.mapTextEditController[customField.id!],
                    readOnly: true,
                    onTap: () {
                      FocusScope.of(Get.context!).requestFocus(FocusNode());
                      showTimePicker(
                              context: Get.context!,
                              builder: (BuildContext? context, Widget? child) =>
                                  MediaQuery(
                                    data: MediaQuery.of(context!)
                                        .copyWith(alwaysUse24HourFormat: false),
                                    child: child!,
                                  ),
                              initialTime: TimeOfDay.now())
                          .then(
                        (value) {
                          if (value == null) return;
                          DateTime tempDate = DateFormat("hh:mm").parse(
                              value.hour.toString() +
                                  ":" +
                                  value.minute.toString());
                          var dateFormat = DateFormat("hh:mm a");

                          String day =
                              "${value.hour.toString().padLeft(2, "0")}:${value.minute.toString().padLeft(2, "0")}";
                          logic.mapTextEditController[customField.id!]?.text =
                              day;
                          logic.update([customField.id!]);
                        },
                      );
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: customField.label ?? '',
                        hintText: customField.hint ?? '',
                        suffixIcon: logic.mapTextEditController[customField.id!]
                                    ?.text.isEmpty ==
                                true
                            ? const SizedBox()
                            : InkWell(
                                onTap: () {
                                  logic.mapTextEditController[customField.id!] =
                                      TextEditingController();
                                  logic.update([customField.id!]);
                                },
                                child:
                                    const Icon(Icons.highlight_remove_outlined),
                              )),
                  ),
                ],
              );
            });
      case 'DATE':
        logic.mapTextEditController[customField.id!] = TextEditingController();
        var required = customField.isRequired ?? false ? '*' : '';
        return GetBuilder<ProductDetailsLogic>(
            id: customField.id!,
            builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CustomText("${customField.label}"),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        required,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: logic.mapTextEditController[customField.id!],
                    readOnly: true,
                    onTap: () {
                      FocusScope.of(Get.context!).requestFocus(FocusNode());
                      showDatePicker(
                              context: Get.context!,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100))
                          .then(
                        (value) {
                          if (value == null) return;
                          String date =
                              "${value.year.toString()}-${value.month.toString().padLeft(2, "0")}-${value.day.toString().padLeft(2, "0")}";
                          logic.mapTextEditController[customField.id!]?.text =
                              date;
                          logic.update([customField.id!]);
                        },
                      );
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: customField.label ?? '',
                        hintText: customField.hint ?? '',
                        suffixIcon: logic.mapTextEditController[customField.id!]
                                    ?.text.isEmpty ==
                                true
                            ? const SizedBox()
                            : InkWell(
                                onTap: () {
                                  logic.mapTextEditController[customField.id!] =
                                      TextEditingController();
                                  logic.update([customField.id!]);
                                },
                                child:
                                    const Icon(Icons.highlight_remove_outlined),
                              )),
                  ),
                ],
              );
            });
      case 'DROPDOWN':
        var required = customField.isRequired ?? false ? '*' : '';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CustomText("${customField.name}"),
                const SizedBox(
                  width: 5,
                ),
                CustomText(
                  required,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 5,
                ),
                CustomText(
                  '${customField.hint}',
                  color: greenColor,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.sp)),
              child: Row(
                children: [
                  Expanded(
                    child: GetBuilder<ProductDetailsLogic>(
                        id: customField.id,
                        builder: (logic) {
                          log(logic.mapDropDownChoices.toString());

                          return DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              iconSize: 0,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              itemPadding: EdgeInsets.zero,
                              dropdownPadding: EdgeInsets.zero,
                              itemHeight: 55.h,
                              scrollbarAlwaysShow: true,
                              isExpanded: true,
                              selectedItemBuilder: (con) {
                                return customField.choices?.map((selectedType) {
                                      return Container(
                                          height: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Row(
                                            children: [
                                              CustomText(
                                                  "${selectedType.name}"),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              if (selectedType.price != null &&
                                                  selectedType.price != 0.0)
                                                CustomText(
                                                    '( ${selectedType.formattedPrice})',
                                                    color: greenColor)
                                            ],
                                          ));
                                    }).toList() ??
                                    [];
                              },
                              hint: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        'اختر'.tr,
                                        fontSize: 12,
                                      ),
                                    ],
                                  )),
                              value: logic.mapDropDownChoices[customField.id],
                              items: customField.choices?.map((selectedType) {
                                return DropdownMenuItem(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      children: [
                                        CustomText(selectedType.name),
                                        const SizedBox(width: 5),
                                        if (selectedType.price != null &&
                                            selectedType.price != 0.0)
                                          CustomText(
                                              '( ${selectedType.formattedPrice})',
                                              color: greenColor)
                                      ],
                                    ),
                                  ),
                                  value: selectedType.id,
                                );
                              }).toList(),
                              onChanged: (value) =>
                                  logic.changeDropDownSelected(
                                      customField.id!,
                                      customField.choices
                                              ?.firstWhere((element) =>
                                                  element.id == value)
                                              .price ??
                                          0,
                                      value),
                            ),
                          );
                        }),
                  ),
                  const Icon(Icons.keyboard_arrow_down_outlined),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            )
          ],
        );
      case 'CHECKBOX':
        var required = customField.isRequired ?? false ? '*' : '';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CustomText("${customField.name}"),
                const SizedBox(
                  width: 5,
                ),
                CustomText(
                  required,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 5,
                ),
                CustomText(
                  '${customField.hint}',
                  color: greenColor,
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: GetBuilder<ProductDetailsLogic>(
                  id: customField.id!,
                  builder: (logic) {
                    return Column(
                      children: customField.choices?.map((e) {
                            //  log(logic.mapCheckboxChoices[customOptionFields.id!]![e.id!].toString());
                            return CheckboxListTile(
                              value: logic.mapCheckboxChoices[customField.id!]
                                      ?[e.id!] ??
                                  false,
                              onChanged: (value) {
                                logic.changeCheckboxSelected(customField.id!,
                                    e.id!, e.price ?? 0, value);
                              },
                              title: Row(
                                children: [
                                  CustomText("${e.name}"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (e.price != null && e.price != 0.0)
                                    CustomText(
                                      '( ${e.formattedPrice})',
                                      color: greenColor,
                                    )
                                ],
                              ),
                            );
                          }).toList() ??
                          [],
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );

      case 'IMAGE':
        logic.mapTextEditController[customField.id!] = TextEditingController();
        var required = customField.isRequired ?? false ? '*' : '';
        String? temporaryUrl;
        return GetBuilder<ProductDetailsLogic>(
            init: Get.find<ProductDetailsLogic>(),
            id: customField.id!,
            builder: (logic) {
              return logic.isUploadLoading
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 1,
                      )),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CustomText("${customField.label}"),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              required,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                List<String?>? path = await logic
                                    .uploadFileImage(false, customField.id!);
                                if (path != null) {
                                  if (path.first != null) {
                                    logic.mapTextEditController[customField.id!]
                                        ?.text = path.first!;
                                    temporaryUrl = path[1];
                                  }
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300),
                                child: temporaryUrl != null
                                    ? CustomImage(
                                        url: temporaryUrl,
                                        width: double.infinity,
                                        height: 70,
                                        size: 20,
                                      )
                                    : CustomText(
                                        customField.hint,
                                        color: Colors.grey.shade700,
                                      ),
                              ),
                            ),
                            if (temporaryUrl != null)
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          temporaryUrl = null;
                                          logic.mapTextEditController[
                                                  customField.id!] =
                                              TextEditingController();
                                          logic.update([customField.id!]);
                                        },
                                        icon:
                                            const Icon(Icons.highlight_remove)),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ],
                    );
            });
      case 'FILE':
        logic.mapTextEditController[customField.id!] = TextEditingController();
        var required = customField.isRequired ?? false ? '*' : '';
        String? temporaryUrl;
        return GetBuilder<ProductDetailsLogic>(
            init: Get.find<ProductDetailsLogic>(),
            id: customField.id!,
            builder: (logic) {
              if (logic.isUploadLoading) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 1,
                  )),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CustomText("${customField.label}"),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          required,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            List<String?>? path = await logic.uploadFileImage(
                                true, customField.id!);
                            if (path != null) {
                              if (path.first != null) {
                                logic.mapTextEditController[customField.id!]
                                    ?.text = path.first!;
                                temporaryUrl = path[1];
                              }
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300),
                            child: temporaryUrl != null
                                ? CustomImage(
                                    url: temporaryUrl,
                                    width: double.infinity,
                                    height: 70,
                                    size: 20,
                                  )
                                : CustomText(
                                    customField.hint,
                                    color: Colors.grey.shade700,
                                  ),
                          ),
                        ),
                        if (temporaryUrl != null)
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      temporaryUrl = null;
                                      logic.mapTextEditController[customField
                                          .id!] = TextEditingController();
                                      logic.update([customField.id!]);
                                    },
                                    icon: const Icon(Icons.highlight_remove)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              }
            });

      default:
        return const SizedBox();
    }
  }
}
