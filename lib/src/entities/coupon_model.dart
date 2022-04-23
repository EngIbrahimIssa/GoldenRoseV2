class CouponModel {
  int? couponId;
  String? name;
  String? code;
  String? type;
  int? discount;
  String? discountString;
  bool? logged;
  bool? freeShipping;
  bool? freeCod;
  int? total;
  String? dateStart;
  String? dateEnd;
  int? usesTotal;
  int? usesCustomer;
  bool? enabled;
  String? createdAt;
  double? discountAmount;
  String? discountAmountString;


  CouponModel.fromJson(dynamic json) {
    couponId = json['coupon_id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
   // discount = json['discount'];
    discountString = json['discount_string'];
    logged = json['logged'];
    freeShipping = json['free_shipping'];
    freeCod = json['free_cod'];
   // total = json['total'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
  //  usesTotal = json['uses_total'];
   // usesCustomer = json['uses_customer'];
    enabled = json['enabled'];
    createdAt = json['created_at'];
 //   discountAmount = json['discount_amount'];
    discountAmountString = json['discount_amount_string'];
  }

}