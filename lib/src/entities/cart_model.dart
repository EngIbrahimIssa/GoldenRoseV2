import 'product_details_model.dart';
import '../utils/functions.dart';

import 'coupon_model.dart';

class CartModel {
  int? id;
  String? sessionId;
  String? phase;
  bool? requiredCustomerEmail;
  OrderStatus? orderStatus;
  Currency? currency;
  dynamic? customer;
  bool? skipAddress;
  bool? requiresShipping;
  List<Products>? products;
  int? productsCount;
  int? productsWeight;
  late double productsSubtotal;
  CouponModel? coupon;
  List<dynamic>? discountRules;
  List<Totals>? totals;
  String? createdAt;
  bool? isReserved;



  CartModel.fromJson(dynamic json) {
    id = json['id'];
    sessionId = json['session_id'];
    phase = json['phase'];
    requiredCustomerEmail = json['required_customer_email'];
    orderStatus = json['order_status'] != null ? OrderStatus.fromJson(json['order_status']) : null;
    coupon = json['coupon'] != null ? CouponModel.fromJson(json['coupon']) : null;
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    customer = json['customer'];
    skipAddress = json['skip_address'];
    productsSubtotal = checkDouble(json['products_subtotal']);
    requiresShipping = json['requires_shipping'];
  //  shippingAddress = json['shipping_address'];
  //  shippingMethod = json['shipping_method'];
  //  paymentMethod = json['payment_method'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    productsCount = json['products_count'];
 //   productsWeight = json['products_weight'];
  //  productsSubtotal = json['products_subtotal'];
/*    if (json['discount_rules'] != null) {
      discountRules = [];
      json['discount_rules'].forEach((v) {
        discountRules?.add(dynamic.fromJson(v));
      });
    }*/
    if (json['totals'] != null) {
      totals = [];
      json['totals'].forEach((v) {
        totals?.add(Totals.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    isReserved = json['is_reserved'];
  }

}

class Totals {
  String? code;
  double? value;
  String? valueString;
  String? title;

  Totals.fromJson(dynamic json) {
    code = json['code'];
    //value = checkDouble(json['value']);
    valueString = json['value_string'];
    title = json['title'];
  }

}

class Products {
  int? id;
  String? productId;
  String? sku;
  String? name;
  List<CustomFields>? customFields;
  int? quantity;
  bool? isPublished;
  bool? isTaxable;
  bool? isDiscounted;
  dynamic? meta;
  String? url;
  int? netPrice;
  String? netPriceString;
  int? netSalePrice;
  String? netSalePriceString;
  String? netAdditionsPrice;
  String? netAdditionsPriceString;
  int? taxPercentage;
  int? taxAmount;
  String? taxAmountString;
  int? grossPrice;
  String? grossPriceString;
  dynamic? grossSalePrice;
  dynamic? grossSalePriceString;
  int? priceBefore;
  String? priceBeforeString;
  int? totalBefore;
  String? totalBeforeString;
  String? price;
  String? priceString;
  String? additionsPrice;
  String? additionsPriceString;
  double? total;
  String? totalString;
  bool? isOriginalProductAvailable;
  int? originalProductQuantity;
  bool? isRequestedQuantityEnough;
  bool? isOriginalQuantityFinished;
  bool? isProductRelatedOptionUpdated;
  bool? isProductPriceUpdated;
  PurchaseRestrictions? purchaseRestrictions;
  List<Images>? images;



  Products.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    sku = json['sku'];
    name = json['name'];
    purchaseRestrictions =PurchaseRestrictions.fromJson( json['purchase_restrictions']);
    if (json['custom_fields'] != null) {
      customFields = [];
      json['custom_fields'].forEach((v) {
        customFields?.add(CustomFields.fromJson(v));
      });
    }
    quantity = json['quantity'];
    isPublished = json['is_published'];
    isTaxable = json['is_taxable'];
    isDiscounted = json['is_discounted'];
    meta = json['meta'];
    url = json['url'];
    //netPrice = json['net_price'];
    netPriceString = json['net_price_string'];
    //netSalePrice = json['net_sale_price'];
    netSalePriceString = json['net_sale_price_string'];
    //netAdditionsPrice = json['net_additions_price'];
    netAdditionsPriceString = json['net_additions_price_string'];
    //taxPercentage = json['tax_percentage'];
    //taxAmount = json['tax_amount'];
    taxAmountString = json['tax_amount_string'];
    //grossPrice = json['gross_price'];
    //grossPriceString = json['gross_price_string'];
    //grossSalePrice = json['gross_sale_price'];
    grossSalePriceString = json['gross_sale_price_string'];
    //priceBefore = json['price_before'];
    priceBeforeString = json['price_before_string'];
    //totalBefore = json['total_before'];
    totalBeforeString = json['total_before_string'];
    //price = json['price'];
    priceString = json['price_string'];
    //additionsPrice = json['additions_price'];
    additionsPriceString = json['additions_price_string'];
    total = checkDouble(json['total']);
    totalString = json['total_string'];
    isOriginalProductAvailable = json['is_original_product_available'];
    originalProductQuantity = json['original_product_quantity'];
    isRequestedQuantityEnough = json['is_requested_quantity_enough'];
    isOriginalQuantityFinished = json['is_original_quantity_finished'];
    isProductRelatedOptionUpdated = json['is_product_related_option_updated'];
    isProductPriceUpdated = json['is_product_price_updated'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }

}

class Images {
  String? id;
  String? origin;
  Thumbs? thumbs;


  Images.fromJson(dynamic json) {
    id = json['id'];
    origin = json['origin'];
    thumbs = json['thumbs'] != null ? Thumbs.fromJson(json['thumbs']) : null;
  }


}

class Thumbs {
  String? thumbnail;
  String? fullSize;
  String? large;
  String? medium;
  String? small;

  Thumbs.fromJson(dynamic json) {
    thumbnail = json['thumbnail'];
    fullSize = json['full_size'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
  }


}

class Currency {
  CartCurrency? cartCurrency;
  CartStoreCurrency? cartStoreCurrency;

  Currency.fromJson(dynamic json) {
    cartCurrency = json['cart_currency'] != null ? CartCurrency.fromJson(json['cart_currency']) : null;
    cartStoreCurrency = json['cart_store_currency'] != null ? CartStoreCurrency.fromJson(json['cart_store_currency']) : null;
  }

}

class CartStoreCurrency {
  int? id;
  String? name;
  String? code;
  String? symbol;
  Country? country;


  CartStoreCurrency.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }

}

class Country {
  int? id;
  String? name;
  String? code;
  String? countryCode;
  String? flag;

  Country.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    countryCode = json['country_code'];
    flag = json['flag'];
  }

}

class CartCurrency {
  int? id;
  String? name;
  String? code;
  String? symbol;
  Country? country;


  CartCurrency.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }


}

class OrderStatus {
  String? name;
  String? code;


  OrderStatus.fromJson(dynamic json) {
    name = json['name'];
    code = json['code'];
  }


}