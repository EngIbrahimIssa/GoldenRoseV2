import '../../data/remote/api_requests.dart';
import '../../entities/product_details_model.dart';
import '../../services/app_events.dart';
import '../../utils/error_handler/error_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../entities/offer_response_model.dart';
import '../../utils/functions.dart';

class SearchLogic extends GetxController with WidgetsBindingObserver {
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
      //log(searchController.text.length.toString());
      mPage = 1;

      getProductsList(q :searchController.text ,page:mPage,forPagination: false);
    });
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    switch(state){

      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        FocusScopeNode currentFocus = FocusScope.of(Get.context!);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
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
      if(forPagination){
        productsList.addAll(newList);
      }else{
        productsList = newList;
      }

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
