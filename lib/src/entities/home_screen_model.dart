import 'dart:developer';

import 'category_model.dart';
import 'product_details_model.dart';
import '../utils/functions.dart';

import '../app_config.dart';

class HomeScreenModel {
  Slider? slider;
  PromotionImage? promotionImage;
  StoreDescription? storeDescription;
  FeaturedProducts? featuredProducts;
  FeaturedProducts? featuredProducts2;
  FeaturedProducts? featuredProducts3;
  FeaturedProducts? featuredProducts4;
  FeaturedProducts? featuredProductsPromoted;
  FeaturedProducts? recentProducts;
  FeaturedProducts? onSaleProducts;
  Featured_categories? featuredCategories;
  Brands? brands;
  Testimonials? testimonials;
  List<ProductDetailsModel>? products;

  HomeScreenModel.fromJson(dynamic json) {

    if (json['default'] != null) {

      if (json['default']['products'] != null) {
        products = [];
        json['default']['products'].forEach((v) {
          products?.add(ProductDetailsModel.fromJson(v));
        });

      }/*
      products = (json['default']['products'] as List)
          .map((e) => ProductDetailsModel.fromJson(e))
          .toList();*/
      return;
    }
    slider = json['slider'] != null ? Slider.fromJson(json['slider']) : null;
    promotionImage = json['promotion_image'] != null
        ? PromotionImage.fromJson(json['promotion_image'])
        : null;
    storeDescription = json['store_description'] != null
        ? StoreDescription.fromJson(json['store_description'])
        : null;
    featuredProducts = json['featured_products'] != null
        ? FeaturedProducts.fromJson(json['featured_products'])
        : null;
    featuredProducts2 = json['featured_products_2'] != null
        ? FeaturedProducts.fromJson(json['featured_products_2'])
        : null;
    featuredProducts3 = json['featured_products_3'] != null
        ? FeaturedProducts.fromJson(json['featured_products_3'])
        : null;
    featuredProducts4 = json['featured_products_4'] != null
        ? FeaturedProducts.fromJson(json['featured_products_4'])
        : null;
    featuredProductsPromoted = json['featured_products_promoted'] != null
        ? FeaturedProducts.fromJson(json['featured_products_promoted'])
        : null;
    recentProducts = json['recent_products'] != null
        ? FeaturedProducts.fromJson(json['recent_products'])
        : null;
    onSaleProducts = json['on_sale_products'] != null
        ? FeaturedProducts.fromJson(json['on_sale_products'])
        : null;
    featuredCategories = json['featured_categories'] != null
        ? Featured_categories.fromJson(json['featured_categories'])
        : null;
    brands = json['brands'] != null ? Brands.fromJson(json['brands']) : null;
    testimonials = json['testimonials'] != null
        ? Testimonials.fromJson(json['testimonials'])
        : null;
  }
}

class Testimonials {
  bool? display;
  String? title;
  List<Items>? items;

  Testimonials.fromJson(dynamic json) {
    display = json['display'];
    title = json['title'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
}

class Brands {
  bool? display;
  String? title;
  List<Items>? items;

  Brands({this.display, this.title, this.items});

  Brands.fromJson(dynamic json) {
    display = json['display'];
    title = json['title'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
}

class Featured_categories {
  bool? display;
  String? title;
  List<CategoryModel>? items;

  Featured_categories({this.display, this.title, this.items});

  Featured_categories.fromJson(dynamic json) {
    display = json['display'];
    title = json['title'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(CategoryModel.fromJson(v));
      });
    }
  }
}

class On_sale_products {
  bool? display;
  String? title;
  More_button? moreButton;
  List<Items>? items;

  On_sale_products({this.display, this.title, this.moreButton, this.items});

  On_sale_products.fromJson(dynamic json) {
    display = json['display'];
    title = json['title'];
    moreButton = json['more_button'] != null
        ? More_button.fromJson(json['more_button'])
        : null;
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
}

class Items {
  String? id;
  String? url;
  String? image;
  String? type;
  String? title;
  String? des;
  String? text;
  String? link;
  String? sku;
  dynamic? parentId;
  String? name;
  String? author;
  String? slug;
  double? price;
  double? salePrice;
  String? formattedPrice;
  String? formattedSalePrice;
  String? currency;
  String? currencySymbol;
  List<dynamic>? attributes;
  List<Categories>? categories;
  int? displayOrder;
  bool? hasOptions;
  bool? hasFields;
  List<Images>? images;
  bool? isDraft;
  int? quantity;
  bool? isInfinite;
  String? htmlUrl;
  Weight? weight;
  List<String>? keywords;
  bool? requiresShipping;
  bool? isTaxable;
  String? structure;
  Seo? seo;
  int? storeId;
  dynamic? soldProductsCount;
  String? createdAt;
  String? updatedAt;

  Items.fromJson(dynamic json) {
    id = json['id'].toString();
    des = json['des'];
    type = json['type'];
    sku = json['sku'];
    url = json['url'];
    parentId = json['parent_id'];
    name = json['name'];
    author = json[AppConfig.isSoreUseNewTheme ? 'name' : 'author'];
    slug = json['slug'];
    image = json['image'];
    text = json['text'];
    title = json['title'];
    link = AppConfig.isSoreUseNewTheme ? json['url'] : json['link'];
    formattedPrice = json['formatted_price'];
    formattedSalePrice = json['formatted_sale_price'];
    quantity = json['quantity'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    salePrice = checkDouble(json['sale_price'] ?? 0.0);
    price = checkDouble(json['price'] ?? 0.0);
    hasOptions = json['has_options'] ?? false;
    hasFields = json['has_fields'] ?? false;

    /*;
    currency = json['currency'];
    currencySymbol = json['currency_symbol'];
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add((v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    displayOrder = json['display_order'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add((v));
      });
    }
    isDraft = json['is_draft'];
    isInfinite = json['is_infinite'];
    htmlUrl = json['html_url'];
    weight = json['weight'] != null ? Weight.fromJson(json['weight']) : null;
    keywords = json['keywords'] != null ? json['keywords'].cast<String>() : [];
    requiresShipping = json['requires_shipping'];
    isTaxable = json['is_taxable'];
    structure = json['structure'];
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    storeId = json['store_id'];
    soldProductsCount = json['sold_products_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];*/
  }
}

class Seo {
  String? title;
  String? description;

  Seo({this.title, this.description});

  Seo.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
  }
}

class Weight {
  dynamic? value;
  String? unit;

  Weight({this.value, this.unit});

  Weight.fromJson(dynamic json) {
    value = json['value'];
    unit = json['unit'];
  }
}

class Categories {
  String? id;
  String? name;
  String? slug;
  String? description;
  dynamic? coverImage;
  dynamic? image;
  dynamic? displayOrder;

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
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    coverImage = json['cover_image'];
    image = json['image'];
    displayOrder = json['display_order'];
  }
}

class More_button {
  String? text;
  String? url;

  More_button({this.text, this.url});

  More_button.fromJson(dynamic json) {
    text = json['text'];
    url = json['url'];
  }
}

class FeaturedProducts {
  bool? display;
  String? url;
  String? title;
  String? id;
  More_button? moreButton;
  List<ProductDetailsModel>? items;

  FeaturedProducts.fromJson(dynamic json) {
    display = json['display'];
    url = json['url'];
    id = json['id'].toString();
    title = AppConfig.isSoreUseNewTheme ? json['name'] : json['title'];
    moreButton = json['more_button'] != null
        ? More_button.fromJson(json['more_button'])
        : null;
    if (json[AppConfig.isSoreUseNewTheme ? 'products' : 'items'] != null) {
      items = [];
      json[AppConfig.isSoreUseNewTheme ? 'products' : 'items'].forEach((v) {
        items?.add(ProductDetailsModel.fromJson(v));
      });
    }
  }
}

class StoreDescription {
  bool? display;
  String? image;
  Style? style;
  String? title;
  String? text;
  bool? showSocialMediaIcons;
  SocialMediaIcons? socialMediaIcons;

  StoreDescription(
      {this.display,
        this.image,
        this.style,
        this.title,
        this.text,
        this.showSocialMediaIcons,
        this.socialMediaIcons});

  StoreDescription.fromJson(dynamic json) {
    display = json['display'];
    image = json['image'];
    style = json['style'] != null ? Style.fromJson(json['style']) : null;
    title = json['title'];
    text = json['text'];
    showSocialMediaIcons = json['show_social_media_icons'];
    socialMediaIcons = json['social_media_icons'] != null
        ? SocialMediaIcons.fromJson(json['social_media_icons'])
        : null;
  }
}

class SocialMediaIcons {
  String? facebook;
  String? twitter;
  String? instagram;
  String? snapchat;
  String? maroof;
  dynamic? website;

  SocialMediaIcons(
      {this.facebook,
        this.twitter,
        this.instagram,
        this.snapchat,
        this.maroof,
        this.website});

  SocialMediaIcons.fromJson(dynamic json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    snapchat = json['snapchat'];
    maroof = json['maroof'];
    website = json['website'];
  }
}

class Style {
  String? foregroundColor;
  String? backgroundColor;

  Style({this.foregroundColor, this.backgroundColor});

  Style.fromJson(dynamic json) {
    foregroundColor = json['foreground_color'];
    backgroundColor = json['background_color'];
  }
}

class PromotionImage {
  bool? display;
  String? image;
  String? title;
  String? text;
  String? buttonText;
  String? link;

  PromotionImage(
      {this.display,
        this.image,
        this.title,
        this.text,
        this.buttonText,
        this.link});

  PromotionImage.fromJson(dynamic json) {
    display = json['display'];
    image = json['image'];
    title = json['title'];
    text = json['text'];
    buttonText = json['button_text'];
    link = json['link'];
  }
}

class Slider {
  bool? display;
  List<Items> items = [];

  Slider.fromJson(dynamic json) {
    display = json['display'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
  }
}