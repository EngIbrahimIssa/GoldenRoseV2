import 'package:entaj/src/utils/functions.dart';

/// id : 67
/// name : "Ila Carson"
/// slug : "test"
/// SEO_category_title : "Ila Carson"
/// SEO_category_description : "Voluptas commodo"
/// description : null
/// url : "http://catalog.zid/hammam95/categories/test"
/// image : null
/// img_alt_text : null
/// cover_image : null
/// products_count : 1
/// sub_categories : []
/// parent_id : 0
/// is_published : true

class CategoryModel {
  String? id;
  String? name;
  String? slug;
  String? sEOCategoryTitle;
  String? sEOCategoryDescription;
  String? description;
  String? url;
  String? image;
  String? imgAltText;
  String? coverImage;
  int? productsCount;
  List<CategoryModel>? subCategories;
  List<String?> ids = [];
  int? parentId;
  bool? isPublished;


  CategoryModel.fromJson(dynamic json) {
    id = json['id'].toString();
    name = getLabelInString(json['name']);
    //description = getLabelInString(json['description']);
    slug = json['slug'];
    sEOCategoryTitle = json['SEO_category_title'];
    sEOCategoryDescription = json['SEO_category_description'];
    url = json['url'];
    image = json['image'];
    imgAltText = json['img_alt_text'];
    coverImage = json['cover_image'];
    productsCount = json['products_count'];
    if (json['sub_categories'] != null) {
      subCategories = [];
      json['sub_categories'].forEach((v) {
        var category = CategoryModel.fromJson(v);
        subCategories?.add(category);
        ids.addAll(category.ids);
      });
    }
    ids.add(id);

    parentId = json['parent_id'];
    isPublished = json['is_published'];
  }


}