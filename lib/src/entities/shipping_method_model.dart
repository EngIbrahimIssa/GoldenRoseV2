import '../../main.dart';

class ShippingMethodModel {
  int? id;
  String? name;
  int? cost;
  String? costString;
  int? insidePickupCitiesCost;
  String? insidePickupCitiesCostString;
  int? outsidePickupCitiesCost;
  String? outsidePickupCitiesCostString;
  bool? serviceEnabled;
  bool? isSystemOption;
  bool? isServiceApproved;
  bool? isFulfillmentDriver;
  bool? isCustomizableDriver;
  bool? hasManualActivation;
  String? manualActivationUrl;
  int? isCustomizableCosts;
  String? systemOptionCode;
  bool? isWeightEnabled;
  Courier? courier;
  bool? codAvailable;
  bool? codEnabled;
  List<City>? codCities;
  int? codFee;
  String? codFeeString;
  List<City>? availableCities;
  List<City>? selectCities;
  List<City>? pickupCities;
  List<dynamic>? tier1Cities;
  List<dynamic>? tier2Cities;
  String? deliveryEstimatedTime;
  DeliveryEstimatedTimes? deliveryEstimatedTimes;
  Terms? terms;
  List<Information>? information;
  String? agreementUrl;
  String? serviceIcon;
  String? iconForCart;
  dynamic? courierIcons;
  Meta? meta;
  Meta? metaForCart;

  ShippingMethodModel.fromJson(dynamic json) {
    id = json['id'];
    //   cost = json['cost'];
    costString = json['cost_string'];
    //insidePickupCitiesCost = json['inside_pickup_cities_cost'];
    insidePickupCitiesCostString = json['inside_pickup_cities_cost_string'];
    //outsidePickupCitiesCost = json['outside_pickup_cities_cost'];
    outsidePickupCitiesCostString = json['outside_pickup_cities_cost_string'];
    serviceEnabled = json['service_enabled'];
    isSystemOption = json['is_system_option'];
    isServiceApproved = json['is_service_approved'];
    isFulfillmentDriver = json['is_fulfillment_driver'];
    isCustomizableDriver = json['is_customizable_driver'];
    hasManualActivation = json['has_manual_activation'];
    manualActivationUrl = json['manual_activation_url'];
    //isCustomizableCosts = json['is_customizable_costs'];
    systemOptionCode = json['system_option_code'];
    isWeightEnabled = json['is_weight_enabled'];
  //  courier = json['courier'] != null ? Courier.fromJson(json['courier']) : null;
    name =  (isArabicLanguage ? courier?.driverArName : courier?.driverEnName )?? json['name'];
    codAvailable = json['cod_available'];
    codEnabled = json['cod_enabled'];
    if (json['cod_cities'] != null) {
      codCities = [];
      json['cod_cities'].forEach((v) {
        codCities?.add(City.fromJson(v));
      });
    }
    //codFee = json['cod_fee'];
    codFeeString = json['cod_fee_string'];
    if (json['available_cities'] != null) {
      availableCities = [];
      json['available_cities'].forEach((v) {
        availableCities?.add(City.fromJson(v));
      });
    }
    if (json['select_cities'] != null) {
      selectCities = [];
      json['select_cities'].forEach((v) {
        selectCities?.add(City.fromJson(v));
      });
    }
    if (json['pickup_cities'] != null) {
      pickupCities = [];
      json['pickup_cities'].forEach((v) {
        pickupCities?.add(City.fromJson(v));
      });
    }
/*    if (json['tier_1_cities'] != null) {
      tier1Cities = [];
      json['tier_1_cities'].forEach((v) {
        tier1Cities?.add(dynamic.fromJson(v));
      });
    }
    if (json['tier_2_cities'] != null) {
      tier2Cities = [];
      json['tier_2_cities'].forEach((v) {
        tier2Cities?.add(dynamic.fromJson(v));
      });
    }*/
    deliveryEstimatedTime = json['delivery_estimated_time'];
    deliveryEstimatedTimes = json['delivery_estimated_times'] != null
        ? DeliveryEstimatedTimes.fromJson(json['delivery_estimated_times'])
        : null;
    terms = json['terms'] != null ? Terms.fromJson(json['terms']) : null;
/*    if (json['information'] != null) {
      information = [];
      json['information'].forEach((v) {
        information?.add(Information.fromJson(v));
      });
    }*/
    agreementUrl = json['agreement_url'];
    serviceIcon = json['service_icon'];
    iconForCart = json['icon_for_cart'];
    courierIcons = json['courier_icons'];
 //   meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  //  metaForCart = json['meta_for_cart'] != null ? Meta.fromJson(json['meta_for_cart']) : null;
  }
}

class Meta {
  int? insidePickupCitiesDeliveryCost;
  int? outsidePickupCitiesDeliveryCost;
  int? insidePickupCitiesBaseWeight;
  int? insidePickupCitiesBaseWeightCost;
  int? outsidePickupCitiesBaseWeight;
  int? outsidePickupCitiesBaseWeightCost;
  int? insidePickupCitiesAdditionalWeight;
  int? insidePickupCitiesAdditionalWeightCost;
  int? outsidePickupCitiesAdditionalWeight;
  int? outsidePickupCitiesAdditionalWeightCost;

  Meta.fromJson(dynamic json) {
    //  insidePickupCitiesDeliveryCost = json['inside_pickup_cities_delivery_cost'];
    //  outsidePickupCitiesDeliveryCost = json['outside_pickup_cities_delivery_cost'];
    //insidePickupCitiesBaseWeight = json['inside_pickup_cities_base_weight'];
    insidePickupCitiesBaseWeightCost =
        json['inside_pickup_cities_base_weight_cost'];
    outsidePickupCitiesBaseWeight = json['outside_pickup_cities_base_weight'];
    outsidePickupCitiesBaseWeightCost =
        json['outside_pickup_cities_base_weight_cost'];
    insidePickupCitiesAdditionalWeight =
        json['inside_pickup_cities_additional_weight'];
    insidePickupCitiesAdditionalWeightCost =
        json['inside_pickup_cities_additional_weight_cost'];
    outsidePickupCitiesAdditionalWeight =
        json['outside_pickup_cities_additional_weight'];
    //outsidePickupCitiesAdditionalWeightCost =json['outside_pickup_cities_additional_weight_cost'];
  }
}

class Information {
  String? title;
  String? description;

  Information.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
  }
}

class Terms {
  String? title;
  String? description;

  Terms.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
  }
}

class DeliveryEstimatedTimes {
  String? ar;
  String? en;

  DeliveryEstimatedTimes.fromJson(dynamic json) {
    ar = json['ar'];
    en = json['en'];
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
    name = isArabicLanguage ? json['ar_name'] : json['en_name'];
    priority = json['priority'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    countryCode = json['country_code'];
    arName = json['ar_name'];
    enName = json['en_name'];
  }
}

class Courier {
  int? id;
  String? driverCode;
  String? driverClass;
  String? driverArName;
  String? driverEnName;
  String? driverIcon;
  String? driverIconWithName;
  String? driverIconForCart;
  int? driverEnabled;
  String? driverUrl;
  String? driverAgreementUrl;
  String? driverTermsDescriptionAr;
  String? driverTermsDescriptionEn;
  String? driverDeliveryEstimatedTimeAr;
  String? driverDeliveryEstimatedTimeEn;
  int? isApprovedByDefault;
  int? isCodAvailable;
  Meta? meta;
  String? insidePickupCitiesDeliveryCost;
  String? outsidePickupCitiesDeliveryCost;
  String? baseCodCost;
  int? isFulfillmentDriver;
  int? isCustomizableDriver;
  int? hasManualActivation;
  dynamic? manualActivationUrl;
  String? driverConfigs;
  String? createdAt;
  String? updatedAt;
  dynamic? deletedAt;

  Courier.fromJson(dynamic json) {
    id = json['id'];
    driverCode = json['driver_code'];
    driverClass = json['driver_class'];
    driverArName = json['driver_ar_name'];
    driverEnName = json['driver_en_name'];
    driverIcon = json['driver_icon'];
    driverIconWithName = json['driver_icon_with_name'];
    driverIconForCart = json['driver_icon_for_cart'];
    driverEnabled = json['driver_enabled'];
    driverUrl = json['driver_url'];
    driverAgreementUrl = json['driver_agreement_url'];
    driverTermsDescriptionAr = json['driver_terms_description_ar'];
    driverTermsDescriptionEn = json['driver_terms_description_en'];
    driverDeliveryEstimatedTimeAr = json['driver_delivery_estimated_time_ar'];
    driverDeliveryEstimatedTimeEn = json['driver_delivery_estimated_time_en'];
    isApprovedByDefault = json['is_approved_by_default'];
    isCodAvailable = json['is_cod_available'];
   // meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    insidePickupCitiesDeliveryCost = json['inside_pickup_cities_delivery_cost'];
    outsidePickupCitiesDeliveryCost =
        json['outside_pickup_cities_delivery_cost'];
    baseCodCost = json['base_cod_cost'];
    isFulfillmentDriver = json['is_fulfillment_driver'];
    isCustomizableDriver = json['is_customizable_driver'];
    hasManualActivation = json['has_manual_activation'];
    manualActivationUrl = json['manual_activation_url'];
    driverConfigs = json['driver_configs'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
}
