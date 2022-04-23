class CustomUserInputFieldRequest {
  String? priceSettings;
  String? groupId;
  String? name;
  String? value;
  String? type;

  CustomUserInputFieldRequest({
      this.priceSettings, 
      this.groupId, 
      this.name, 
      this.value, 
      this.type});

  CustomUserInputFieldRequest.fromJson(dynamic json) {
    priceSettings = json['price_settings'];
    groupId = json['group_id'];
    name = json['name'];
    value = json['value'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['price_settings'] = priceSettings;
    map['group_id'] = groupId;
    map['name'] = name;
    map['value'] = value;
    map['type'] = type;
    return map;
  }

}