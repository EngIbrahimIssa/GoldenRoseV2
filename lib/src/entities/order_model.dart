import 'cart_model.dart';
import 'product_model.dart';

class OrderModel {
  int? id;
  String? code;
  int? storeId;
  String? orderUrl;
  String? storeName;
  String? shippingMethodCode;
  String? storeUrl;
  OrderStatus? orderStatus;
  String? currencyCode;
  Customer? customer;
  int? hasDifferentConsignee;
  String? orderTotal;
  String? orderTotalString;
  String? productsSumTotalString;
  bool? hasDifferentTransactionCurrency;
  double? transactionAmount;
  String? transactionAmountString;
  String? createdAt;
  String? updatedAt;
  bool? requiresShipping;
  bool? needTransfer;
  List<ProductModel>? products;
  Shipping? shipping;
  Payment? payment;


  OrderModel.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    storeId = json['store_id'];
    orderUrl = json['order_url'];
    storeName = json['store_name'];
    shippingMethodCode = json['shipping_method_code'];
    storeUrl = json['store_url'];
    orderStatus = json['order_status'] != null ? OrderStatus.fromJson(json['order_status']) : null;
    currencyCode = json['currency_code'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    //hasDifferentConsignee = json['has_different_consignee'];
    orderTotal = json['order_total'];
    orderTotalString = json['order_total_string'];
    productsSumTotalString = json['products_sum_total_string'];
    hasDifferentTransactionCurrency = json['has_different_transaction_currency'];
    transactionAmount = double.parse(json['transaction_amount'].toString());
    transactionAmountString = json['transaction_amount_string'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    requiresShipping = json['requires_shipping'];
    shipping = json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    payment = json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductModel.fromJson(v));
      });
    }
    bool transferStatus = payment?.method?.transactionStatus != 'transfered';
    bool uploadStatus = payment?.method?.transactionStatus != 'uploaded';
    bool isOrderStatusNotCancelled = orderStatus?.code != 'cancelled';
    bool isPaymentMethodZidBank = payment?.method?.code == 'zid_bank_transfer';

    needTransfer = transferStatus && isOrderStatusNotCancelled && isPaymentMethodZidBank && uploadStatus;

  }
}

class Payment {
  Method? method;
  Address? address;
  List<Totals>? invoice;
  Payment.fromJson(dynamic json) {
    method = json['method'] != null ? Method.fromJson(json['method']) : null;
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['invoice'] != null) {
      invoice = [];
      json['invoice'].forEach((v) {
        invoice?.add(Totals.fromJson(v));
      });
    }
  }
}

class Shipping {
  Method? method;
  Address? address;

  Shipping.fromJson(dynamic json) {
    method = json['method'] != null ? Method.fromJson(json['method']) : null;
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
  }

}
class Address {
  dynamic? formattedAddress;
  String? street;
  String? district;
  dynamic? lat;
  dynamic? lng;
  dynamic? meta;
  City? city;
  Country? country;


  Address.fromJson(dynamic json) {
    formattedAddress = json['formatted_address'];
    street = json['street'];
    district = json['district'];
    lat = json['lat'];
    lng = json['lng'];
    meta = json['meta'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }

}
class Country {
  int? id;
  String? name;

  Country.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

}

class City {
  int? id;
  String? name;

  City.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }


}

class Method {
  int? id;
  String? name;
  String? code;
  String? estimatedDeliveryTime;
  String? icon;
  bool? isSystemOption;
  dynamic? waybill;
  dynamic? waybillTrackingId;
  Tracking? tracking;
  String? type;
  String? transactionStatus;
  String? transactionStatusName;

  Method.fromJson(dynamic json) {
    transactionStatus = json['transaction_status'];
    transactionStatusName = json['transaction_status_name'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
    code = json['code'];
    estimatedDeliveryTime = json['estimated_delivery_time'];
    icon = json['icon'];
    isSystemOption = json['is_system_option'];
    waybill = json['waybill'];
    waybillTrackingId = json['waybill_tracking_id'];
    tracking = json['tracking'] != null ? Tracking.fromJson(json['tracking']) : null;
  }

}

class Tracking {
  dynamic? number;
  dynamic? status;
  dynamic? url;

  Tracking.fromJson(dynamic json) {
    number = json['number'];
    status = json['status'];
    url = json['url'];
  }
}

class Customer {
  int? id;
  String? name;
  int? verified;
  String? email;
  String? mobile;
  String? note;


  Customer.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    verified = json['verified'];
    email = json['email'];
    mobile = json['mobile'];
    note = json['note'];
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