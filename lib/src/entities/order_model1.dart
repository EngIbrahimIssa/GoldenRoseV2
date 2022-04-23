class OrderModel1 {
  int? id;
  String? code;
  int? storeId;
  String? orderUrl;
  String? storeName;
  String? shippingMethodCode;
  String? storeUrl;
  Order_status? orderStatus;
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
  Shipping? shipping;
  Payment? payment;
  String? customerNote;
  dynamic? transactionReference;
  int? weight;
  List<dynamic>? weightCostDetails;
  Currency? currency;
  dynamic? coupon;
  List<Products>? products;
  int? productsCount;
  String? language;
  List<Histories>? histories;
  dynamic? returnPolicy;

  OrderModel1({
      this.id, 
      this.code, 
      this.storeId, 
      this.orderUrl, 
      this.storeName, 
      this.shippingMethodCode, 
      this.storeUrl, 
      this.orderStatus, 
      this.currencyCode, 
      this.customer, 
      this.hasDifferentConsignee, 
      this.orderTotal, 
      this.orderTotalString, 
      this.productsSumTotalString, 
      this.hasDifferentTransactionCurrency, 
      this.transactionAmount, 
      this.transactionAmountString, 
      this.createdAt, 
      this.updatedAt, 
      this.requiresShipping, 
      this.shipping, 
      this.payment, 
      this.customerNote, 
      this.transactionReference, 
      this.weight, 
      this.weightCostDetails, 
      this.currency, 
      this.coupon, 
      this.products, 
      this.productsCount, 
      this.language, 
      this.histories, 
      this.returnPolicy});

  OrderModel1.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    storeId = json['store_id'];
    orderUrl = json['order_url'];
    storeName = json['store_name'];
    shippingMethodCode = json['shipping_method_code'];
    storeUrl = json['store_url'];
    orderStatus = json['order_status'] != null ? Order_status.fromJson(json['orderStatus']) : null;
    currencyCode = json['currency_code'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    hasDifferentConsignee = json['has_different_consignee'];
    orderTotal = json['order_total'];
    orderTotalString = json['order_total_string'];
    productsSumTotalString = json['products_sum_total_string'];
    hasDifferentTransactionCurrency = json['has_different_transaction_currency'];
    transactionAmount = json['transaction_amount'];
    transactionAmountString = json['transaction_amount_string'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    requiresShipping = json['requires_shipping'];
    shipping = json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    payment = json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    customerNote = json['customer_note'];
    transactionReference = json['transaction_reference'];
    weight = json['weight'];
    if (json['weight_cost_details'] != null) {
      weightCostDetails = [];
      json['weight_cost_details'].forEach((v) {
        weightCostDetails?.add((v));
      });
    }
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    coupon = json['coupon'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    productsCount = json['products_count'];
    language = json['language'];
    if (json['histories'] != null) {
      histories = [];
      json['histories'].forEach((v) {
        histories?.add(Histories.fromJson(v));
      });
    }
    returnPolicy = json['return_policy'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['store_id'] = storeId;
    map['order_url'] = orderUrl;
    map['store_name'] = storeName;
    map['shipping_method_code'] = shippingMethodCode;
    map['store_url'] = storeUrl;
    if (orderStatus != null) {
      map['order_status'] = orderStatus?.toJson();
    }
    map['currency_code'] = currencyCode;
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    map['has_different_consignee'] = hasDifferentConsignee;
    map['order_total'] = orderTotal;
    map['order_total_string'] = orderTotalString;
    map['products_sum_total_string'] = productsSumTotalString;
    map['has_different_transaction_currency'] = hasDifferentTransactionCurrency;
    map['transaction_amount'] = transactionAmount;
    map['transaction_amount_string'] = transactionAmountString;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['requires_shipping'] = requiresShipping;
    if (shipping != null) {
      map['shipping'] = shipping?.toJson();
    }
    if (payment != null) {
      map['payment'] = payment?.toJson();
    }
    map['customer_note'] = customerNote;
    map['transaction_reference'] = transactionReference;
    map['weight'] = weight;
    if (weightCostDetails != null) {
      map['weight_cost_details'] = weightCostDetails?.map((v) => v.toJson()).toList();
    }
    if (currency != null) {
      map['currency'] = currency?.toJson();
    }
    map['coupon'] = coupon;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['products_count'] = productsCount;
    map['language'] = language;
    if (histories != null) {
      map['histories'] = histories?.map((v) => v.toJson()).toList();
    }
    map['return_policy'] = returnPolicy;
    return map;
  }

}

class Histories {
  int? orderStatusId;
  String? orderStatusName;
  dynamic? changedById;
  String? changedByType;
  Changed_by_details? changedByDetails;
  String? comment;
  String? createdAt;
  String? humanizedCreatedAt;

  Histories({
      this.orderStatusId, 
      this.orderStatusName, 
      this.changedById, 
      this.changedByType, 
      this.changedByDetails, 
      this.comment, 
      this.createdAt, 
      this.humanizedCreatedAt});

  Histories.fromJson(dynamic json) {
    orderStatusId = json['order_status_id'];
    orderStatusName = json['order_status_name'];
    changedById = json['changed_by_id'];
    changedByType = json['changed_by_type'];
    changedByDetails = json['changed_by_details'] != null ? Changed_by_details.fromJson(json['changedByDetails']) : null;
    comment = json['comment'];
    createdAt = json['created_at'];
    humanizedCreatedAt = json['humanized_created_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['order_status_id'] = orderStatusId;
    map['order_status_name'] = orderStatusName;
    map['changed_by_id'] = changedById;
    map['changed_by_type'] = changedByType;
    if (changedByDetails != null) {
      map['changed_by_details'] = changedByDetails?.toJson();
    }
    map['comment'] = comment;
    map['created_at'] = createdAt;
    map['humanized_created_at'] = humanizedCreatedAt;
    return map;
  }

}

class Changed_by_details {
  String? action;
  dynamic? by;

  Changed_by_details({
      this.action, 
      this.by});

  Changed_by_details.fromJson(dynamic json) {
    action = json['action'];
    by = json['by'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['action'] = action;
    map['by'] = by;
    return map;
  }

}

class Products {
  String? id;
  dynamic? parentId;
  String? name;
  String? sku;
  List<dynamic>? customFields;
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
  String? taxAmountString;
  String? taxAmountStringPerItem;
  double? price;
  String? priceString;
  int? additionsPrice;
  String? additionsPriceString;
  double? total;
  String? totalString;
  List<Images>? images;
  List<dynamic>? options;

  Products({
      this.id, 
      this.parentId, 
      this.name, 
      this.sku, 
      this.customFields, 
      this.quantity, 
      this.weight, 
      this.isTaxable, 
      this.isDiscounted, 
      this.meta, 
      this.netPriceWithAdditions, 
      this.netPriceWithAdditionsString, 
      this.priceWithAdditions, 
      this.priceWithAdditionsString, 
      this.netPrice, 
      this.netPriceString, 
      this.netSalePrice, 
      this.netSalePriceString, 
      this.netAdditionsPrice, 
      this.netAdditionsPriceString, 
      this.grossPrice, 
      this.grossPriceString, 
      this.grossSalePrice, 
      this.grossSalePriceString, 
      this.priceBefore, 
      this.priceBeforeString, 
      this.totalBefore, 
      this.totalBeforeString, 
      this.grossAdditionsPrice, 
      this.grossAdditionsPriceString, 
      this.taxPercentage, 
      this.taxAmount, 
      this.taxAmountString, 
      this.taxAmountStringPerItem, 
      this.price, 
      this.priceString, 
      this.additionsPrice, 
      this.additionsPriceString, 
      this.total, 
      this.totalString, 
      this.images, 
      this.options});

  Products.fromJson(dynamic json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    sku = json['sku'];
    if (json['custom_fields'] != null) {
      customFields = [];
      json['custom_fields'].forEach((v) {
        customFields?.add((v));
      });
    }
    quantity = json['quantity'];
    weight = json['weight'];
    isTaxable = json['is_taxable'];
    isDiscounted = json['is_discounted'];
    meta = json['meta'];
    netPriceWithAdditions = json['net_price_with_additions'];
    netPriceWithAdditionsString = json['net_price_with_additions_string'];
    priceWithAdditions = json['price_with_additions'];
    priceWithAdditionsString = json['price_with_additions_string'];
    netPrice = json['net_price'];
    netPriceString = json['net_price_string'];
    netSalePrice = json['net_sale_price'];
    netSalePriceString = json['net_sale_price_string'];
    netAdditionsPrice = json['net_additions_price'];
    netAdditionsPriceString = json['net_additions_price_string'];
    grossPrice = json['gross_price'];
    grossPriceString = json['gross_price_string'];
    grossSalePrice = json['gross_sale_price'];
    grossSalePriceString = json['gross_sale_price_string'];
    priceBefore = json['price_before'];
    priceBeforeString = json['price_before_string'];
    totalBefore = json['total_before'];
    totalBeforeString = json['total_before_string'];
    grossAdditionsPrice = json['gross_additions_price'];
    grossAdditionsPriceString = json['gross_additions_price_string'];
    taxPercentage = json['tax_percentage'];
    taxAmount = json['tax_amount'];
    taxAmountString = json['tax_amount_string'];
    taxAmountStringPerItem = json['tax_amount_string_per_item'];
    price = json['price'];
    priceString = json['price_string'];
    additionsPrice = json['additions_price'];
    additionsPriceString = json['additions_price_string'];
    total = json['total'];
    totalString = json['total_string'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options?.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['parent_id'] = parentId;
    map['name'] = name;
    map['sku'] = sku;
    if (customFields != null) {
      map['custom_fields'] = customFields?.map((v) => v.toJson()).toList();
    }
    map['quantity'] = quantity;
    map['weight'] = weight;
    map['is_taxable'] = isTaxable;
    map['is_discounted'] = isDiscounted;
    map['meta'] = meta;
    map['net_price_with_additions'] = netPriceWithAdditions;
    map['net_price_with_additions_string'] = netPriceWithAdditionsString;
    map['price_with_additions'] = priceWithAdditions;
    map['price_with_additions_string'] = priceWithAdditionsString;
    map['net_price'] = netPrice;
    map['net_price_string'] = netPriceString;
    map['net_sale_price'] = netSalePrice;
    map['net_sale_price_string'] = netSalePriceString;
    map['net_additions_price'] = netAdditionsPrice;
    map['net_additions_price_string'] = netAdditionsPriceString;
    map['gross_price'] = grossPrice;
    map['gross_price_string'] = grossPriceString;
    map['gross_sale_price'] = grossSalePrice;
    map['gross_sale_price_string'] = grossSalePriceString;
    map['price_before'] = priceBefore;
    map['price_before_string'] = priceBeforeString;
    map['total_before'] = totalBefore;
    map['total_before_string'] = totalBeforeString;
    map['gross_additions_price'] = grossAdditionsPrice;
    map['gross_additions_price_string'] = grossAdditionsPriceString;
    map['tax_percentage'] = taxPercentage;
    map['tax_amount'] = taxAmount;
    map['tax_amount_string'] = taxAmountString;
    map['tax_amount_string_per_item'] = taxAmountStringPerItem;
    map['price'] = price;
    map['price_string'] = priceString;
    map['additions_price'] = additionsPrice;
    map['additions_price_string'] = additionsPriceString;
    map['total'] = total;
    map['total_string'] = totalString;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    if (options != null) {
      map['options'] = options?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Images {
  String? id;
  String? origin;
  Thumbs? thumbs;

  Images({
      this.id, 
      this.origin, 
      this.thumbs});

  Images.fromJson(dynamic json) {
    id = json['id'];
    origin = json['origin'];
    thumbs = json['thumbs'] != null ? Thumbs.fromJson(json['thumbs']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['origin'] = origin;
    if (thumbs != null) {
      map['thumbs'] = thumbs?.toJson();
    }
    return map;
  }

}

class Thumbs {
  String? large;
  String? medium;
  String? fullSize;
  String? small;
  String? thumbnail;

  Thumbs({
      this.large, 
      this.medium, 
      this.fullSize, 
      this.small, 
      this.thumbnail});

  Thumbs.fromJson(dynamic json) {
    large = json['large'];
    medium = json['medium'];
    fullSize = json['full_size'];
    small = json['small'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['large'] = large;
    map['medium'] = medium;
    map['full_size'] = fullSize;
    map['small'] = small;
    map['thumbnail'] = thumbnail;
    return map;
  }

}

class Currency {
  Order_currency? orderCurrency;
  Order_store_currency? orderStoreCurrency;

  Currency({
      this.orderCurrency, 
      this.orderStoreCurrency});

  Currency.fromJson(dynamic json) {
    orderCurrency = json['order_currency'] != null ? Order_currency.fromJson(json['orderCurrency']) : null;
    orderStoreCurrency = json['order_store_currency'] != null ? Order_store_currency.fromJson(json['orderStoreCurrency']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (orderCurrency != null) {
      map['order_currency'] = orderCurrency?.toJson();
    }
    if (orderStoreCurrency != null) {
      map['order_store_currency'] = orderStoreCurrency?.toJson();
    }
    return map;
  }

}

class Order_store_currency {
  int? id;
  String? code;
  dynamic? exchangeRate;

  Order_store_currency({
      this.id, 
      this.code, 
      this.exchangeRate});

  Order_store_currency.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    exchangeRate = json['exchange_rate'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['exchange_rate'] = exchangeRate;
    return map;
  }

}

class Order_currency {
  int? id;
  String? code;
  int? exchangeRate;

  Order_currency({
      this.id, 
      this.code, 
      this.exchangeRate});

  Order_currency.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    exchangeRate = json['exchange_rate'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['exchange_rate'] = exchangeRate;
    return map;
  }

}

class Payment {
  Method? method;
  List<Invoice>? invoice;

  Payment({
      this.method, 
      this.invoice});

  Payment.fromJson(dynamic json) {
    method = json['method'] != null ? Method.fromJson(json['method']) : null;
    if (json['invoice'] != null) {
      invoice = [];
      json['invoice'].forEach((v) {
        invoice?.add(Invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (method != null) {
      map['method'] = method?.toJson();
    }
    if (invoice != null) {
      map['invoice'] = invoice?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Invoice {
  String? code;
  String? value;
  String? valueString;
  String? title;

  Invoice({
      this.code, 
      this.value, 
      this.valueString, 
      this.title});

  Invoice.fromJson(dynamic json) {
    code = json['code'];
    value = json['value'];
    valueString = json['value_string'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = code;
    map['value'] = value;
    map['value_string'] = valueString;
    map['title'] = title;
    return map;
  }

}

class Method {
  String? name;
  String? code;
  String? type;
  String? transactionStatus;
  String? transactionStatusName;
  dynamic? transactionBank;
  dynamic? transactionSlip;
  dynamic? transactionSenderName;
  dynamic? updatedAt;

  Method({
      this.name, 
      this.code, 
      this.type, 
      this.transactionStatus, 
      this.transactionStatusName, 
      this.transactionBank, 
      this.transactionSlip, 
      this.transactionSenderName, 
      this.updatedAt});

  Method.fromJson(dynamic json) {
    name = json['name'];
    code = json['code'];
    type = json['type'];
    transactionStatus = json['transaction_status'];
    transactionStatusName = json['transaction_status_name'];
    transactionBank = json['transaction_bank'];
    transactionSlip = json['transaction_slip'];
    transactionSenderName = json['transaction_sender_name'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['code'] = code;
    map['type'] = type;
    map['transaction_status'] = transactionStatus;
    map['transaction_status_name'] = transactionStatusName;
    map['transaction_bank'] = transactionBank;
    map['transaction_slip'] = transactionSlip;
    map['transaction_sender_name'] = transactionSenderName;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class Shipping {
  Method? method;
  Address? address;

  Shipping({
      this.method, 
      this.address});

  Shipping.fromJson(dynamic json) {
    method = json['method'] != null ? Method.fromJson(json['method']) : null;
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (method != null) {
      map['method'] = method?.toJson();
    }
    if (address != null) {
      map['address'] = address?.toJson();
    }
    return map;
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

  Address({
      this.formattedAddress, 
      this.street, 
      this.district, 
      this.lat, 
      this.lng, 
      this.meta, 
      this.city, 
      this.country});

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

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['formatted_address'] = formattedAddress;
    map['street'] = street;
    map['district'] = district;
    map['lat'] = lat;
    map['lng'] = lng;
    map['meta'] = meta;
    if (city != null) {
      map['city'] = city?.toJson();
    }
    if (country != null) {
      map['country'] = country?.toJson();
    }
    return map;
  }

}

class Country {
  int? id;
  String? name;

  Country({
      this.id, 
      this.name});

  Country.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

class City {
  int? id;
  String? name;

  City({
      this.id, 
      this.name});

  City.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

class Tracking {
  dynamic? number;
  dynamic? status;
  dynamic? url;

  Tracking({
      this.number, 
      this.status, 
      this.url});

  Tracking.fromJson(dynamic json) {
    number = json['number'];
    status = json['status'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['number'] = number;
    map['status'] = status;
    map['url'] = url;
    return map;
  }

}

class Customer {
  int? id;
  String? name;
  int? verified;
  String? email;
  String? mobile;
  String? note;

  Customer({
      this.id, 
      this.name, 
      this.verified, 
      this.email, 
      this.mobile, 
      this.note});

  Customer.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    verified = json['verified'];
    email = json['email'];
    mobile = json['mobile'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['verified'] = verified;
    map['email'] = email;
    map['mobile'] = mobile;
    map['note'] = note;
    return map;
  }

}

class Order_status {
  String? name;
  String? code;

  Order_status({
      this.name, 
      this.code});

  Order_status.fromJson(dynamic json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['code'] = code;
    return map;
  }

}