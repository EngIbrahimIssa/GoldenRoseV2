import 'package:entaj/src/entities/page_model.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';
import 'logic.dart';

class PageDetailsPage extends StatelessWidget {
  final int type;
  final PageModel? pageModel;
  final PageDetailsLogic logic = Get.put(PageDetailsLogic());

  PageDetailsPage(this.pageModel, this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logic.pageModel = pageModel;
    if (type == 1) {
      logic.getPrivacyPolicy();
    } else if (type == 2) {
      logic.getRefundPolicy();
    } else if (type == 3) {
      logic.getTermsAndConditions();
    } else {
      logic.getPageDetails(pageModel?.id);
    }
    return GetBuilder<PageDetailsLogic>(builder: (logic) {
      // dom.Document document = htmlparser.parse(pageModel?.content);
      return Scaffold(
        appBar: AppBar(
          title: CustomText(
            logic.pageModel?.title,
            fontSize: 16,
          ),
          elevation: 3,
        ),
        body: logic.isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  if (type == 1) {
                    await logic.getPrivacyPolicy();
                  } else if (type == 2) {
                    await logic.getRefundPolicy();
                  } else if (type == 3) {
                    await logic.getTermsAndConditions();
                  } else {
                    logic.getPageDetails(pageModel?.id);
                  }
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: buildHtml(type>2),
                  ),
                ),
              ),
      );
    });
  }

  Widget buildHtml(bool additional) {
    return /*!additional
        ? Html(
            data: logic.pageModel?.content ??
                logic.pageModel?.sEOPageDescription ??
                '',
            onLinkTap: (String? url, RenderContext context,
                Map<String, String> attributes, dom.Element? element) {
              launch(url ?? '');
            })
        : */HtmlWidget(
            logic.pageModel?.content ??
                logic.pageModel?.sEOPageDescription ??
                '',
            onTapUrl: (url) => launch(url),
          );
  }
}
