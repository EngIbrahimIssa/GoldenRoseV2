class UserModel {
  int? id;
  String? name;
  String? mobile;
  String? email;
  int? verified;
  String? createdAt;
  String? updatedAt;

  UserModel({
      this.id, 
      this.name, 
      this.mobile, 
      this.email, 
      this.verified, 
      this.createdAt, 
      this.updatedAt});

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    verified = json['verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile'] = mobile;
    map['email'] = email;
    map['verified'] = verified;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}