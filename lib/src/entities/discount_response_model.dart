import 'dart:developer';

import '../utils/functions.dart';

class DiscountResponseModel {
  String? id;
  String? name;
  String? description;
  String? code;
  List<Conditions>? conditions;
  List<Actions>? actions;
  String? conditionsCriteria;
  double? usesTotal;
  double? usesCustomer;
  bool? enabled;
  String? statusCode;
  String? startDate;
  String? endDate;

  DiscountResponseModel.fromJson(dynamic json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    description = json['description'];
    code = json['code'];
    try{

    if (json['conditions'] != null && code != 'mobile_app') {
      conditions = [];
      json['conditions'].forEach((v) {
        conditions?.add(Conditions.fromJson(v));
      });
    }
    }catch(e){}
    try{
    if (json['actions'] != null && code == 'mobile_app') {
      actions = [];
      json['actions'].forEach((v) {
        actions?.add(Actions.fromJson(v));
      });
    }
    }catch(e){}
    conditionsCriteria = json['conditions_criteria'];
    usesTotal = checkDouble(json['uses_total']);
    usesCustomer = checkDouble(json['uses_customer']);
    enabled = json['enabled'];
    statusCode = json['status_code'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }
}

class Actions {
  String? field;
  String? type;
  String? value;

  Actions.fromJson(dynamic json) {
    field = json['field'];
    type = json['type'];
    value = json['value'];
  }
}

class Conditions {
  String? field;
  String? operator;
  List<double>? value;
  List<String>? valueString;

  Conditions.fromJson(dynamic json) {
    field = json['field'];
    operator = json['operator'];

    // log(json['value'].toString());
    if (json['value'] != null) {
      value = [];
      json['value'].forEach((v) {
        value?.add(checkDouble(v));
      });
    }
    valueString =
        json['value_string'] != null ? json['value_string'].cast<String>() : [];
  }
}
