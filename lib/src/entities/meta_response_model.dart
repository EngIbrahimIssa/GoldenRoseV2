import 'dart:developer';

import 'package:entaj/src/utils/functions.dart';

class MetaResponseModel {
  MetaResponseModel({
    this.bundleOffer,
  });

  MetaResponseModel.fromJson(dynamic json) {
    bundleOffer = json['bundle_offer'] != null
        ? BundleOffer.fromJson(json['bundle_offer'])
        : null;
  }

  BundleOffer? bundleOffer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (bundleOffer != null) {
      map['bundle_offer'] = bundleOffer?.toJson();
    }
    return map;
  }
}

class BundleOffer {
  BundleOffer({
    this.id,
    this.name,
    this.discountAmount,
    this.discountPercentage,
    this.priceAfterDiscount,
    this.priceAfterDiscountString,
  });

  BundleOffer.fromJson(dynamic json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    discountAmount = checkDouble(json['discount_amount']);
    discountPercentage = checkDouble(json['discount_percentage']);
    priceAfterDiscount = checkDouble(json['price_after_discount']);
    priceAfterDiscountString = json['price_after_discount_string'];
  }

  String? id;
  String? name;
  double? discountAmount;
  double? discountPercentage;
  double? priceAfterDiscount;
  String? priceAfterDiscountString;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['discount_amount'] = discountAmount;
    map['discount_percentage'] = discountPercentage;
    map['price_after_discount'] = priceAfterDiscount;
    map['price_after_discount_string'] = priceAfterDiscountString;
    return map;
  }
}
