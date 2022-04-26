import '../utils/functions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ReviewsModel {
  Pagination? pagination;
  Item? item;
  List<Reviews>? reviews;

  ReviewsModel({this.pagination, this.item, this.reviews});

  ReviewsModel.fromJson(dynamic json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(Reviews.fromJson(v));
      });
    }
  }
}

class Reviews {
  String? id;
  Customer? customer;
  String? status;
  bool? boughtThisItem;
  bool? isAnonymous;
  double? rating;
  String? comment;
  String? createdAt;
  String? ratingString;

  Reviews.fromJson(dynamic json) {
    id = json['id'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    status = json['status'];
    boughtThisItem = json['bought_this_item'];
    isAnonymous = json['is_anonymous'];
    rating = checkDouble(json['rating']);
    comment = json['comment'];
    createdAt = json['created_at'];
    ratingString = rating == 1
        ? 'سيئ'.tr
        : rating == 2
            ? 'لم يعجبني'.tr
            : rating == 3
                ? 'جيد'.tr
                : rating == 4
                    ? 'جيد جداً'.tr
                    : rating == 5
                        ? 'رائع'.tr
                        : '';
  }
}

class Customer {
  int? id;
  String? name;

  Customer.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
}

class Item {
  String? type;
  String? id;
  Rating? rating;

  Item.fromJson(dynamic json) {
    type = json['type'];
    id = json['id'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }
}

class Rating {
  double? average;
  int? totalCount;
  Ratings? ratings_1;
  Ratings? ratings_2;
  Ratings? ratings_3;
  Ratings? ratings_4;
  Ratings? ratings_5;

  Rating.fromJson(dynamic json) {
    average = checkDouble(json['average']);
    totalCount = json['total_count'];
    ratings_1 =
        json['1_ratings'] != null ? Ratings.fromJson(json['1_ratings']) : null;
    ratings_2 =
        json['2_ratings'] != null ? Ratings.fromJson(json['2_ratings']) : null;
    ratings_3 =
        json['3_ratings'] != null ? Ratings.fromJson(json['3_ratings']) : null;
    ratings_4 =
        json['4_ratings'] != null ? Ratings.fromJson(json['4_ratings']) : null;
    ratings_5 =
        json['5_ratings'] != null ? Ratings.fromJson(json['5_ratings']) : null;
  }
}

class Ratings {
  double? percentage;
  int? count;

  Ratings.fromJson(dynamic json) {
    percentage = checkDouble(json['percentage']);
    count = json['count'];
  }
}

class Pagination {
  int? page;
  int? nextPage;
  int? lastPage;
  int? resultCount;

  Pagination({this.page, this.nextPage, this.lastPage, this.resultCount});

  Pagination.fromJson(dynamic json) {
    page = json['page'];
    nextPage = json['next_page'];
    lastPage = json['last_page'];
    resultCount = json['result_count'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['page'] = page;
    map['next_page'] = nextPage;
    map['last_page'] = lastPage;
    map['result_count'] = resultCount;
    return map;
  }
}
