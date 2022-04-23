import 'module_model.dart';

class HomeScreenOldThemeModel {

  HomeScreenOldThemeModel.fromJson(dynamic json) {
    status = json['status'];
    payload = json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
  }
  String? status;
  Payload? payload;
  Message? message;

}

class Message {

  Message.fromJson(dynamic json) {
    type = json['type'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
  }
  String? type;
  dynamic code;
  dynamic name;
  dynamic description;


}

class Payload {

  Payload.fromJson(dynamic json) {
    if (json['files'] != null) {
      files = [];
      json['files'].forEach((v) {
        files?.add(Files.fromJson(v));
      });
    }
    assetsUrl = json['assets_url'];
    menu = json['menu'] != null ? Menu.fromJson(json['menu']) : null;
    pages = json['pages'] != null ? json['pages'].cast<String>() : [];
    businessLocation = json['business_location'] != null ? BusinessLocation.fromJson(json['business_location']) : null;
    socialMedia = json['social_media'] != null ? SocialMedia.fromJson(json['social_media']) : null;
    if (json['payment_methods'] != null) {
      paymentMethods = [];
      json['payment_methods'].forEach((v) {
        paymentMethods?.add(PaymentMethods.fromJson(v));
      });
    }
    if (json['shipping_methods'] != null) {
      shippingMethods = [];
      json['shipping_methods'].forEach((v) {
        shippingMethods?.add(ShippingMethods.fromJson(v));
      });
    }
    colors = json['colors'] != null ? Colors.fromJson(json['colors']) : null;
    customCssUrl = json['custom_css_url'];
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
  }
  List<Files>? files;
  String? assetsUrl;
  Menu? menu;
  List<String>? pages;
  BusinessLocation? businessLocation;
  SocialMedia? socialMedia;
  List<PaymentMethods>? paymentMethods;
  List<ShippingMethods>? shippingMethods;
  Colors? colors;
  String? customCssUrl;
  Cart? cart;


}

class Cart {

  Cart.fromJson(dynamic json) {
    isReserved = json['is_reserved'];
  }
  bool? isReserved;

}

class Colors {


  Colors.fromJson(dynamic json) {
    btnDefaultBackgroundColor = json['btn_default_background_color'];
    btnDefaultTextColor = json['btn_default_text_color'];
    btnDefaultBorderColor = json['btn_default_border_color'];
    btnHoverBackgroundColor = json['btn_hover_background_color'];
    btnPressedBackgroundColor = json['btn_pressed_background_color'];
    btnPressedTextColor = json['btn_pressed_text_color'];
    btnPressedBorderColor = json['btn_pressed_border_color'];
  }
  String? btnDefaultBackgroundColor;
  String? btnDefaultTextColor;
  String? btnDefaultBorderColor;
  String? btnHoverBackgroundColor;
  String? btnPressedBackgroundColor;
  String? btnPressedTextColor;
  String? btnPressedBorderColor;

}

class ShippingMethods {

  ShippingMethods.fromJson(dynamic json) {
    name = json['name'];
    icon = json['icon'];
  }
  String? name;
  String? icon;


}

class PaymentMethods {

  PaymentMethods.fromJson(dynamic json) {
    name = json['name'];
    icon = json['icon'];
  }
  String? name;
  String? icon;


}

class SocialMedia {

  SocialMedia.fromJson(dynamic json) {
    title = json['title'];
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
  }
  String? title;
  Items? items;

}


class BusinessLocation {

  BusinessLocation.fromJson(dynamic json) {
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    district = json['district'];
    street = json['street'];
    buildingNo = json['building_no'];
    postalCode = json['postal_code'];
    additionalPostalCode = json['additional_postal_code'];
    lat = json['lat'];
    lng = json['lng'];
    showLocation = json['show_location'];
  }
  Country? country;
  City? city;
  String? district;
  dynamic street;
  String? buildingNo;
  dynamic postalCode;
  dynamic additionalPostalCode;
  dynamic lat;
  dynamic lng;
  bool? showLocation;


}

class City {

  City.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    priority = json['priority'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    countryCode = json['country_code'];
    arName = json['ar_name'];
    enName = json['en_name'];
  }

  int? id;
  String? name;
  int? priority;
  int? countryId;
  String? countryName;
  String? countryCode;
  String? arName;
  String? enName;

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

class Menu {
  List<Items>? items;

  Menu.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }

}

class Items {

  int? id;
  String? name;
  String? slug;
  String? sEOCategoryTitle;
  String? sEOCategoryDescription;
  dynamic description;
  String? url;
  dynamic image;
  dynamic imgAltText;
  dynamic coverImage;
  int? productsCount;
  dynamic parentId;
  bool? isPublished;

  dynamic facebook;
  String? twitter;
  String? instagram;
  dynamic snapchat;
  dynamic maroof;
  dynamic website;
  String? phone;
  String? email;


  Items.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    sEOCategoryTitle = json['SEO_category_title'];
    sEOCategoryDescription = json['SEO_category_description'];
    description = json['description'];
    url = json['url'];
    image = json['image'];
    imgAltText = json['img_alt_text'];
    coverImage = json['cover_image'];
    productsCount = json['products_count'];
    parentId = json['parent_id'];
    isPublished = json['is_published'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    snapchat = json['snapchat'];
    maroof = json['maroof'];
    website = json['website'];
    phone = json['phone'];
    email = json['email'];
  }
}

class Files {

  String? id;
  String? name;
  String? themeId;
  String? content;
  String? folder;
  dynamic path;
  dynamic config;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<ModuleModel>? modules;

  Files.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    themeId = json['theme_id'];
    content = json['content'];
    folder = json['folder'];
    path = json['path'];
    config = json['config'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['modules'] != null) {
      modules = [];
      json['modules'].forEach((v) {
        modules?.add(ModuleModel.fromJson(v , name));
      });
    }
  }


}