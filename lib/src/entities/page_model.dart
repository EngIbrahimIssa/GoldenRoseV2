class PageModel {
  int? id;
  String? title;
  String? content;
  String? sEOPageDescription;

  PageModel(this.id,this.title, this.content);

  PageModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    sEOPageDescription = json['SEO_page_description'];
  }
}