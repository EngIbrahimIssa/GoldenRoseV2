import '../../data/remote/api_requests.dart';
import '../../entities/offer_response_model.dart';
import '../../entities/category_model.dart';
import '../../entities/product_details_model.dart';
import '../_main/logic.dart';
import '../dialog/filter_dialog.dart';
import '../search/view.dart';
import '../../utils/error_handler/error_handler.dart';
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
  String categoryId = '';
  String? filterUrl;
  String? next;
  int mPage = 1;
  List<String> sortList = [
    'Default'.tr,
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
  List<CategoryModel> subCategories = [];

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
    update([categoryId]);
    try {
      var response = await _apiRequests.getCategoryDetails(categoryId);
      categoryModel = CategoryModel.fromJson(response.data['payload']);
      subCategories = categoryModel?.subCategories ?? [];
    } catch (e) {
      //  ErrorHandler.handleError(e);
    }
    isCategoryLoading = false;
    update([categoryId]);
  }

  getProductsList({int page = 1, required bool forPagination}) async {
    // productsList = [];
    hasInternet = true;
    if (productsList.isEmpty) isProductsLoading = true;
    if (forPagination && productsList.isNotEmpty) isUnderLoading = true;
    try {
      update([categoryId, 'products']);
    } catch (e) {}
    try {
      var response = await _apiRequests.getProductsList(
          categoryList: filterUrl != null ? null : [categoryId],
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
          if (elementOffer.productIds?.contains(elementProduct.id) == true) {
            elementProduct.offerLabel = elementOffer.name;
          }
        });
      });
    } catch (e) {
      hasInternet = await ErrorHandler.handleError(e);
    }
    isProductsLoading = false;
    isUnderLoading = false;
    update([categoryId, 'products']);
  }

  String? getOrdering() {
    if (selectedSort == sortList[0]) {
      return null;
    }
    if (selectedSort == sortList[1]) {
      return 'created_at';
    }
    if (selectedSort == sortList[2]) {
      return 'popularity_order';
    }
    if (selectedSort == sortList[3]) {
      return 'price';
    }
    if (selectedSort == sortList[4]) {
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
    startPriceController.text = '';
    endPriceController.text = '';
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
