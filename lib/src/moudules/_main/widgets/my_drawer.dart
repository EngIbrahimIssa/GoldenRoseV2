import 'dart:developer';

import 'package:entaj/src/entities/category_model.dart';
import 'package:entaj/src/moudules/category_details/view.dart';
import 'package:entaj/src/utils/custom_widget/custom_image.dart';
import 'package:entaj/src/utils/custom_widget/custom_sized_box.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../main.dart';
import '../../../colors.dart';
import '../../../images.dart';
import '../logic.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final MainLogic _mainLogic = Get.find();

  @override
  void initState() {
    _mainLogic.checkInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: GetBuilder<MainLogic>(
            init: Get.find<MainLogic>(),
            builder: (logic) {
              log(logic.hasInternet.toString());
              return (!logic.hasInternet && logic.categoriesList.isEmpty)
                  ? Center(
                child: CustomText('يرجى التأكد من اتصالك بالإنترنت'.tr),
              )
                  : Padding(
                padding: EdgeInsets.fromLTRB(0, 50.h, 0, 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: CustomText(
                        "القائمة".tr,
                        color: greenLightColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: GetBuilder<MainLogic>(
                          init: Get.find<MainLogic>(),
                          id: 'categoriesMenu',
                          builder: (logic) {
                            return logic.isCategoriesLoading
                                ? const Center(
                                child: CircularProgressIndicator())
                                : logic.categoriesList.isEmpty
                                ? const SizedBox()
                                : ListView.builder(
                              itemCount:
                              logic.categoriesList.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (BuildContext
                              context,
                                  int index) =>
                                  buildCategoryListTile(logic
                                      .categoriesList[index]),
                            );
                          }),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 2,
                    ),
                    InkWell(
                      onTap: () => logic.goToDeliveryOptions(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                CustomText("خيارات الشحن".tr,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                    14), /*
                              CustomText(
                                "السعودية",
                                fontWeight: FontWeight.bold,
                                color: greenColor,
                              ),*/
                              ],
                            ),
                            const Spacer(),
                            RotationTransition(
                                turns: AlwaysStoppedAnimation(
                                    (isArabicLanguage ? 180 : 0) / 360),
                                child: Image.asset(iconBack, scale: 2)),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 2,
                    ),
                    const CustomSizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12.0),
                      child: CustomText(
                        "طرق الدفع".tr,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 40.h,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ListView.builder(
                            itemCount: logic.settingModel?.footer
                                ?.paymentMethods?.length ??
                                0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              height: 40.h,
                              width: 40.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5),
                              child: CustomImage(
                                  url: logic.settingModel?.footer
                                      ?.paymentMethods?[index].icon,
                                  fit: BoxFit.contain,
                                  size: 10),
                            ))),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (logic.settingModel?.settings?.vatSettings
                              ?.taxRegistrationCertificate !=
                              null)
                            InkWell(
                              onTap: () => Get.to(Scaffold(
                                backgroundColor: Colors.white,
                                appBar: AppBar(),
                                body: CustomImage(
                                  width: double.infinity,
                                  height: double.infinity,
                                  url: logic
                                      .settingModel
                                      ?.settings
                                      ?.vatSettings
                                      ?.taxRegistrationCertificate,
                                ),
                              )),
                              child: Image.asset(
                                imageTax,
                                scale: 2,
                              ),
                            ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (logic
                                    .settingModel
                                    ?.settings
                                    ?.vatSettings
                                    ?.taxRegistrationCertificate !=
                                    null) {
                                  Get.to(Scaffold(
                                    backgroundColor: Colors.white,
                                    appBar: AppBar(),
                                    body: CustomImage(
                                      width: double.infinity,
                                      height: double.infinity,
                                      url: logic
                                          .settingModel
                                          ?.settings
                                          ?.vatSettings
                                          ?.taxRegistrationCertificate,
                                    ),
                                  ));
                                }
                              },
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                    "الرقم الضريبي".tr,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                  CustomText(
                                    logic.settingModel?.settings
                                        ?.vatSettings?.vatNumber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (logic.settingModel?.footer?.socialMedia
                              ?.items?.maroof !=
                              null &&
                              logic.settingModel?.footer?.socialMedia
                                  ?.items?.maroof !=
                                  '')
                            InkWell(
                              onTap: () => logic.goToMaroof(),
                              child: Image.asset(
                                iconMaroof,
                                width: 60.w,
                              ),
                            ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  ExpansionTile buildCategoryListTile(CategoryModel category) {
    return ExpansionTile(
      title: GestureDetector(
        onTap: () {
          Get.toNamed("/category-details/${category.id}");
        },
        child: CustomText(
          category.name,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: category.subCategories?.isEmpty == true ? const SizedBox() : null,
      children: category.subCategories
          ?.map((e) => Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(child: buildCategoryListTile(e)),
        ],
      ))
          .toList() ??
          [],
      onExpansionChanged: (top) {},
    );
  }
}
