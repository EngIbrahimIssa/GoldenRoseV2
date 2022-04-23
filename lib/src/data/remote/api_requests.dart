import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:entaj/src/app_config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart' as ge;
import 'package:image_picker/image_picker.dart';

import '../../../main.dart';
import '../../.env.dart';
import '../hive/wishlist/hive_controller.dart';
import '../shared_preferences/pref_manger.dart';

class ApiRequests extends ge.GetxController {
  final PrefManger _prefManger = ge.Get.find();
  late Dio _dioV2;
  late Dio _dioV1;

  @override
  Future<void> onInit() async {
    log("INIT ==> ApiRequests");
    String session = await _prefManger.getSession();
    String authorizationToken = AUTHORIZATION_TOKEN;
    String accessToken = X_MANGER_TOKEN;
    String customerToken = await _prefManger.getToken();
    bool isFromRemote = await _prefManger.getIsFromRemote();

    log('session => $session');
    if (isFromRemote) {
      accessToken = await _prefManger.getAccessToken();
      authorizationToken = await _prefManger.getAuthorizationToken();
      if (accessToken == '') {
        await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 1),
        ));
        await remoteConfig.ensureInitialized();
        try {
          await remoteConfig.fetchAndActivate();
        } catch (e) {}
        accessToken = remoteConfig.getString('ACCESS_TOKEN');
        await _prefManger.setAccessToken(accessToken);
      }
      if (authorizationToken == '') {
        authorizationToken = remoteConfig.getString('AUTHORIZATION_TOKEN');
        await _prefManger.setAuthorizationToken(authorizationToken);
      }

      await _prefManger.setIsFromRemote(true);
    }

    _dioV2 = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 8000,
        headers: {
          'store-id': storeId,
          'Currency': currency,
          'source': 'mobile_app',
          'ROLE': 'Manager',
          'Accept': accept,
          'X-CUSTOMER-TOKEN': customerToken,
          'x-manager-token': accessToken,
          'CART-SESSION-ID': session,
          'currency': HiveController.generalBox.get('currency'),
          'Accept-Language': isArabicLanguage ? 'ar' : 'en',
          'Authorization': 'Bearer $authorizationToken',
          'hide-header-footer': true
        }));

    _dioV1 = Dio(BaseOptions(
        baseUrl: baseUrlV1,
        connectTimeout: 10000,
        receiveTimeout: 8000,
        headers: {
          'store-id': storeId,
          'Currency': currency,
          'Accept': accept,
          'source': 'mobile_app',
          'ROLE': 'CUSTOMER',
          'currency': HiveController.generalBox.get('currency'),
          'X-CUSTOMER-TOKEN': customerToken,
          'x-manager-token': accessToken,
          'CART-SESSION-ID': session,
          'Accept-Language': isArabicLanguage ? 'ar' : 'en',
          'Authorization': 'Bearer $authorizationToken',
          'hide-header-footer': true
        }));
    super.onInit();
  }

  ///---------------------- Catalog -- Store ----------------------///

  Future<Response> getCategories() async {
    return await _dioV2.get("catalog/stores/$storeId/categories");
  }

  Future<Response> getCategoryDetails(String? categoryId) async {
    return await _dioV2.get("catalog/stores/$storeId/categories/$categoryId");
  }

  Future<Response> getHomeScreen() async {
    return await _dioV2.get("catalog/stores/$storeId/landing-page");
  }

  Future<Response> getHomeScreenOldTheme() async {
    return await _dioV2.get(
        "catalog/stores/$storeId/storefront-themes/$themeId/files/layout?template=home.twig");
  }

  Future<Response> getStoreSetting() async {
    return await _dioV2.get("catalog/stores/$storeId/layout-setting");
  }

  Future<Response> getShippingMethods() async {
    await onInit();
    return await _dioV2.get("catalog/stores/$storeId/shipping-methods");
  }

  Future<Response> getPrivacyPolicy() async {
    return await _dioV2.get("catalog/stores/$storeId/privacy-policy");
  }

  Future<Response> getRefundPolicy() async {
    return await _dioV2.get("catalog/stores/$storeId/refund-exchange-policy");
  }

  Future<Response> getTermsAndConditions() async {
    return await _dioV2.get("catalog/stores/$storeId/terms-conditions");
  }

  ///---------------------- Catalog -- Pages ----------------------///
  Future<Response> getPages() async {
    return await _dioV2.get("catalog/stores/$storeId/pages");
  }

  Future<Response> getPagesDetails({int? pageId}) async {
    return await _dioV2.get("catalog/stores/$storeId/pages/$pageId");
  }

  ///---------------------- Catalog -- Customer ----------------------///
  /// Auth
  Future<Response> register(
      String countryCode, String mobileNumber, String name, String email,
      {required bool isEmail}) async {
    return await _dioV2.post(
        "catalog/customers/register${isEmail ? '-email' : ''}",
        data: FormData.fromMap({
          'name': name,
          'email': email,
          'country_code': countryCode,
          'mobile_number': mobileNumber,
        }));
  }

  Future<Response> login(String countryCode, String mobileNumber,
      {required bool isEmail}) async {
    return await _dioV2.post(
        "catalog/customers/login${isEmail ? '/email' : ''}",
        data: FormData.fromMap(isEmail
            ? {'email': mobileNumber}
            : {
                'country_code': countryCode,
                'mobile_number': mobileNumber,
              }));
  }

  Future<Response> confirmAccount(String code, String mobileNumber,
      {required bool isEmail}) async {
    return await _dioV2.post(
        "catalog/customers/login/verify${isEmail ? '-email' : ''}",
        data: FormData.fromMap({
          'code': code,
          if (isEmail) 'email': mobileNumber,
          if (!isEmail) 'mobile_number': mobileNumber,
        }));
  }

  ///Profile
  Future<Response> getAccountDetails() async {
    await onInit();
    return await _dioV2.get("catalog/customers/profile");
  }

  Future<Response> editAccountDetails(String name, String email) async {
    return await _dioV2.post("catalog/customers/profile",
        data: FormData.fromMap({
          'name': name,
          'email': email,
          '_method': 'put',
        }));
  }

  /// Orders
  Future<Response> getOrders() async {
    return await _dioV2.get("catalog/customers/store/$storeId/orders");
  }

  Future<Response> getOrdersDetails(String orderCode) async {
    log("ORDER ID => $orderCode");
    return await _dioV2
        .get("catalog/stores/$storeId/orders/$orderCode/invoice");
  }

  ///---------------------- Catalog -- Cart ----------------------///
  Future<Response> createSession() async {
    return await _dioV2.post("catalog/stores/$storeId/carts");
  }

  Future<Response> getCart() async {
    onInit();
    return await _dioV2.get("catalog/stores/$storeId/carts");
  }

  Future<Response> cloneCart() async {
    return await _dioV2.post("catalog/stores/$storeId/carts/clone");
  }

  Future<Response> verifyCart() async {
    return await _dioV2.post("catalog/stores/$storeId/carts/verify");
  }

  Future<Response> getDiscountRules() async {
    return await _dioV2.get("catalog/stores/$storeId/discount-rules");
  }

  Future<Response> addCartItem({
    required String productId,
    required String quantity,
    required bool hasFields,
    List? customFieldsList,
  }) async {
    var requestBody = {
      "id": productId,
      "quantity": quantity,
      if (hasFields) "custom_fields": customFieldsList
    };
    log(json.encode(requestBody));
    return await _dioV2.post("catalog/stores/$storeId/carts/products",
        data: requestBody);
  }

  Future<Response> updateCartItem(String id, String quantity) async {
    var requestBody = {
      "id": id,
      "quantity": quantity,
    };
    log(requestBody.toString());
    return await _dioV2.put("catalog/stores/$storeId/carts/products",
        data: requestBody);
  }

  Future<Response> deleteCartItem(int key) async {
    return await _dioV2.post("catalog/stores/$storeId/carts/products",
        data: FormData.fromMap({
          'id': key,
          '_method': 'delete',
        }));
  }

  Future<Response> uploadFileImage(
      {required File file, required bool isFile}) async {
    return await _dioV2.post(
        "catalog/stores/$storeId/carts/products/input-fields/${isFile ? 'file' : 'image'}",
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(file.path),
        }));
  }

  ///Coupons
  Future<Response> redeemCoupon(String coupon) async {
    return await _dioV2.post("catalog/stores/$storeId/carts/coupons",
        data: FormData.fromMap({
          'coupon': coupon,
        }));
  }

  Future<Response> removeCoupon() async {
    return await _dioV2.delete("catalog/stores/$storeId/carts/coupons");
  }

  ///---------------------- Catalog -- Reviews ----------------------///
  Future<Response> getProductReviews(
      {String? productId, int page = 1, int pageSize = 10}) async {
    var queryParameters = {'page': page, 'page_size': pageSize};
    return await _dioV2.get(
        "catalog/stores/$storeId/reviews/products/$productId",
        queryParameters: queryParameters);
  }

  Future<Response> getCustomerProductReviews(String? productId) async {
    return await _dioV2
        .get("catalog/customers/stores/$storeId/reviews/products/$productId");
  }

  ///---------------------- Catalog -- Bank ----------------------///
  Future<Response> getStoreBanks() async {
    return await _dioV2.get("catalog/stores/$storeId/banks");
  }

  Future<Response> uploadTransfer(
      {String? orderCode,
      XFile? image,
      String? storeBankId,
      String? senderName}) async {
    String session = await _prefManger.getSession();
    String authorizationToken = AUTHORIZATION_TOKEN;
    String accessToken = X_MANGER_TOKEN;
    String customerToken = await _prefManger.getToken();
    bool isFromRemote = await _prefManger.getIsFromRemote();

    if (isFromRemote) {
      accessToken = await _prefManger.getAccessToken();
      authorizationToken = await _prefManger.getAuthorizationToken();
      if (accessToken == '') {
        await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 1),
        ));
        await remoteConfig.ensureInitialized();
        try {
          await remoteConfig.fetchAndActivate();
        } catch (e) {}
        accessToken = remoteConfig.getString('ACCESS_TOKEN');
        await _prefManger.setAccessToken(accessToken);
      }
      if (authorizationToken == '') {
        authorizationToken = remoteConfig.getString('AUTHORIZATION_TOKEN');
        await _prefManger.setAuthorizationToken(authorizationToken);
      }

      await _prefManger.setIsFromRemote(true);
    }

    return await Dio(BaseOptions(baseUrl: baseUrl, headers: {
      'store-id': storeId,
      'Currency': currency,
      'ROLE': 'Manager',
      'Accept': accept,
      'currency': HiveController.generalBox.get('currency'),
      'Content-Type': 'multipart/form-data',
      'X-CUSTOMER-TOKEN': customerToken,
      'x-manager-token': accessToken,
      'CART-SESSION-ID': session,
      'Accept-Language': isArabicLanguage ? 'ar' : 'en',
      'Authorization': 'Bearer $authorizationToken'
    })).post("catalog/stores/$storeId/orders/$orderCode/bank-transaction/slip",
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(image?.path ?? ''),
          'store_bank_id': storeBankId,
          'sender_name': senderName
        }));
  }

  Future<Response> addProductReviews(
      {required String productId,
      String? comment,
      required double? rating,
      required int isAnonymous}) async {
    return await _dioV2.post(
        "catalog/customers/stores/$storeId/reviews/products/$productId",
        data: FormData.fromMap({
          'comment': comment,
          'rating': rating != null ? rating.toInt() : rating,
          'is_anonymous': isAnonymous,
        }));
  }

  ///-----------------
  ///----- Catalog -- Reviews ----------------------///
  Future<Response> generateCheckoutToken() async {
    String session = await _prefManger.getSession();
    String customerToken = await _prefManger.getToken();

    log(session);
    log(customerToken);
    return await _dioV2.post("catalog/checkout/$storeId/generate-token",
        data: FormData.fromMap({
          'cart_session': session,
          'x_customer_token': customerToken,
          'store_id': storeId,
        }));
  }

  ///---------------------- products ----------------------///
  Future<Response> getProductDetails(String? productId) async {
    log("PRODUCT ID ==> $productId");
    return await _dioV1.get("products/$productId");
  }

  Future<Response> getSimpleBundleOffer(List<String> productIds) async {
    int index = 0;
    Map<String , dynamic> formData = {};
    productIds.forEach((element) {
      formData['product_ids[$index]'] = element;
      index++;
    });
    return await _dioV2.post(
        "catalog/stores/$storeId/products/simple-bundle-offer",
        data: FormData.fromMap(formData));
  }

  Future<Response> getProductsList({
    List<String?>? categoryList,
    String? q,
    int? page = 1,
    int? pageSize = 14,
    String? listingPriceGte,
    String? listingPriceLte,
    String? ordering,
    bool? sale_price__isnull,
  }) async {
    log("CATEGORY ID ==> $categoryList");
    log("QUARRY ID ==> $q");
    log("listingPriceGte VALUE ==> $listingPriceGte");
    log("listingPriceLte VALUE ==> $listingPriceLte");
    log("ordering VALUE ==> $ordering");
    log("sale_price__isnull VALUE ==> $sale_price__isnull");

    var queryParameters = {
      if (categoryList != null && categoryList.isNotEmpty)
        'categories': categoryList.toString(),
      if (q != null) 'q': [q],
      if (listingPriceGte != null) 'listing_price__gte': listingPriceGte,
      if (listingPriceLte != null) 'listing_price__lte': listingPriceLte,
      if (ordering != null) 'ordering': ordering,
      if (sale_price__isnull != null) 'sale_price__isnull': !sale_price__isnull,
      'page': page,
      'page_size': pageSize
    };

    log(queryParameters.toString());
    var request =
        await _dioV1.get("products", queryParameters: queryParameters);
    log(request.realUri.toString());
    return request;
  }

  Future<Response> notifyMeProduct(String? productId, String? email) async {
    return await _dioV1.post("products/$productId/notifications/",
        data: FormData.fromMap({
          'email': email,
          'language': isArabicLanguage ? 'ar' : 'en',
        }));
  }
}
