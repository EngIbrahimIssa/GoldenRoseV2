import 'package:entaj/src/app_config.dart';

class PageModel {
  int? id;
  String? title;
  String? content;
  String? contentWithoutTags;
  String? sEOPageDescription;

  PageModel(this.id,this.title, this.content);

  PageModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    sEOPageDescription = json['SEO_page_description'];

    content = content?.replaceAll('Times New Roman', AppConfig.fontName);
    sEOPageDescription = sEOPageDescription?.replaceAll('Times New Roman', AppConfig.fontName);
  }
}