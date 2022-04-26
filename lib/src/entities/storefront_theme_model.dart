class StorefrontThemeModel {
  StorefrontThemeModel({
      this.id, 
      this.name, 
      this.code, 
      this.filePath, 
      this.price, 
      this.createdAt, 
      this.updatedAt, 
      this.isPublic, 
      this.approvedAt, 
      this.meta, 
      this.userUuid, 
      this.pivot,});

  StorefrontThemeModel.fromJson(dynamic json) {
    if(json == null) return;
    id = json['id'];
    name = json['name'];
    code = json['code'];
    filePath = json['file_path'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPublic = json['is_public'];
    approvedAt = json['approved_at'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    userUuid = json['user_uuid'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
  String? id;
  String? name;
  dynamic code;
  String? filePath;
  dynamic price;
  String? createdAt;
  String? updatedAt;
  bool? isPublic;
  String? approvedAt;
  Meta? meta;
  String? userUuid;
  Pivot? pivot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['file_path'] = filePath;
    map['price'] = price;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_public'] = isPublic;
    map['approved_at'] = approvedAt;
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    map['user_uuid'] = userUuid;
    if (pivot != null) {
      map['pivot'] = pivot?.toJson();
    }
    return map;
  }

}

class Pivot {
  Pivot({
      this.storeId, 
      this.themeId, 
      this.id, 
      this.isPublished, 
      this.createdAt, 
      this.updatedAt,});

  Pivot.fromJson(dynamic json) {
    storeId = json['store_id'];
    themeId = json['theme_id'];
    id = json['id'];
    isPublished = json['is_published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? storeId;
  String? themeId;
  String? id;
  int? isPublished;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['store_id'] = storeId;
    map['theme_id'] = themeId;
    map['id'] = id;
    map['is_published'] = isPublished;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class Meta {
  Meta({
      this.name, 
      this.developedBy, 
      this.previewLink, 
      this.image, 
      this.publisherStoreId, 
      this.publisherThemeId, 
      this.defaultModulesStoreUuid,});

  Meta.fromJson(dynamic json) {
    name = json['name'];
    developedBy = json['developed_by'];
    previewLink = json['preview_link'];
    image = json['image'];
    publisherStoreId = json['publisher_store_id'];
    publisherThemeId = json['publisher_theme_id'];
    defaultModulesStoreUuid = json['default_modules_store_uuid'];
  }
  String? name;
  String? developedBy;
  String? previewLink;
  String? image;
  String? publisherStoreId;
  String? publisherThemeId;
  String? defaultModulesStoreUuid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['developed_by'] = developedBy;
    map['preview_link'] = previewLink;
    map['image'] = image;
    map['publisher_store_id'] = publisherStoreId;
    map['publisher_theme_id'] = publisherThemeId;
    map['default_modules_store_uuid'] = defaultModulesStoreUuid;
    return map;
  }

}