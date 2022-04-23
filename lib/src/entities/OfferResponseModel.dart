class OfferResponseModel {
  String? name;
  List<String>? productIds;

  OfferResponseModel.fromJson(dynamic json) {
    name = json['name'];
    productIds = json['product_ids'] != null ? json['product_ids'].cast<String>() : [];
  }
}