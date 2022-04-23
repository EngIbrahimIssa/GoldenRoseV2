class OptionModel {
  String? id;
  String? type;
  dynamic? hint;
  int? minChoices;
  int? maxChoices;
  bool? isRequired;
  bool? canChooseMultipleOptions;
  List<Choices>? choices;
  dynamic? displayOrder;
  bool? isPublished;

  OptionModel.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    //   hint = json['hint'];
    minChoices = json['min_choices'];
    maxChoices = json['max_choices'];
    isRequired = json['is_required'];
    canChooseMultipleOptions = json['can_choose_multiple_options'];
    if (json['choices'] != null) {
      choices = [];
      json['choices'].forEach((v) {
        choices?.add(Choices.fromJson(v));
      });
    }
    // displayOrder = json['display_order'];
    isPublished = json['is_published'];
  }
}

class Choices {
  String? ar;
  String? en;
  String? id;
  String? price;

  Choices.fromJson(dynamic json) {
    ar = json['ar'];
    en = json['en'];
    id = json['id'];
    price = json['price'].toString();
  }
}