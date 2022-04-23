import 'package:entaj/src/images.dart';
import 'package:entaj/src/moudules/_main/logic.dart';
import 'package:entaj/src/utils/item_widget/item_category.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../colors.dart';
import '../../../../services/app_events.dart';
import '../../../../utils/custom_widget/custom_text.dart';
import 'logic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesPage extends StatelessWidget {
  final CategoriesLogic logic = Get.put(CategoriesLogic());
  final AppEvents _appEvents = Get.find();

  @override
  Widget build(BuildContext context) {
    _appEvents.logScreenOpenEvent('CategoriesTab');

    return GetBuilder<MainLogic>(
        init: Get.find<MainLogic>(),
        builder: (logic) {
          return RefreshIndicator(
            onRefresh: () async => await logic.getCategories(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child: GetBuilder<MainLogic>(
                          id: 'categories2',
                          init: Get.find<MainLogic>(),
                          builder: (logic) {
                            return logic.isCategoriesLoading
                                ? Shimmer.fromColors(
                                    baseColor: baseColor,
                                    highlightColor: highlightColor,
                                    child: GridView.builder(
                                        itemCount: 20,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 15,
                                                mainAxisSpacing: 15,
                                                childAspectRatio: 1),
                                        itemBuilder: (context, index) =>
                                            const ItemCategory(null)),
                                  )
                                : logic.categoriesList.isEmpty
                                    ? Container(
                                        width: double.infinity,
                                        height: 600.h,
                                        padding: const EdgeInsets.only(
                                            left: 50, right: 50),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            logic.hasInternet
                                                ? Image.asset(
                                                    iconCategories,
                                                  )
                                                : const Icon(
                                                    Icons.wifi_off,
                                                    color: Colors.grey,
                                                    size: 60,
                                                  ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            CustomText(
                                              logic.hasInternet
                                                  ? "نعتذر، لا يوجد تصنيفات حاليا"
                                                      .tr
                                                  : 'يرجى التأكد من اتصالك بالإنترنت'
                                                      .tr,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      )
                                    : GridView.builder(
                                        itemCount: logic.categoriesList.length,
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 15,
                                                mainAxisSpacing: 15,
                                                childAspectRatio: 1),
                                        itemBuilder: (context, index) =>
                                            ItemCategory(
                                                logic.categoriesList[index]));
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
