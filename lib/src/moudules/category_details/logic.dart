import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/entities/OfferResponseModel.dart';
import 'package:entaj/src/entities/category_model.dart';
import 'package:entaj/src/entities/product_details_model.dart';
import 'package:entaj/src/moudules/_main/logic.dart';
import 'package:entaj/src/moudules/dialog/filter_dialog.dart';
import 'package:entaj/src/moudules/search/view.dart';
import 'package:entaj/src/utils/error_handler/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetailsLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  bool hasInternet = true;
  bool isCategoryLoading = false;
  bool isProductsLoading = false;
  bool isUnderLoading = false;
  bool filter = false;
  CategoryModel? categoryModel;
  List<String> categoryIds = [];
  String? filterUrl;
  String? next;
  int mPage = 1;
  List<String> sortList = [
    'Newest'.tr,
    'Most Popular'.tr,
    'Low to High'.tr,
    'High to Low'.tr
  ];
  String? selectedSort;
  List<ProductDetailsModel> productsList = [];
  TextEditingController startPriceController = TextEditingController();
  TextEditingController endPriceController = TextEditingController();
  RangeValues rangeValues = const RangeValues(0, 1);

  @override
  void onInit() {
    super.onInit();

  }


  void openFilterDialog() {
    Get.dialog(const FilterDialog());
  }

  void goToSearch() {
    Get.to(SearchPage());
  }

  changeRange(RangeValues value) {
    rangeValues = value;
    update(['dialog']);
  }

/*
  String startPriceValue() {
    return (rangeValues.start * endPrice).toInt().toString();
  }

  String endPriceValue() {
    return (rangeValues.end * endPrice).toInt().toString();
  }
*/

  getCategoryDetails(String categoryId) async {
    categoryModel = null;
    isCategoryLoading = true;
    update([categoryIds]);
    try {
      var response = await _apiRequests.getCategoryDetails(categoryId);
      categoryModel = CategoryModel.fromJson(response.data['payload']);
    } catch (e) {
      //  ErrorHandler.handleError(e);
    }
    isCategoryLoading = false;
    update([categoryIds]);
  }

  getProductsList({int page = 1 ,required bool forPagination}) async {
    // productsList = [];
    hasInternet = true;
    if (productsList.isEmpty) isProductsLoading = true;
    if (forPagination && productsList.isNotEmpty) isUnderLoading = true;
    try {
      update([categoryIds, 'products']);
    }catch(e){}
    try {
      var response = await _apiRequests.getProductsList(
          categoryList: categoryIds,
          page: page,
          sale_price__isnull: filterUrl?.contains('sales'),
          ordering: getOrdering(),
          listingPriceGte: filter ? startPriceController.text : null,
          listingPriceLte: filter ? endPriceController.text : null);
      var newList = (response.data['results'] as List)
          .map((element) => ProductDetailsModel.fromJson(element))
          .toList();
      productsList.addAll(newList);

      List<String> productsIds = [];
      productsList.forEach((element) {
        if (element.id != null) {
          productsIds.add(element.id!);
        }
      });
      next = response.data['next'];

      var res = await _apiRequests.getSimpleBundleOffer(productsIds);
      List<OfferResponseModel> offerList = (res.data['payload'] as List)
          .map((e) => OfferResponseModel.fromJson(e))
          .toList();

      productsList.forEach((elementProduct) {
        offerList.forEach((elementOffer) {
          if(elementOffer.productIds?.contains(elementProduct.id) == true){
            elementProduct.offerLabel = elementOffer.name;
          }
        });
      });

/*
      productsList.forEach((element) {
        if (element.price > endPrice) {
          endPrice = element.price;
        }
        if (element.price < startPrice) {
          startPrice = element.price;
        }
      });*/
    } catch (e) {
      hasInternet = await ErrorHandler.handleError(e);
    }
    isProductsLoading = false;
    isUnderLoading = false;
    update([categoryIds ,'products']);
  }

  String? getOrdering() {
    if (selectedSort == sortList[0]) {
      return 'created_at';
    }
    if (selectedSort == sortList[1]) {
      return 'popularity_order';
    }
    if (selectedSort == sortList[2]) {
      return 'price';
    }
    if (selectedSort == sortList[3]) {
      return '-price';
    }
    return null;
  }

  void onSortChanged(String? value) {
    selectedSort = value;
    clearAndFetch();
    update(['sort']);
  }

  restPrice() {
    filter = false;
    rangeValues = const RangeValues(0, 1);
    clearAndFetch();
    update(['dialog']);
  }

  filterPrices() {
    filter = true;
    clearAndFetch();
    Get.back();
  }

  int getBackCount(String categoryId) {
    int backCount = 1;
    final MainLogic mainLogic = Get.find<MainLogic>();
    var categories = mainLogic.categoriesList;

    categories.forEach((element) {
      if (element.ids.contains(categoryId)) {
        int index = element.ids.indexOf(categoryId);
        int realIndex = element.ids.length - index;
        backCount = realIndex;
      }
    });
    return backCount;
  }

  Future<void> clearAndFetch() async {
    productsList = [];
    next = null;
    mPage = 1;
    await getProductsList(forPagination: false);
  }
}
