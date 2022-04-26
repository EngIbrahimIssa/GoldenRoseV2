import 'dart:developer';
import 'dart:io';

import '../../app_config.dart';
import '../../utils/item_widget/item_category.dart';
import '../no_Internet_connection_screen.dart';
import '../../utils/custom_widget/custom_sized_box.dart';
import '../../utils/custom_widget/custom_text.dart';
import '../../utils/item_widget/item_home_category.dart';
import '../../utils/item_widget/item_product.dart';
import '../_main/widgets/my_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../images.dart';
import 'logic.dart';

class CategoryDetailsPage extends StatefulWidget {
  const CategoryDetailsPage({Key? key}) : super(key: key);

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  late ScrollController scrollController;
  late CategoryDetailsLogic logic;

  late String categoryId;

  @override
  void initState() {
    categoryId = Get.parameters['categoryId'] ?? '';
    super.initState();
  }

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
          logic.getProductsList(page: ++logic.mPage, forPagination: true);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    logic = Get.put(CategoryDetailsLogic());
    scrollController = ScrollController();
    logic.startPriceController.text = '';
    logic.endPriceController.text = '';
    logic.filter = false;
    logic.categoryId = categoryId;
    if (categoryId == 'arguments') {
      var argument = Get.arguments as Map;
      logic.filterUrl = argument['filter'];
    } else {
      logic.getCategoryDetails(categoryId);
    }
    logic.clearAndFetch();
    scrollController.addListener(_reviewsScrollListener);
    return GetBuilder<CategoryDetailsLogic>(
        id: categoryId,
        autoRemove: false,
        builder: (logic) {
          return Scaffold(
            bottomNavigationBar:
                MyBottomNavigation(backCount: logic.getBackCount(categoryId)),
            appBar: AppBar(
              actions: [
                InkWell(
                    onTap: () => logic.goToSearch(),
                    child: Image.asset(
                      iconSearch,
                      scale: 2,
                    )),
              ],
              title: CustomText(
                logic.categoryModel?.name,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.grey.shade50,
            body: !logic.hasInternet
                ? const NoInternetConnectionScreen()
                : RefreshIndicator(
                    onRefresh: () => logic.clearAndFetch(),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.w, 10, 10.w, 0),
                      child: logic.isCategoryLoading && logic.isProductsLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                children: [
                                  buildCategories(logic),
                                //  if (logic.productsList.isNotEmpty)
                                    buildFilter(logic),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if ((AppConfig.showSubCategoriesAsGrid &&
                                          logic.productsList.isNotEmpty) ||
                                      (!AppConfig.showSubCategoriesAsGrid))
                                    buildProducts(),
                                ],
                              ),
                            ),
                    ),
                  ),
          );
        });
  }

  GetBuilder<CategoryDetailsLogic> buildProducts() {
    return GetBuilder<CategoryDetailsLogic>(
        id: categoryId,
        builder: (logic) {
          return Column(
            children: [
              logic.isProductsLoading
                  ? const Center(child: CircularProgressIndicator())
                  : logic.productsList.isEmpty
                      ? SizedBox(
                          height: 500.h,
                          child: Center(
                            child:
                                CustomText('نعتذر، لا يوجد منتجات حالياً'.tr),
                          ),
                        )
                      : GridView.builder(
                          itemCount: logic.productsList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 0.65),
                          itemBuilder: (context, index) => ItemProduct(
                            logic.productsList[index],
                            index,
                            horizontal: false,
                            forWishlist: false,
                          ),
                        ),
              if (logic.isUnderLoading)
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
            ],
          );
        });
  }

  Row buildFilter(CategoryDetailsLogic logic) {
    return Row(
      children: [
        Expanded(
            child: InkWell(
          onTap: () => logic.openFilterDialog(),
          child: Container(
            height: 44.h,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15.sp)),
            child: Row(
              children: [
                CustomText(
                  "السعر".tr,
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down)
              ],
            ),
          ),
        )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Container(
          height: 44.h,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15.sp)),
          child: Row(
            children: [
              Image.asset(
                iconFilter,
                scale: 2,
              ),
              Expanded(
                child: GetBuilder<CategoryDetailsLogic>(
                    id: 'sort',
                    builder: (logic) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          onChanged: logic.onSortChanged,
                          value: logic.selectedSort,
                          hint: SizedBox(
                            child: Row(
                              children: [
                                const CustomSizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  logic.sortList.first,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                          items: logic.sortList
                              .map((e) => DropdownMenuItem(
                                    child: SizedBox(
                                      child: Row(
                                        children: [
                                          const CustomSizedBox(
                                            width: 5,
                                          ),
                                          CustomText(
                                            e,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                        ),
                      );
                    }),
              ),
            ],
          ),
        )),
      ],
    );
  }

  buildCategories(CategoryDetailsLogic logic) {
    return GetBuilder<CategoryDetailsLogic>(
        id: categoryId,
        autoRemove: false,
        // init: Get.find<CategoryDetailsLogic>(),
        builder: (context) {
          return logic.isProductsLoading
              ? const SizedBox()
              : (logic.subCategories.isNotEmpty)
                  ? (AppConfig.showSubCategoriesAsGrid &&
                          logic.productsList.isEmpty)
                      ? GridView.builder(
                          itemCount: logic.subCategories.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) =>
                              ItemCategory(logic.subCategories[index], 100))
                      : SizedBox(
                          height: logic.subCategories.isEmpty
                              ? 0
                              : AppConfig.showSubCategoriesAsGrid
                                  ? 170.h
                                  : 58.h,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: logic.subCategories.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return AppConfig.showSubCategoriesAsGrid
                                          ? ItemCategory(
                                              logic.subCategories[index], 120)
                                          : ItemHomeCategory(
                                              logic.subCategories[index]);
                                    }),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        )
                  : const SizedBox();
        });
  }
}
