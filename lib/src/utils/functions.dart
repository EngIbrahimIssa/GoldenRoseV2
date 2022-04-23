import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:entaj/main.dart';
import 'package:entaj/src/entities/product_details_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

double checkDouble(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return 0.0;
  if (value is List<int>) return value.isEmpty ? 0.0 : value.first.toDouble();
  if (value is List<double>) return value.isEmpty ? 0.0 : value.first;
  return 0.0;
}

String? getLabelInString(dynamic value) {
  if (value is String) return value;
  if (value is Label) return isArabicLanguage ? value.ar : value.en;
  return null;
}

goToLink(String? link) async {
  log(link.toString());
  if (link == null || link =='') return;
  if (link.contains('categories')) {
    try {
      var categoryId = link.substring(
          link.indexOf('categories') + 11, link.indexOf('categories') + 17);
      log(categoryId.toString());
      Get.toNamed("/category-details/$categoryId");
      return;
    } catch (e) {
      return;
    }
  } else if (link.contains('products')) {
    try {
      String productId = link.substring(10, link.length);
      var url = Uri.encodeComponent(productId);
      Get.toNamed("/product-details/$url");
      return;
    } catch (e) {
      return;
    }
  }
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    log("can't launch $link");
    if (link.contains('categories')) {
      try {
        var categoryId = link.substring(
            link.indexOf('categories') + 11, link.indexOf('categories') + 17);
        log(categoryId.toString());
        Get.toNamed("/category-details/$categoryId");
      } catch (e) {}
    } else if (link.contains('products')) {
      try {
        String productId = link.substring(10, link.length);
        var url = Uri.encodeComponent(productId);
        Get.toNamed("/product-details/$url");
      } catch (e) {}
    }
  }
}

Future<bool> checkInternet() async {
  final ConnectivityResult result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.none) {
    Fluttertoast.showToast(
        msg: 'يرجى التأكد من اتصالك بالإنترنت'.tr,
        toastLength: Toast.LENGTH_SHORT);
    return false;
  }
  return true;
}

String calculateDiscount(
    {required double salePriceTotal, required double priceTotal}) {
  return 'خصم '.tr +
      '${((1 - (salePriceTotal / priceTotal)) * 100).round().toString()}%';
}

String replaceArabicNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(arabic[i], english[i]);
  }
  return input;
}
