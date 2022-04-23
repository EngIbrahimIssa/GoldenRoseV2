import 'dart:developer';

import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/entities/product_details_model.dart';
import 'package:entaj/src/services/app_events.dart';
import 'package:entaj/src/utils/error_handler/error_handler.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../entities/OfferResponseModel.dart';
import '../../utils/functions.dart';

class SearchLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final AppEvents _appEvents = Get.find();
  final TextEditingController searchController = TextEditingController();
  List<ProductDetailsModel> productsList = [];
  bool isProductsLoading = false;
  bool isUnderLoading = false;
  String? lastValue;
  String? next;
  int mPage = 1;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      mPage = 1;
      getProductsList(q :searchController.text ,page:mPage,forPagination: false);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> getProductsList({String? q,required int page,required bool forPagination}) async {
    if(lastValue == q && !forPagination) return;
    if (forPagination) isUnderLoading = true;
    lastValue = q;
    if(!forPagination) productsList = [];
    if (q?.isEmpty == true) {
      try{
        if(!forPagination) update(['products']);
      return;
      }catch(e){}
    }

    if(!await checkInternet()) return;

    _appEvents.logSearchEvent(q ?? '');
    if (productsList.isEmpty) isProductsLoading = true;
    try{
      update(['products']);

    }catch(e){}
    try {
      var response = await _apiRequests.getProductsList(
        q: lastValue,
        page: page
      );
      next = response.data['next'];

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
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isUnderLoading = false;
    isProductsLoading = false;
    update(['products']);
  }
}
