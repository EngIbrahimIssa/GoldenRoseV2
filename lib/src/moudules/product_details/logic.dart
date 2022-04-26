import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as dio;
import '../../app_config.dart';
import '../../data/remote/api_requests.dart';
import '../../entities/custom_option_field_request.dart';
import '../../entities/custom_user_input_field_request.dart';
import '../../entities/product_details_model.dart';
import '../_main/logic.dart';
import '../images/view.dart';
import '../reviews/view.dart';
import '../../services/app_events.dart';
import '../../utils/error_handler/error_handler.dart';
import '../../utils/functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../entities/offer_response_model.dart';

class ProductDetailsLogic extends GetxController  with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();
    emailController.addListener(() {
      isEmpty = emailController.text.isEmpty;
      update(['isEmpty']);
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

  final ApiRequests _apiRequests = Get.find();
  final MainLogic _mainLogic = Get.find();
  final AppEvents _appEvents = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController quantityController =
      TextEditingController(text: '1');

  Map<String, TextEditingController> mapTextEditController = {};
  Map<String, String> mapDropDownChoices = {};
  Map<String?, String?> mapOptions = {};
  Map<String, bool> mapCheckboxChoicesItem = {};
  Map<String, Map<String, bool>> mapCheckboxChoices = {};
  ProductDetailsModel? productModel;
  String? description;
  int selectedImageIndex = 0;

  //int quantity = 1;
  bool isEmpty = true;
  bool clickOnMore = false;
  bool inStock = true;
  bool hasInternet = true;
  bool isLoading = false;
  bool isReviewsLoading = false;
  bool isUploadLoading = false;
  bool isNotifyMeLoading = false;
  bool isProductDeleted = false;
  double priceCustom = 0;
  double salePriceCustom = 0;
  double priceOriginal = 0;
  double salePriceOriginal = 0;
  double priceTotal = 0;
  double salePriceTotal = 0;
  String formattedPrice = '';
  String formattedSalePrice = '';

  Future<bool> checkInternetConnection(String productId) async {
    var connection =
        (await Connectivity().checkConnectivity() != ConnectivityResult.none);
    hasInternet = connection;
    update([productId]);
    return connection;
  }

  increaseQuantity() {
    if (quantityController.text.isEmpty) {
      quantityController.text = '0';
    }
    int quantity = int.parse(quantityController.text);

    var maxQuantityPerCart = productModel?.purchaseRestrictions?.maxQuantityPerCart;
    var productQuantity = productModel?.quantity;
    if(maxQuantityPerCart != null && productQuantity !=null){
      if(productQuantity < maxQuantityPerCart){
        if (quantity >= productQuantity) {
          return;
        }
      }else{
        if (quantity >= maxQuantityPerCart) {
          return;
        }
      }
    }
    if (maxQuantityPerCart != null) {
      if (quantity >= maxQuantityPerCart) {
        return;
      }
    } else if (productQuantity!= null) {
      if (quantity >= productQuantity) return;
    }else if(quantity > 9999) {
      quantityController.text = '9999';
    }


    quantity++;
    quantityController.text = quantity.toString();
    quantityController.selection = TextSelection.fromPosition(
        TextPosition(offset: quantityController.text.length));

    update(['quantity']);
  }

  decreaseQuantity() {
    int quantity = int.parse(quantityController.text);
    if (quantity < 2) return;
    quantity--;
    quantityController.text = quantity.toString();
    quantityController.selection = TextSelection.fromPosition(
        TextPosition(offset: quantityController.text.length));
    update(['quantity']);
  }

  void goToReviews() {
    if (productModel == null) {
      return;
    }
    Get.to(ReviewsPage(
      productId: productModel!.id!,
      isFromOrderDetails: false,
    ));
  }

  void changeSelectedImage(int index) {
    selectedImageIndex = index;
    update(['images']);
  }

  goToImages(List<Images>? images) {
    if (images == null || images.length == 0) {
      return;
    }

    Get.to(ImagesPage(images, selectedImageIndex));
  }

  double lastDif = 0;
  double lastSaleDif = 0;

  void onChange(String? newValue, Options? option, {bool withUpdate = false}) {
    mapOptions[option?.name] = newValue;
    if (withUpdate) update([option?.name ?? '']);
    if (productModel?.options == null) return;
    if (mapOptions.length != productModel?.options?.length) return;
    String? productId = getProductId();
    productModel?.variants?.forEach((element) {
      if (element.id == productId) {
        //productModel?.name = element.name;

        priceTotal = element.price + priceCustom;
        salePriceTotal = element.salePrice + salePriceCustom;

        formattedPrice = '${priceTotal.toStringAsFixed(2)} ${productModel?.currency}';
        formattedSalePrice = '${salePriceTotal.toStringAsFixed(2)} ${productModel?.currency}';
        // productModel?.htmlUrl = element.htmlUrl;
        productModel?.sku = element.sku;
        productModel?.quantity = element.quantity;
        productModel?.purchaseRestrictions?.maxQuantityPerCart =
            element.purchaseRestrictions?.maxQuantityPerCart;
        productModel?.purchaseRestrictions?.minQuantityPerCart =
            element.purchaseRestrictions?.minQuantityPerCart;
        //  productModel?.quantity = element.quantity;
        productModel?.images = [];
        productModel?.images?.addAll(element.images ?? []);
        if (AppConfig.isSoreUseNewTheme || element.images?.isEmpty == true)
          productModel?.images?.addAll(productModel?.originalImages ?? []);
        quantityController.text = '1';
        if (withUpdate) update(['price', 'notify', productModel?.id ?? '']);
        if (withUpdate) update();
      }
    });
  }

  String? getProductId() {
    if (productModel == null) return null;
    if (productModel?.hasOptions == false) return productModel?.id;
    String? productId;
    if (productModel?.hasOptions == true && mapOptions.isNotEmpty) {
      productModel?.variants?.forEach((variant) {
        var product = [];
        mapOptions.forEach((key, value) {
          variant.attributes?.forEach((attributes) {
            if (attributes.name == key && attributes.value == value) {
              product.add(true);
            } else {
              product.add(false);
            }
          });
        });
        var trueCount = 0;
        var falseCount = 0;
        product.forEach((element) {
          element ? trueCount++ : falseCount++;
        });
        if (trueCount >= mapOptions.length) {
          productId = variant.id;
        }
        //log(trueCount.toString() + " T -- " + variant.id.toString());
        //log(falseCount.toString() + " F -- " + variant.id.toString());
      });
    }
    return productId;
  }

  List getCustomList() {
    List list = [];

    productModel?.customFields?.forEach((element) {
      mapTextEditController.forEach((key, value) {
        if (key == element.id) {
          if ((mapTextEditController[element.id]?.text.length ?? 0) > 0) {
            list.add(CustomUserInputFieldRequest(
                    priceSettings: element.id,
                    groupId: element.id,
                    name: element.label,
                    value: mapTextEditController[element.id]?.text,
                    type: element.type)
                .toJson());
          }
        }
      });
    });

    productModel?.customOptionFields?.forEach((customOption) {
      mapDropDownChoices.forEach((key, value) {
        if (key == customOption.id) {
          if ((mapDropDownChoices[customOption.id]?.length ?? 0) > 0) {
            list.add(CustomOptionFieldRequest(
                    priceSettings: {customOption.id: value},
                    groupId: customOption.id,
                    groupName: customOption.name,
                    value: "✔",
                    name: customOption.choices
                            ?.firstWhere((element) => element.id == value)
                            .ar ??
                        '',
                    type: customOption.type)
                .toJson());
          }
        }
      });
    });

    productModel?.customOptionFields?.forEach((customOption) {
      mapCheckboxChoices.forEach((key, value) {
        if (key == customOption.id) {
          if ((mapCheckboxChoices[customOption.id]?.length ?? 0) > 0) {
            List checkedList = [];
            mapCheckboxChoices[key]?.forEach((key2, value2) {
              if (value2) {
                checkedList.add(key2);
              }
            });
            list.add(CustomOptionFieldRequest(
                    priceSettings: {key: checkedList},
                    groupId: customOption.id,
                    groupName: customOption.name,
                    value: "✔",
                    name: productModel?.customOptionFields
                            ?.firstWhere((element) => element.id == key)
                            .name ??
                        '',
                    type: customOption.type)
                .toJson());
          }
        }
      });
    });

    return list;
  }

  changeDropDownSelected(String id, double customPrice, value) {
    var lastIdValue = mapDropDownChoices[id];
    double lastPrice = 0;
    try {
      productModel?.customOptionFields?.firstWhere((element) {
        if (element.id == id) {
          element.choices?.firstWhere((element) {
            if (element.id == lastIdValue) {
              lastPrice = element.price ?? 0;
              return true;
            }
            return false;
          });
        }
        return false;
      });
    } catch (e) {}

    if (!mapDropDownChoices.containsValue(value)) {
      priceTotal -= lastPrice;
      salePriceTotal -= lastPrice;
      priceTotal = priceTotal + customPrice;
      salePriceTotal = salePriceTotal + customPrice;

      priceCustom += customPrice;
      salePriceCustom += customPrice;
    }

    formattedPrice = '${priceTotal.toStringAsFixed(2)} ${productModel?.currency}';
    formattedSalePrice = '${salePriceTotal.toStringAsFixed(2)} ${productModel?.currency}';
    mapDropDownChoices[id] = value.toString();
    update(['price', id]);
  }

  changeCheckboxSelected(
      String id, String choicesId, double customPrice, bool? value) {
    if (mapCheckboxChoicesItem[choicesId] == null ||
        mapCheckboxChoicesItem[choicesId] == false) {
      priceCustom += customPrice;
      salePriceCustom += customPrice;
      priceTotal = priceTotal + customPrice;
      salePriceTotal = salePriceTotal + customPrice;
      formattedPrice = '${priceTotal.toStringAsFixed(2)} ${productModel?.currency}';
      formattedSalePrice = '${salePriceTotal.toStringAsFixed(2)} ${productModel?.currency}';
    } else {
      priceCustom -= customPrice;
      salePriceCustom -= customPrice;

      priceTotal = priceTotal - customPrice;
      salePriceTotal = salePriceTotal - customPrice;
      formattedPrice = '${priceTotal.toStringAsFixed(2)} ${productModel?.currency}';
      formattedSalePrice = '${salePriceTotal.toStringAsFixed(2)} ${productModel?.currency}';
    }
    mapCheckboxChoicesItem[choicesId] = value ?? false;
    mapCheckboxChoices[id] = mapCheckboxChoicesItem;
    update(['price', id]);
  }

  getDescription({required bool all}) {
    if (!all) {
      if ((productModel?.description?.length ?? 0) > 300) {
        if((productModel?.description?.length ?? 0) < 350) {
         getDescription(all: true);
        }
        description = productModel?.description?.substring(0, 300) ?? '';
      } else {
        description = productModel?.description ?? ' ';
      }
    } else {
      description = productModel?.description ?? ' ';
    }

    if (description!.lastChars(1) == '<' || description!.lastChars(1) == '>') {
      description = description?.substring(0, description!.length - 1);
    }
    clickOnMore = !clickOnMore;
    update(['description']);
  }

  Future<void> getProductDetails(String productId) async {
    isProductDeleted = false;
    if (!await checkInternetConnection(productId)) return;
    productModel = null;
    isLoading = true;
    update([productId]);

    try {
      var response = await _apiRequests.getProductDetails(productId);
    // log(json.encode(response.data));
      productModel = ProductDetailsModel.fromJson(response.data);

      List<String> productRelatedIds  = [];
      productRelatedIds.add(productId);
      productModel?.relatedProducts?.forEach((element) {
        productRelatedIds.add(element.id ?? '');
      });
      var res = await _apiRequests.getSimpleBundleOffer(productRelatedIds);
      List<OfferResponseModel> offerList = (res.data['payload'] as List)
          .map((e) => OfferResponseModel.fromJson(e))
          .toList();

      offerList.forEach((elementOffer) {
        if (elementOffer.productIds?.contains(productId) == true) {
          productModel?.offerLabel = elementOffer.name;
        }

        productModel?.relatedProducts?.forEach((element) {
          if(elementOffer.productIds?.contains(element.id) == true){
            element.offerLabel = elementOffer.name;
          }
        });

      });
      priceCustom = 0;
      salePriceCustom = 0;
      priceOriginal = productModel!.price;
      salePriceOriginal = productModel!.salePrice;
      priceTotal = productModel!.price;
      salePriceTotal = productModel!.salePrice;
      formattedPrice = '${priceTotal.toStringAsFixed(2)} ${productModel?.currency}';
      formattedSalePrice = '${salePriceTotal.toStringAsFixed(2)} ${productModel?.currency}';
      update(['price']);

      _appEvents.logOpenProduct(
          name: productModel?.name,
          price: productModel?.formattedPrice,
          productId: productId);

      productModel?.options?.forEach((element) {
        if (element.choices?.isNotEmpty == true) {
          onChange(element.choices?.first, element, withUpdate: false);
        }
      });
      getDescription(all: false);
    } catch (e) {
      try {
        if (e is dio.DioError) {
          if (e.response != null) {
            if ((e.response!.data['detail']?.toString().contains('Not found') ==
                    true) ||
                (e.response!.data['detail']?.toString().contains('غير موجود') ==
                    true)) {
              isProductDeleted = true;
            }
          }
        }
      } catch (e) {}

      ErrorHandler.handleError(e);
    }

    isLoading = false;
    update([productId]);
  }

  Future<void> sentNotification() async {
    if (emailController.text.isEmpty) {
      Fluttertoast.showToast(msg: "يرجى ادخال البريد الإلكتروني".tr);
      return;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      Fluttertoast.showToast(msg: "البريد الالكتروني غير صالح".tr);
      return;
    }

    isNotifyMeLoading = true;
    update();

    try {
      var response = await _apiRequests.notifyMeProduct(
          productModel?.id, emailController.text);

      // Get.back();
      Fluttertoast.showToast(msg: "تم تفعيل التنبيه بنجاح".tr);
    } catch (e) {
      //   Fluttertoast.showToast(msg: e.toString());
      ErrorHandler.handleError(e);
    }

    isNotifyMeLoading = false;
    update();
  }

  Future<List<String?>?> uploadFileImage(bool isFile, String id) async {
    List<String?>? path;
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: isFile ? FileType.any : FileType.image);

    final file = File(result?.files.single.path ?? '');
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb > 8) {
      Fluttertoast.showToast(
          msg: 'حجم الملف غير صالح\nحجم الملف الأقصى : 8M'.tr);
      return path;
    }
    if (result != null) {
      File file = File(result.files.single.path ?? '');

      isUploadLoading = true;
      update([id]);
      try {
        var res =
            await _apiRequests.uploadFileImage(file: file, isFile: isFile);
        path = [];
        path.add(res.data['payload']['path']);
        path.add(res.data['payload']['temporary_url']);
      } catch (e) {
        ErrorHandler.handleError(e);
      }
      isUploadLoading = false;
      update([id]);
    } else {}
    return path;
  }

  void observeTextEdit(
      TextEditingController? mapTextEditController, double customPrice) {
    bool priceAdded = false;
    mapTextEditController?.addListener(() {
      if (mapTextEditController.text != '' && !priceAdded) {
        priceAdded = true;

        priceCustom += customPrice;
        salePriceCustom += customPrice;

        priceTotal = priceTotal + customPrice;
        salePriceTotal = salePriceTotal + customPrice;

        formattedPrice = '${priceTotal.toStringAsFixed(2)} ${productModel?.currency}';
        formattedSalePrice = '${salePriceTotal.toStringAsFixed(2)} ${productModel?.currency}';
        update(['price']);
      } else if (mapTextEditController.text == '' && priceAdded) {
        priceAdded = false;

        priceCustom -= customPrice;
        salePriceCustom -= customPrice;

        priceTotal = priceTotal - customPrice;
        salePriceTotal = salePriceTotal - customPrice;

        formattedPrice = '${priceTotal.toStringAsFixed(2)} ${productModel?.currency}';
        formattedSalePrice = '${salePriceTotal.toStringAsFixed(2)} ${productModel?.currency}';
        update(['price']);
      }
    });
  }

  goToWhatsApp({String? message}) async {
    String whatsAppUrl = "";

    String phoneNumber =
        _mainLogic.settingModel?.footer?.socialMedia?.items?.phone ?? '';

    whatsAppUrl =
        'https://wa.me/+$phoneNumber?text=${Uri.encodeComponent(message ?? '')}';

    if (await canLaunch(whatsAppUrl)) {
      await launch(whatsAppUrl);
    } else {
      Get.snackbar("Whats App Error".tr, "Install WhatsApp First Please".tr);
    }
  }
}
