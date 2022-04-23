class SuccessApiResponse {
  String? code;
 // dynamic? message;
  Payload? payload;

  SuccessApiResponse.fromJson(dynamic json) {
    code = json['code'];
  //  message = json['message'];
    payload = json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

}

class Payload {
  String? loginType;
  String? status;
  String? cartSessionId;
  String? customerAccessToken;
  int? customerId;
  bool? hasAddresses;


  Payload.fromJson(dynamic json) {
    loginType = json['login_type'];
    status = json['status'];
    cartSessionId = json['cart_session_id'];
    customerAccessToken = json['customer_access_token'];
    customerId = json['customer_id'];
    hasAddresses = json['has_addresses'];
  }

}