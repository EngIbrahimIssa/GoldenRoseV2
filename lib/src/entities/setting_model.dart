import 'dart:developer';

import 'package:entaj/src/utils/functions.dart';

import '../../main.dart';
import 'category_model.dart';

class SettingModel {
  Header? header;
  Footer? footer;
  Settings? settings;

  SettingModel.fromJson(dynamic json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    footer = json['footer'] != null ? Footer.fromJson(json['footer']) : null;
    settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }

}

class Settings {
  int? id;
  String? uuid;
  String? name;
  String? permalink;
  Currency? currency;
  List<Currencies>? currencies;
  Language? language;
  List<Languages>? languages;
  String? phone;
  String? email;
  String? logo;
  String? cover;
  String? icon;
  String? metaTitle;
  String? description;
  Head_scripts? headScripts;
  Head_scripts_apps? headScriptsApps;
  List<dynamic>? googleMaps;
  int? maintenanceMode;
  int? hasNewProductsService;
  bool? isLowStockLabelEnabled;
  bool? isProductReviewsEnabled;
  bool? isDifferentConsigneeAllowed;
  int? lowStockQuantityLimit;
  bool? customersLoginByEmailStatus;
  One_signal_keys? oneSignalKeys;
  Vat_settings? vatSettings;
  String? commercialRegistrationNumber;
  String? commercialRegistrationNumberActivation;
  dynamic? isTamaraProductWidgetEnabled;
  List<dynamic>? tamaraSupportedCurrencies;
  bool? isApplePayEnabled;
  Availability? availability;
  dynamic? storefrontTheme;
  Theme? theme;

  Settings.fromJson(dynamic json) {


    log(json['currencies'].toString());
    if (json['currencies'] != null) {
      currencies = [];
      json['currencies'].forEach((v) {
        currencies?.add(Currencies.fromJson(v));
      });
    }

/*
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    permalink = json['permalink'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;

    language = json['language'] != null ? Language.fromJson(json['language']) : null;

    phone = json['phone'];
    email = json['email'];
    logo = json['logo'];
    cover = json['cover'];
    icon = json['icon'];
    metaTitle = json['meta_title'];
    description = json['description'];
    headScripts = json['head_scripts'] != null ? Head_scripts.fromJson(json['head_scripts']) : null;
    headScriptsApps = json['head_scripts_apps'] != null ? Head_scripts_apps.fromJson(json['head_scripts_apps']) : null;
    if (json['google_maps'] != null) {
      googleMaps = [];
      json['google_maps'].forEach((v) {
        googleMaps?.add((v));
      });
    }
    maintenanceMode = json['maintenance_mode'];
    hasNewProductsService = json['has_new_products_service'];
    isLowStockLabelEnabled = json['is_low_stock_label_enabled'];
    isProductReviewsEnabled = json['is_product_reviews_enabled'];
    isDifferentConsigneeAllowed = json['is_different_consignee_allowed'];
    lowStockQuantityLimit = json['low_stock_quantity_limit'];
    oneSignalKeys = json['one_signal_keys'] != null ? One_signal_keys.fromJson(json['one_signal_keys']) : null;
*/
    customersLoginByEmailStatus = json['customers_login_by_email_status'];
    vatSettings = json['vat_settings'] != null ? Vat_settings.fromJson(json['vat_settings']) : null;
    commercialRegistrationNumber = json['commercial_registration_number'];
    commercialRegistrationNumberActivation = json['commercial_registration_number_activation'];
/*
    isTamaraProductWidgetEnabled = json['is_tamara_product_widget_enabled'];
    if (json['tamara_supported_currencies'] != null) {
      tamaraSupportedCurrencies = [];
      json['tamara_supported_currencies'].forEach((v) {
        tamaraSupportedCurrencies?.add((v));
      });
    }
    isApplePayEnabled = json['is_apple_pay_enabled'];
    availability = json['availability'] != null ? Availability.fromJson(json['availability']) : null;
    storefrontTheme = json['storefront_theme'];
    theme = json['theme'] != null ? Theme.fromJson(json['theme']) : null;
*/
  }


}

class Theme {
  String? code;
  Colors? colors;
  Custom? custom;

  Theme({
      this.code, 
      this.colors, 
      this.custom});

  Theme.fromJson(dynamic json) {
    code = json['code'];
    colors = json['colors'] != null ? Colors.fromJson(json['colors']) : null;
    custom = json['custom'] != null ? Custom.fromJson(json['custom']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = code;
    if (colors != null) {
      map['colors'] = colors?.toJson();
    }
    if (custom != null) {
      map['custom'] = custom?.toJson();
    }
    return map;
  }

}

class Custom {
  Css? css;

  Custom({
      this.css});

  Custom.fromJson(dynamic json) {
    css = json['css'] != null ? Css.fromJson(json['css']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (css != null) {
      map['css'] = css?.toJson();
    }
    return map;
  }

}

class Css {
  dynamic? embedded;
  dynamic? url;

  Css({
      this.embedded, 
      this.url});

  Css.fromJson(dynamic json) {
    embedded = json['embedded'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['embedded'] = embedded;
    map['url'] = url;
    return map;
  }

}

class Colors {
  Buttons? buttons;

  Colors({
      this.buttons});

  Colors.fromJson(dynamic json) {
    buttons = json['buttons'] != null ? Buttons.fromJson(json['buttons']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (buttons != null) {
      map['buttons'] = buttons?.toJson();
    }
    return map;
  }

}

class Buttons {
  String? btnDefaultBackgroundColor;
  String? btnDefaultTextColor;
  String? btnDefaultBorderColor;
  String? btnHoverBackgroundColor;
  String? btnPressedBackgroundColor;
  String? btnPressedTextColor;
  String? btnPressedBorderColor;

  Buttons({
      this.btnDefaultBackgroundColor, 
      this.btnDefaultTextColor, 
      this.btnDefaultBorderColor, 
      this.btnHoverBackgroundColor, 
      this.btnPressedBackgroundColor, 
      this.btnPressedTextColor, 
      this.btnPressedBorderColor});

  Buttons.fromJson(dynamic json) {
    btnDefaultBackgroundColor = json['btn_default_background_color'];
    btnDefaultTextColor = json['btn_default_text_color'];
    btnDefaultBorderColor = json['btn_default_border_color'];
    btnHoverBackgroundColor = json['btn_hover_background_color'];
    btnPressedBackgroundColor = json['btn_pressed_background_color'];
    btnPressedTextColor = json['btn_pressed_text_color'];
    btnPressedBorderColor = json['btn_pressed_border_color'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['btn_default_background_color'] = btnDefaultBackgroundColor;
    map['btn_default_text_color'] = btnDefaultTextColor;
    map['btn_default_border_color'] = btnDefaultBorderColor;
    map['btn_hover_background_color'] = btnHoverBackgroundColor;
    map['btn_pressed_background_color'] = btnPressedBackgroundColor;
    map['btn_pressed_text_color'] = btnPressedTextColor;
    map['btn_pressed_border_color'] = btnPressedBorderColor;
    return map;
  }

}

class Availability {
  bool? isStoreClosed;
  String? closingType;
  String? closingTimeType;
  bool? closedNow;
  Activating_data? activatingData;
  Closing_data? closingData;
  bool? notifyCustomer;
  bool? isTimeCounterDisplayed;
  bool? isAvailableHoursVisible;
  Title? title;
  Message? message;
  Times? times;

  Availability({
      this.isStoreClosed, 
      this.closingType, 
      this.closingTimeType, 
      this.closedNow, 
      this.activatingData, 
      this.closingData, 
      this.notifyCustomer, 
      this.isTimeCounterDisplayed, 
      this.isAvailableHoursVisible, 
      this.title, 
      this.message, 
      this.times});

  Availability.fromJson(dynamic json) {
    isStoreClosed = json['is_store_closed'];
    closingType = json['closing_type'];
    closingTimeType = json['closing_time_type'];
    closedNow = json['closed_now'];
    activatingData = json['activating_data'] != null ? Activating_data.fromJson(json['activatingData']) : null;
    closingData = json['closing_data'] != null ? Closing_data.fromJson(json['closingData']) : null;
    notifyCustomer = json['notify_customer'];
    isTimeCounterDisplayed = json['is_time_counter_displayed'];
    isAvailableHoursVisible = json['is_available_hours_visible'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
    times = json['times'] != null ? Times.fromJson(json['times']) : null;
  }

}

class Times {
  Monday? monday;
  Tuesday? tuesday;

  Times({
      this.monday, 
      this.tuesday});

  Times.fromJson(dynamic json) {
    monday = json['Monday'] != null ? Monday.fromJson(json['Monday']) : null;
    tuesday = json['Tuesday'] != null ? Tuesday.fromJson(json['Tuesday']) : null;
  }

}

class Tuesday {
  Period_1? period1;

  Tuesday({
      this.period1});

  Tuesday.fromJson(dynamic json) {
    period1 = json['period_1'] != null ? Period_1.fromJson(json['period1']) : null;
  }


}

class Monday {
  Period_1? period1;
  Period_2? period2;

  Monday.fromJson(dynamic json) {
    period1 = json['period_1'] != null ? Period_1.fromJson(json['period1']) : null;
    period2 = json['period_2'] != null ? Period_2.fromJson(json['period2']) : null;
  }

}

class Period_2 {
  String? from;
  String? to;

  Period_2({
      this.from, 
      this.to});

  Period_2.fromJson(dynamic json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['from'] = from;
    map['to'] = to;
    return map;
  }

}

class Period_1 {
  String? from;
  String? to;

  Period_1.fromJson(dynamic json) {
    from = json['from'];
    to = json['to'];
  }

}

class Message {
  String? ar;
  String? en;

  Message.fromJson(dynamic json) {
    ar = json['ar'];
    en = json['en'];
  }

}

class Title {
  String? ar;
  String? en;

  Title.fromJson(dynamic json) {
    ar = isArabicLanguage ?  json['ar'] : json['en'] ?? json['ar'];
    en = json['en'];
  }
}

class Closing_data {
  dynamic? date;
  dynamic? time;
  dynamic? dayName;
  dynamic? remainingMonths;
  dynamic? remainingDays;
  dynamic? remainingHours;
  dynamic? remainingMinutes;


  Closing_data.fromJson(dynamic json) {
    date = json['date'];
    time = json['time'];
    dayName = json['day_name'];
    remainingMonths = json['remaining_months'];
    remainingDays = json['remaining_days'];
    remainingHours = json['remaining_hours'];
    remainingMinutes = json['remaining_minutes'];
  }

}

class Activating_data {
  dynamic? date;
  dynamic? time;
  dynamic? dayName;
  dynamic? remainingMonths;
  dynamic? remainingDays;
  dynamic? remainingHours;
  dynamic? remainingMinutes;

  Activating_data({
      this.date, 
      this.time, 
      this.dayName, 
      this.remainingMonths, 
      this.remainingDays, 
      this.remainingHours, 
      this.remainingMinutes});

  Activating_data.fromJson(dynamic json) {
    date = json['date'];
    time = json['time'];
    dayName = json['day_name'];
    remainingMonths = json['remaining_months'];
    remainingDays = json['remaining_days'];
    remainingHours = json['remaining_hours'];
    remainingMinutes = json['remaining_minutes'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['date'] = date;
    map['time'] = time;
    map['day_name'] = dayName;
    map['remaining_months'] = remainingMonths;
    map['remaining_days'] = remainingDays;
    map['remaining_hours'] = remainingHours;
    map['remaining_minutes'] = remainingMinutes;
    return map;
  }

}

class Vat_settings {
  String? id;
  Country? country;
  double? taxPercentage;
  String? vatNumber;
  String? taxRegistrationCertificate;
  List<dynamic>? settings;
  bool? isCertificateVisible;
  bool? isVatNumberVisible;
  bool? canUseVat;
  bool? vatActivate;
  bool? isVatSelfPaid;
  bool? isVatIncludedInProductPrice;
  bool? isShippingFeeIncludedInVat;
  double? otherCountriesTaxPercentage;

  Vat_settings({
      this.id, 
      this.country, 
      this.taxPercentage, 
      this.vatNumber, 
      this.taxRegistrationCertificate, 
      this.settings, 
      this.isCertificateVisible, 
      this.isVatNumberVisible, 
      this.canUseVat, 
      this.vatActivate, 
      this.isVatSelfPaid, 
      this.isVatIncludedInProductPrice, 
      this.isShippingFeeIncludedInVat, 
      this.otherCountriesTaxPercentage});

  Vat_settings.fromJson(dynamic json) {
   /* id = json['id'];
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
    taxPercentage = json['tax_percentage'];
  */  vatNumber = json['vat_number'];
    taxRegistrationCertificate = json['tax_registration_certificate'];
 /*   if (json['settings'] != null) {
      settings = [];
      json['settings'].forEach((v) {
        settings?.add((v));
      });
    }
    isCertificateVisible = json['is_certificate_visible'];
    isVatNumberVisible = json['is_vat_number_visible'];
    canUseVat = json['can_use_vat'];
    vatActivate = json['vat_activate'];
    isVatSelfPaid = json['is_vat_self_paid'];
    isVatIncludedInProductPrice = json['is_vat_included_in_product_price'];
    isShippingFeeIncludedInVat = json['is_shipping_fee_included_in_vat'];
    otherCountriesTaxPercentage = json['other_countries_tax_percentage'];
*/  }

}

class Country {
  int? id;
  String? name;
  String? isoCode2;
  String? isoCode3;

  Country({
      this.id, 
      this.name, 
      this.isoCode2, 
      this.isoCode3});

  Country.fromJson(dynamic json) {
    id = json['id'];
    name = getLabelInString(json['name']);
    isoCode2 = json['iso_code_2'];
    isoCode3 = json['iso_code_3'];
  }


}

class Name {
  String? ar;
  String? en;


  Name.fromJson(dynamic json) {
    ar = isArabicLanguage ?  json['ar'] : json['en'] ?? json['ar'];
    en = json['en'];
  }


}

class One_signal_keys {
  String? appId;
  String? appKey;
  dynamic? androidPackageName;
  dynamic? iosAppId;

  One_signal_keys({
      this.appId, 
      this.appKey, 
      this.androidPackageName, 
      this.iosAppId});

  One_signal_keys.fromJson(dynamic json) {
    appId = json['app_id'];
    appKey = json['app_key'];
    androidPackageName = json['android_package_name'];
    iosAppId = json['ios_app_id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['app_id'] = appId;
    map['app_key'] = appKey;
    map['android_package_name'] = androidPackageName;
    map['ios_app_id'] = iosAppId;
    return map;
  }

}

class Head_scripts_apps {
  Snapchat_pixel? snapchatPixel;
  bool? globalHeadScript;
  Livechat? livechat;
  Linkarabydb? linkarabydb;
  Tidio? tidio;
  Intercom? intercom;
  Crisp? crisp;
  Chatbot? chatbot;
  Crazyegg? crazyegg;
  Zendesk? zendesk;
  Tawkto? tawkto;
  Smartarget? smartarget;
  Google_analytics? googleAnalytics;
  Drdsh? drdsh;
  Landbotio? landbotio;
  bool? purchaseEvent;

  Head_scripts_apps({
      this.snapchatPixel, 
      this.globalHeadScript, 
      this.livechat, 
      this.linkarabydb, 
      this.tidio, 
      this.intercom, 
      this.crisp, 
      this.chatbot, 
      this.crazyegg, 
      this.zendesk, 
      this.tawkto, 
      this.smartarget, 
      this.googleAnalytics, 
      this.drdsh, 
      this.landbotio, 
      this.purchaseEvent});

  Head_scripts_apps.fromJson(dynamic json) {
    snapchatPixel = json['snapchat_pixel'] != null ? Snapchat_pixel.fromJson(json['snapchatPixel']) : null;
    globalHeadScript = json['global_head_script'];
    livechat = json['livechat'] != null ? Livechat.fromJson(json['livechat']) : null;
    linkarabydb = json['linkarabydb'] != null ? Linkarabydb.fromJson(json['linkarabydb']) : null;
    tidio = json['tidio'] != null ? Tidio.fromJson(json['tidio']) : null;
    intercom = json['intercom'] != null ? Intercom.fromJson(json['intercom']) : null;
    crisp = json['crisp'] != null ? Crisp.fromJson(json['crisp']) : null;
    chatbot = json['chatbot'] != null ? Chatbot.fromJson(json['chatbot']) : null;
    crazyegg = json['crazyegg'] != null ? Crazyegg.fromJson(json['crazyegg']) : null;
    zendesk = json['zendesk'] != null ? Zendesk.fromJson(json['zendesk']) : null;
    tawkto = json['tawkto'] != null ? Tawkto.fromJson(json['tawkto']) : null;
    smartarget = json['smartarget'] != null ? Smartarget.fromJson(json['smartarget']) : null;
    googleAnalytics = json['google_analytics'] != null ? Google_analytics.fromJson(json['googleAnalytics']) : null;
    drdsh = json['drdsh'] != null ? Drdsh.fromJson(json['drdsh']) : null;
    landbotio = json['landbotio'] != null ? Landbotio.fromJson(json['landbotio']) : null;
    purchaseEvent = json['purchase_event'];
  }


}

class Landbotio {
  Params? params;
  String? globalHeadScript;
  String? purchaseEvent;

  Landbotio.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
    purchaseEvent = json['purchase_event'];
  }


}


class Drdsh {
  Params? params;
  String? globalHeadScript;

  Drdsh({
      this.params, 
      this.globalHeadScript});

  Drdsh.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
  }


}

class Params {
  String? drdshParams;
  String? googleAnalyticsParams;
  String? smartargetParams;
  String? tawktoParams;
  String? zendeskParams;
  String? crazyeggParams;
  String? chatbotParams;
  String? landbotioParams;
  String? crispParams;
  String? intercomParams;
  String? tidioParams;
  String? linkarabydbParams;
  String? livechatParams;
  String? snapchatPixelParams;


  Params.fromJson(dynamic json) {
    googleAnalyticsParams = json['google_analytics_params'];
    smartargetParams = json['smartarget_params'];
    drdshParams = json['drdsh_params'];
    tawktoParams = json['tawkto_params'];
    zendeskParams = json['zendesk_params'];
    crazyeggParams = json['crazyegg_params'];
    chatbotParams = json['chatbotParams'];
    landbotioParams = json['landbotio_params'];
    crispParams = json['crisp_params'];
    intercomParams = json['intercom_params'];
    tidioParams = json['tidio_params'];
    linkarabydbParams = json['linkarabydb_params'];
    livechatParams = json['livechat_params'];
    snapchatPixelParams = json['snapchat_pixel_params'];
  }
}

class Google_analytics {
  Params? params;

  Google_analytics({
      this.params});

  Google_analytics.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
  }

}

class Smartarget {
  Params? params;
  String? globalHeadScript;

  Smartarget({
      this.params, 
      this.globalHeadScript});

  Smartarget.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
  }


}

class Tawkto {
  Params? params;
  String? globalHeadScript;

  Tawkto({
      this.params, 
      this.globalHeadScript});

  Tawkto.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
  }

}

class Zendesk {
  Params? params;
  String? globalHeadScript;

  Zendesk({
      this.params, 
      this.globalHeadScript});

  Zendesk.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
  }



}

class Crazyegg {
  Params? params;
  String? globalHeadScript;

  Crazyegg.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
  }

}


class Chatbot {
  Params? params;
  String? globalHeadScript;


  Chatbot.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
  }

}


class Crisp {
  Params? params;
  String? globalHeadScript;


  Crisp.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
  }
}

class Intercom {
  Params? params;
  String? globalHeadScript;


  Intercom.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
  }


}


class Tidio {
  Params? params;
  String? globalHeadScript;

  Tidio.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
  }
}

class Linkarabydb {
  Params? params;
  String? globalHeadScript;

  Linkarabydb.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
  }


}

class Livechat {
  Params? params;
  String? globalHeadScript;

  Livechat({
      this.params, 
      this.globalHeadScript});

  Livechat.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
  }

}

class Snapchat_pixel {
  Params? params;
  String? globalHeadScript;

  Snapchat_pixel({
      this.params, 
      this.globalHeadScript});

  Snapchat_pixel.fromJson(dynamic json) {
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    globalHeadScript = json['global_head_script'];
  }

}


class Head_scripts {
  String? snapchatPixel;
  String? livechat;
  String? linkarabydb;
  String? tidio;
  String? intercom;
  String? crisp;
  String? chatbot;
  String? crazyegg;
  String? zendesk;
  String? tawkto;
  String? smartarget;
  String? googleAnalytics;
  String? drdsh;
  String? landbotio;

  Head_scripts({
      this.snapchatPixel, 
      this.livechat, 
      this.linkarabydb, 
      this.tidio, 
      this.intercom, 
      this.crisp, 
      this.chatbot, 
      this.crazyegg, 
      this.zendesk, 
      this.tawkto, 
      this.smartarget, 
      this.googleAnalytics, 
      this.drdsh, 
      this.landbotio});

  Head_scripts.fromJson(dynamic json) {
    snapchatPixel = json['snapchat_pixel'];
    livechat = json['livechat'];
    linkarabydb = json['linkarabydb'];
    tidio = json['tidio'];
    intercom = json['intercom'];
    crisp = json['crisp'];
    chatbot = json['chatbot'];
    crazyegg = json['crazyegg'];
    zendesk = json['zendesk'];
    tawkto = json['tawkto'];
    smartarget = json['smartarget'];
    googleAnalytics = json['google_analytics'];
    drdsh = json['drdsh'];
    landbotio = json['landbotio'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['snapchat_pixel'] = snapchatPixel;
    map['livechat'] = livechat;
    map['linkarabydb'] = linkarabydb;
    map['tidio'] = tidio;
    map['intercom'] = intercom;
    map['crisp'] = crisp;
    map['chatbot'] = chatbot;
    map['crazyegg'] = crazyegg;
    map['zendesk'] = zendesk;
    map['tawkto'] = tawkto;
    map['smartarget'] = smartarget;
    map['google_analytics'] = googleAnalytics;
    map['drdsh'] = drdsh;
    map['landbotio'] = landbotio;
    return map;
  }

}

class Languages {
  int? id;
  String? name;
  String? code;

  Languages({
      this.id, 
      this.name, 
      this.code});

  Languages.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    return map;
  }

}

class Language {
  int? id;
  String? name;
  String? code;

  Language({
      this.id, 
      this.name, 
      this.code});

  Language.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    return map;
  }

}

class Currencies {
  int? id;
  String? name;
  String? code;
  String? symbol;
  Country? country;

  Currencies({
      this.id, 
      this.name, 
      this.code, 
      this.symbol, 
      this.country});

  Currencies.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];

    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }



}

class Currency {
  int? id;
  String? name;
  String? code;
  String? symbol;
  Country? country;

  Currency({
      this.id, 
      this.name, 
      this.code, 
      this.symbol, 
      this.country});

  Currency.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }



}

class Footer {
  About_us? aboutUs;
  Links? links;
  Business_location? businessLocation;
  Social_media? socialMedia;
  List<PaymentMethods>? paymentMethods;
  List<Shipping_methods>? shippingMethods;


  Footer.fromJson(dynamic json) {
    aboutUs = json['about_us'] != null ? About_us.fromJson(json['about_us']) : null;
    socialMedia = json['social_media'] != null ? Social_media.fromJson(json['social_media']) : null;
    if (json['payment_methods'] != null) {
      paymentMethods = [];
      json['payment_methods'].forEach((v) {
        paymentMethods?.add(PaymentMethods.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    if (json['shipping_methods'] != null) {
      shippingMethods = [];
      json['shipping_methods'].forEach((v) {
        shippingMethods?.add(Shipping_methods.fromJson(v));
      });
    }
/*
    businessLocation = json['business_location'] != null ? Business_location.fromJson(json['business_location']) : null;

    if (json['shipping_methods'] != null) {
      shippingMethods = [];
      json['shipping_methods'].forEach((v) {
        shippingMethods?.add(Shipping_methods.fromJson(v));
      });
    }
*/
  }

}

class Shipping_methods {
  String? name;
  String? icon;

  Shipping_methods({
      this.name, 
      this.icon});

  Shipping_methods.fromJson(dynamic json) {
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['icon'] = icon;
    return map;
  }

}

class PaymentMethods {
  String? name;
  String? icon;

  PaymentMethods.fromJson(dynamic json) {
    name = json['name'];
    icon = json['icon'];
  }

}

class Social_media {
  String? title;
  Items? items;

  Social_media.fromJson(dynamic json) {
    title = json['title'];
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
  }


}

class Items {
  String? facebook;
  String? twitter;
  String? instagram;
  String? snapchat;
  String? maroof;
  String? website;
  String? phone;
  String? email;
  int? id;
  bool? isSystemPage;
  bool? enabled;
  String? name;
  String? url;
  String? slug;

  Items.fromJson(dynamic json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    snapchat = json['snapchat'];
    maroof = json['maroof'];
    website = json['website'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    isSystemPage = json['is_system_page'];
    enabled = json['enabled'];
    name = json['name'];
    url = json['url'];
    slug = json['slug'];
  }

}

class Business_location {
  Country? country;
  City? city;
  String? district;
  String? street;
  dynamic? buildingNo;
  dynamic? postalCode;
  dynamic? additionalPostalCode;
  String? lat;
  String? lng;
  bool? showLocation;

  Business_location.fromJson(dynamic json) {
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

}

class City {
  int? id;
  String? name;
  int? priority;
  int? countryId;
  String? countryName;
  String? countryCode;
  String? arName;
  String? enName;

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

}

class Links {
  bool? enabled;
  String? title;
  List<Items>? items;

  Links({
      this.enabled, 
      this.title, 
      this.items});

  Links.fromJson(dynamic json) {
    enabled = json['enabled'];
    title = json['title'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }

}


class About_us {
  bool? enabled;
  String? title;
  String? text;

  About_us.fromJson(dynamic json) {
    enabled = json['enabled'];
    title = json['title'];
    text = json['text'];
  }

}

class Header {
  AnnouncementBar? announcementBar;
  Logo? logo;
  Menu? menu;
  Cart? cart;

  Header.fromJson(dynamic json) {
    announcementBar = json['announcement_bar'] != null ? AnnouncementBar.fromJson(json['announcement_bar']) : null;
    logo = json['logo'] != null ? Logo.fromJson(json['logo']) : null;
    menu = json['menu'] != null ? Menu.fromJson(json['menu']) : null;
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
  }


}

class Cart {
  int? count;
  bool? isReserved;

  Cart.fromJson(dynamic json) {
    count = json['count'];
    isReserved = json['is_reserved'];
  }


}

class Menu {
  List<CategoryModel>? items;

  Menu.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(CategoryModel.fromJson(v));
      });
    }
  }


}

class Logo {
  String? title;
  String? image;

  Logo.fromJson(dynamic json) {
    title = json['title'];
    image = json['image'];
  }


}

class AnnouncementBar {
  bool? enabled;
  bool? displayInHomepage;
  bool? displayInAllPages;
  String? text;
  String? link;
  Style? style;

  AnnouncementBar.fromJson(dynamic json) {
    enabled = json['enabled'];
    displayInHomepage = json['display_in_homepage'];
    displayInAllPages = json['display_in_all_pages'];
    text = json['text'];
    link = json['link'];
    style = json['style'] != null ? Style.fromJson(json['style']) : null;
  }

}

class Style {
  String? foregroundColor;
  String? backgroundColor;

  Style.fromJson(dynamic json) {
    foregroundColor = json['foreground_color'];
    backgroundColor = json['background_color'];
  }


}