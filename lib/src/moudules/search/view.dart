import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:entaj/src/colors.dart';
import 'package:entaj/src/images.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:entaj/src/utils/item_widget/item_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SearchPage extends StatelessWidget {
  final SearchLogic logic = Get.put(SearchLogic());
  late ScrollController scrollController;

  Timer? _timer;

  void _reviewsScrollListener() async {
    try {
      var scrollable = Platform.isAndroid
          ? !scrollController.position.outOfRange
          : scrollController.position.outOfRange;
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          scrollable &&
          logic.isUnderLoading == false) {
        if (logic.next != null) {
          logic.isUnderLoading = true;
            ++logic.mPage;
            logic.getProductsList( q:logic.lastValue , page: logic.mPage, forPagination: true);
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    scrollController = ScrollController();
    scrollController.addListener(_reviewsScrollListener);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: CustomText(
            "البحث".tr,
            fontSize: 16,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Image.asset(iconLogo),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            logic.mPage = 1;
            return logic.getProductsList(
                q: logic.lastValue, page: logic.mPage, forPagination: false);
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20.sp)),
                  child: TextField(
                    controller: logic.searchController,
                    textInputAction: TextInputAction.search,
                    //  onChanged: logic.onChangeSearchField,
                    onSubmitted: (val) {
                      logic.mPage = 1;
                      logic.getProductsList(
                          q: val, page: logic.mPage, forPagination: false);
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ابحث هنا'.tr,
                        suffixIcon: GestureDetector(
                            onTap: () => logic.searchController.text = '',
                            child: const Icon(
                              Icons.highlight_remove_outlined,
                              color: primaryColor,
                            )),
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.asset(
                                iconSearch,
                                scale: 2,
                              )),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GetBuilder<SearchLogic>(
                      id: "products",
                      builder: (context) {
                        return logic.isProductsLoading
                            ? const Center(child: CircularProgressIndicator())
                            : logic.productsList.isNotEmpty
                                ? SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        GridView.builder(
                                          itemCount: logic.productsList.length,
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                  childAspectRatio: 0.65),
                                          itemBuilder: (context, index) =>
                                              ItemProduct(
                                            logic.productsList[index],
                                            index,
                                            horizontal: false,
                                            forWishlist: false,
                                          ),
                                        ),
                                        if (logic.isUnderLoading)
                                          Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child:
                                                const CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 50, right: 50, bottom: 100),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                          size: 80.sp,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CustomText(
                                          "لم نعثر على نتائج بحث".tr,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  );
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
