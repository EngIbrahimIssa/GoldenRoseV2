class FaqModel {
  FaqModel({
      this.id, 
      this.question, 
      this.answer, 
      this.priority,});

  FaqModel.fromJson(dynamic json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    priority = json['priority'];
  }
  int? id;
  String? question;
  String? answer;
  int? priority;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question'] = question;
    map['answer'] = answer;
    map['priority'] = priority;
    return map;
  }

}