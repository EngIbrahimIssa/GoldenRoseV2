import 'dart:developer';

import 'category_model.dart';
import 'meta_response_model.dart';
import 'reviews_model.dart';
import '../utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class ProductDetailsModel {
  String? id;
  String? sku;
  dynamic? parentId;
  String? name;
  String? offerLabel;
  String? slug;
  double price = 0.0;
  double salePrice = 0;
  String? formattedPrice;
  dynamic? formattedSalePrice;
  String? currency;
  String? currencySymbol;
  List<Attribute>? attributes;
  List<CategoryModel>? categories;
  dynamic? displayOrder;
  bool? hasOptions;
  bool? hasFields;
  List<Images>? images;
  List<Images>? originalImages;
  bool? isDraft;
  dynamic? quantity;
  bool? isInfinite;
  String? htmlUrl;
  Weight? weight;
  List<dynamic>? keywords;
  bool? requiresShipping;
  bool? isTaxable;
  String? structure;
  dynamic? seo;
  int? storeId;
  dynamic? soldProductsCount;
  String? createdAt;
  String? updatedAt;
  dynamic? cost;
  bool? isPublished;
  String? description;
  List<ProductDetailsModel>? variants;
  List<ProductDetailsModel>? relatedProducts;
  List<CustomFields>? customFields;
  List<CustomOptionFields>? customOptionFields;
  List<Options>? options;
  String? nextProduct;
  String? previousProduct;
  Rating? rating;
  PurchaseRestrictions? purchaseRestrictions;
  MetaResponseModel? meta;

  ProductDetailsModel.fromJson(dynamic json) {
    meta =
        json['meta'] == null ? null : MetaResponseModel.fromJson(json['meta']);
    id = json['id'];
    sku = json['sku'];
    parentId = json['parent_id'];
    name = getLabelInString(json['name']);
    description = getLabelInString(json['description']);
    try {
      var x = description?.indexOf('&lt;figure');
      var y = description?.indexOf('/figure&gt;');
      var sub = description!.substring(x!, y);
      description = description?.replaceAll(sub, '');
      description = description?.replaceAll('/figure&gt;', '');
    } catch (e) {}
    try {
      var x = description?.indexOf('&lt;yt-formatted-string');
      var y = description?.indexOf('/yt-formatted-string&gt;');
      var sub = description!.substring(x!, y);
      description = description?.replaceAll(sub, '');
      description = description?.replaceAll('/yt-formatted-string&gt;', '');
    } catch (e) {}
    slug = json['slug'];

    salePrice = checkDouble(json['sale_price'] ?? 0.0);
    price = checkDouble(json['price'] ?? 0.0);
    formattedPrice = json['formatted_price'];
    formattedSalePrice = json['formatted_sale_price'];

    if (meta != null) {
      if (meta?.bundleOffer != null) {
        salePrice = meta?.bundleOffer?.priceAfterDiscount ?? 0;
        formattedSalePrice = meta?.bundleOffer?.priceAfterDiscountString;
      }
    }

    currency = json['currency'];
    currencySymbol = json['currency_symbol'];
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add(Attribute.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        if (v['name'] != null) {
          categories?.add(CategoryModel.fromJson(v));
        }
      });
    }
    rating = Rating.fromJson(json['rating']);
    purchaseRestrictions =
        PurchaseRestrictions.fromJson(json['purchase_restrictions']);
    displayOrder = json['display_order'];
    hasOptions = json['has_options'];
    hasFields = json['has_fields'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    if (json['images'] != null) {
      originalImages = [];
      json['images'].forEach((v) {
        originalImages?.add(Images.fromJson(v));
      });
    }

    isDraft = json['is_draft'];
    quantity = json['quantity'];
    isInfinite = json['is_infinite'];
    htmlUrl = json['html_url'];
    weight = json['weight'] != null ? Weight.fromJson(json['weight']) : null;
/*    if (json['keywords'] != null) {
      keywords = [];
      json['keywords'].forEach((v) {
        keywords?.add(dynamic.fromJson(v));
      });
    }*/
    requiresShipping = json['requires_shipping'];
    isTaxable = json['is_taxable'];
    structure = json['structure'];
    seo = json['seo'];
    storeId = json['store_id'];
    soldProductsCount = json['sold_products_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cost = json['cost'];
    isPublished = json['is_published'];
    if (json['variants'] != null) {
      variants = [];
      json['variants'].forEach((v) {
        variants?.add(ProductDetailsModel.fromJson(v));
      });
    }
    if (json['related_products'] != null) {
      relatedProducts = [];
      json['related_products'].forEach((v) {
        relatedProducts?.add(ProductDetailsModel.fromJson(v));
      });
    }
    if (json['custom_user_input_fields'] != null) {
      customFields = [];
      json['custom_user_input_fields'].forEach((v) {
        customFields?.add(CustomFields.fromJson(v));
      });
    }
    if (json['custom_option_fields'] != null) {
      customOptionFields = [];
      json['custom_option_fields'].forEach((v) {
        customFields?.add(CustomFields.fromJson(v));
      });
      json['custom_option_fields'].forEach((v) {
        customOptionFields?.add(CustomOptionFields.fromJson(v));
      });
    }
    customFields
        ?.sort((a, b) => (a.displayOrder ?? 0).compareTo(b.displayOrder ?? 0));
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options?.add(Options.fromJson(v));
      });
    }
    nextProduct = json['next_product'];
    previousProduct = json['previous_product'];
  }
}

class Attribute {
  String? id;
  String? slug;
  String? name;
  String? value;

  Attribute.fromJson(dynamic json) {
    id = json['id'];
    slug = json['slug'];
    name = getLabelInString(json['name']);
    value = getLabelInString(json['value']);

    // value = json['value'] != null ? OptionLabel.fromJson(json['value']) : null;
  }
}

class Weight {
  String? unit;
  double? value;

  Weight.fromJson(dynamic json) {
    unit = json['unit'];
    value = json['value'] == null ? null : checkDouble(json['value']);
  }
}

class Options {
  String? name;
  String? slug;
  List<String>? choices;

  Options.fromJson(dynamic json) {
    name = getLabelInString(json['name']);
    slug = json['slug'];
    choices = json['choices'] != null ? json['choices'].cast<String>() : [];
  }
}

class PurchaseRestrictions {
  int? maxQuantityPerCart;
  int? minQuantityPerCart;

  PurchaseRestrictions.fromJson(dynamic json) {
    if (json == null) return;
    minQuantityPerCart = json['min_quantity_per_cart'];
    maxQuantityPerCart = json['max_quantity_per_cart'];
  }
}

class CustomOptionFields {
  String? id;
  String? type;
  String? hint;
  String? name;
  int? minChoices;
  int? maxChoices;
  bool? isRequired;
  bool? canChooseMultipleOptions;
  List<Choices>? choices;
  dynamic? displayOrder;
  bool? isPublished;

  CustomOptionFields.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = getLabelInString(json['label']);
    hint = getLabelInString(json['hint']);

    //  hint = json['hint'] != null ? Label.fromJson(json['hint']) : null;
    //  label = json['label'] != null ? Label.fromJson(json['label']) : null;
    minChoices = json['min_choices'];
    maxChoices = json['max_choices'];
    isRequired = json['is_required'];
    canChooseMultipleOptions = json['can_choose_multiple_options'];
    if (json['choices'] != null) {
      choices = [];
      json['choices'].forEach((v) {
        choices?.add(Choices.fromJson(v));
      });
    }
    //  displayOrder = json['display_order'];
    isPublished = json['is_published'];
  }
}

class Choices {
  String? ar;
  String? name;
  String? en;
  String? id;
  double? price;
  String? formattedPrice;

  Choices.fromJson(dynamic json) {
    ar = isArabicLanguage ? json['ar'] : json['en'] ?? json['ar'];
    en = json['en'];
    id = json['id'];
    name = getLabelInString(json['name']);
    formattedPrice = json['formatted_price'].toString();
    price = checkDouble(json['price']);
  }
}

class CustomFields {
  String? id;
  String? type;
  String? label;
  String? hint;
  int? displayOrder;
  bool? isRequired;
  double? price;
  String? additionsPriceString;
  String? formattedPrice;
  String? formattedValue;
  TextEditingController? controller;
  bool? isPublished;
  String? realName;
  String? name;
  String? groupName;
  String? value;
  int? minChoices;
  int? maxChoices;
  int? additionsPrice;
  bool? canChooseMultipleOptions;
  List<Choices>? choices;

  CustomFields.fromJson(dynamic json) {
    id = json['id'];
    value = json['value'];
    realName = json['name'];
    groupName = json['group_name'];
    additionsPriceString = json['additions_price_string'];
    try {
      if (json['additions_price'] is int) {
        additionsPrice = json['additions_price'];
      } else {
        additionsPrice = int.parse(json['additions_price']);
      }
    } catch (e) {}
    formattedValue = json['formatted_value'];
    type = json['type'];
    label = getLabelInString(json['label']);
    hint = getLabelInString(json['hint']);
    name = getLabelInString(json['label']);
    displayOrder = json['display_order'];
    isRequired = json['is_required'];
    price = checkDouble(json['price']);
    controller = TextEditingController();
    formattedPrice = json['formatted_price'];
    isPublished = json['is_published'];
    minChoices = json['min_choices'];
    maxChoices = json['max_choices'];
    canChooseMultipleOptions = json['can_choose_multiple_options'];
    if (json['choices'] != null) {
      choices = [];
      json['choices'].forEach((v) {
        choices?.add(Choices.fromJson(v));
      });
    }
  }
}

class OptionLabel {
  String? ar;
  String? en;

  OptionLabel({this.ar, this.en});

  OptionLabel.fromJson(dynamic json) {
    //  ar = isArabicLanguage ?  json['ar'] : json['en'] ?? json['ar'];
    ar = json['ar'];
    en = json['en'];
  }
}

class Label {
  String? ar;
  String? en;

  Label.fromJson(dynamic json) {
    ar = isArabicLanguage ? json['ar'] : json['en'] /* ?? json['ar']*/;
    en = json['en'];
  }
}

class Attributes {
  String? id;
  String? slug;
  String? name;
  String? value;

  Attributes({this.id, this.slug, this.name, this.value});

  Attributes.fromJson(dynamic json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    value = getLabelInString(json['value']);
    //   value = json['value'] != null ? Label.fromJson(json['value']) : null;
  }
}

class Images {
  String? id;
  Image2? image;
  dynamic? altText;
  int? displayOrder;

  Images({this.id, this.image, this.altText, this.displayOrder});

  Images.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'] != null ? Image2.fromJson(json['image']) : null;
    altText = json['alt_text'];
    displayOrder = json['display_order'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['alt_text'] = altText;
    map['display_order'] = displayOrder;
    return map;
  }
}

class Image2 {
  String? fullSize;
  String? large;
  String? thumbnail;
  String? medium;
  String? small;

  Image2({this.fullSize, this.large, this.thumbnail, this.medium, this.small});

  Image2.fromJson(dynamic json) {
    fullSize = json['full_size'];
    large = json['large'];
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    small = json['small'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['full_size'] = fullSize;
    map['large'] = large;
    map['thumbnail'] = thumbnail;
    map['medium'] = medium;
    map['small'] = small;
    return map;
  }
}

class Categories {
  String? id;
  String? name;
  String? slug;
  String? description;
  String? coverImage;
  dynamic? image;
  int? displayOrder;

  Categories(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.coverImage,
      this.image,
      this.displayOrder});

  Categories.fromJson(dynamic json) {
    id = json['id'];
    name = getLabelInString(json['name']);
    description = getLabelInString(json['description']);
//name = json['name'] != null ? Label.fromJson(json['name']) : null;
    slug = json['slug'];
    //description = json['description'] != null ? Label.fromJson(json['description']) : null;
    coverImage = json['cover_image'];
    image = json['image'];
    displayOrder = json['display_order'];
  }
}
