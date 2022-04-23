class CustomOptionFieldRequest {
  Map? priceSettings;
  String? groupId;
  String? groupName;
  String? name;
  String? value;
  String? type;

  CustomOptionFieldRequest({
      this.priceSettings, 
      this.groupId, 
      this.groupName,
      this.name,
      this.value, 
      this.type});

  CustomOptionFieldRequest.fromJson(dynamic json) {
    priceSettings = json['price_settings'];
    groupId = json['group_id'];
    groupName = json['group_name'];
    name = json['name'];
    value = json['value'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['price_settings'] = priceSettings;
    map['group_id'] = groupId;
    map['group_name'] = groupName;
    map['name'] = name;
    map['value'] = value;
    map['type'] = type;
    return map;
  }

}