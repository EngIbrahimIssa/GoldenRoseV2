import 'package:entaj/src/entities/product_details_model.dart';

import 'option_model.dart';
import 'reviews_model.dart';

import '../../main.dart';
import 'category_model.dart';

class ProductModel {
  String? id;
  String? parentId;
  String? name;
  String? description;
  String? sku;
  List<CustomFields>? customFields;
  int? quantity;
  dynamic? weight;
  bool? isTaxable;
  bool? isDiscounted;
  dynamic? meta;
  int? netPriceWithAdditions;
  String? netPriceWithAdditionsString;
  double? priceWithAdditions;
  String? priceWithAdditionsString;
  int? netPrice;
  String? netPriceString;
  dynamic? netSalePrice;
  dynamic? netSalePriceString;
  int? netAdditionsPrice;
  dynamic? netAdditionsPriceString;
  int? grossPrice;
  String? grossPriceString;
  dynamic? grossSalePrice;
  dynamic? grossSalePriceString;
  dynamic? priceBefore;
  dynamic? priceBeforeString;
  dynamic? totalBefore;
  dynamic? totalBeforeString;
  int? grossAdditionsPrice;
  dynamic? grossAdditionsPriceString;
  int? taxPercentage;
  int? taxAmount;
  Reviews? reviews;
  String? taxAmountString;
  String? taxAmountStringPerItem;
  double? price;
  String? priceString;
  int? additionsPrice;
  String? additionsPriceString;
  double? total;
  String? formattedPrice;
  String? formattedSalePrice;
  String? totalString;
  String? html_url;
  List<Images>? images;
  List<OptionModel>? custom_option_fields;
  List<CategoryModel>? categories;
  List<Option>? options;


  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    parentId = json['parent_id'];
    description =json['description'];
    name =json['name'];
    html_url = json['html_url'];
 //   name = json['name'];
    sku = json['sku'];
    if (json['custom_fields'] != null) {
      customFields = [];
      json['custom_fields'].forEach((v) {
        customFields?.add(CustomFields.fromJson(v));
      });
    }
    if (json['custom_option_fields'] != null) {
      custom_option_fields = [];
      json['custom_option_fields'].forEach((v) {
        custom_option_fields?.add(OptionModel.fromJson(v));
      });
    }
    //formattedPrice = json['formatted_price'];
    formattedSalePrice = json['formatted_sale_price'];
    quantity = json['quantity'];
    weight = json['weight'];
    isTaxable = json['is_taxable'];
    isDiscounted = json['is_discounted'];
    meta = json['meta'];
 //   netPriceWithAdditions = json['net_price_with_additions'];
    netPriceWithAdditionsString = json['net_price_with_additions_string'];
  //  priceWithAdditions = json['price_with_additions'];
    priceWithAdditionsString = json['price_with_additions_string'];
 //   netPrice = json['net_price'];
  //  netPriceString = json['net_price_string'];
   // netSalePrice = json['net_sale_price'];
    netSalePriceString = json['net_sale_price_string'];
   // netAdditionsPrice = json['net_additions_price'];
    netAdditionsPriceString = json['net_additions_price_string'];
 //   grossPrice = json['gross_price'];
    grossPriceString = json['gross_price_string'];
  //  grossSalePrice = json['gross_sale_price'];
    grossSalePriceString = json['gross_sale_price_string'];
  //  priceBefore = json['price_before'];
    priceBeforeString = json['price_before_string'];
   // totalBefore = json['total_before'];
    totalBeforeString = json['total_before_string'];
   // grossAdditionsPrice = json['gross_additions_price'];
    grossAdditionsPriceString = json['gross_additions_price_string'];
   // taxPercentage = json['tax_percentage'];
   // taxAmount = json['tax_amount'];
    taxAmountString = json['tax_amount_string'];
    taxAmountStringPerItem = json['tax_amount_string_per_item'];
 //   price = json['price'];
    priceString = json['price_string'];
   // additionsPrice = json['additions_price'];
    additionsPriceString = json['additions_price_string'];
  //  total = json['total'];
    totalString = json['total_string'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    /*if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(CategoryModel.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options?.add((Option.fromJson(v)));
      });
    }
*/  }

}

class Description {
  String? ar;
  String? en;

  Description.fromJson(dynamic json) {
    ar = isArabicLanguage ?  json['ar'] : json['en'] ?? json['ar'];
    en = json['en'];
  }
}


class Option {
  String? slug;
  String? name;
  List<String>? choices;

  Option.fromJson(dynamic json) {
    name = json['name'];
    slug = json['slug'];
    choices = json['choices'] != null ? json['choices'].cast<String>() : [];
  }

}

class Images {
  String? id;
  String? origin;
  Thumbs? thumbs;
  Thumbs? image;

  Images.fromJson(dynamic json) {
    id = json['id'];
    origin = json['origin'];
    thumbs = json['thumbs'] != null ? Thumbs.fromJson(json['thumbs']) : null;
    image = json['image'] != null ? Thumbs.fromJson(json['image']) : null;
  }

}

class Thumbs {
  String? large;
  String? medium;
  String? fullSize;
  String? small;
  String? thumbnail;

  Thumbs.fromJson(dynamic json) {
    large = json['large'];
    medium = json['medium'];
    fullSize = json['full_size'];
    small = json['small'];
    thumbnail = json['thumbnail'];
  }

}