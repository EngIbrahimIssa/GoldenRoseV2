import 'dart:developer';

import 'package:entaj/src/binding.dart';
import 'package:entaj/src/colors.dart';
import 'package:entaj/src/moudules/delivery_option/view.dart';
import 'package:entaj/src/utils/functions.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../.env.dart';
import '../../entities/page_model.dart';
import '../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'logic.dart';

class PageDetailsPage extends StatelessWidget {
  int type;
  final PageModel? pageModel;
  final String? title;
  final String? url;
  final PageDetailsLogic logic = Get.put(PageDetailsLogic());

  PageDetailsPage(
      {this.pageModel,
      required this.type,
      required this.title,
      this.url,
      Key? key})
      : super(key: key);
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        applePayAPIEnabled: true,
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    logic.pageModel = pageModel;
    log('type ===== $type');
    if (type == 1) {
      if(pageModel==null) logic.getPrivacyPolicy();
    } else if (type == 2) {
      if(pageModel==null) logic.getRefundPolicy();
    } else if (type == 3) {
      if(pageModel==null) logic.getTermsAndConditions();
    } else if (type == 6) {
      if(pageModel==null) logic.getComplaintsAndSuggestions();
    } else if (type == 4) {
      if(pageModel==null) logic.getPageDetails(pageModel?.id);
    } else {
      log('type11 ===== $type');
      if (url?.contains('shipping-and-payment') == true) {
        //  Get.off( DeliveryOptionPage(), binding: Binding());
      } else if (url?.contains('privacy-policy') == true) {
        type = 1;
        logic.getPrivacyPolicy();
      } else if (url?.contains('refund-exchange-policy') == true) {
        type = 2;
        logic.getRefundPolicy();
      } else if (url?.contains('terms-and-conditions') == true) {
        type = 3;
        logic.getTermsAndConditions();
      } else if (url?.contains('complaints-and-suggestions') == true) {
        type = 6;
        logic.getComplaintsAndSuggestions();
      } else if (url?.contains('https://') == true) {
        goToLink(url);
      } else {
        logic.getPageDetailsSlug(url);
      }
    }
    return GetBuilder<PageDetailsLogic>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          title: CustomText(
            title ?? logic.pageModel?.title,
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
                  } else if (type == 6) {
                    await logic.getComplaintsAndSuggestions();
                  } else {
                    //   logic.getPageDetails(pageModel?.id);
                  }
                },
                child: (logic.pageModel?.contentWithoutTags?.length ?? 0) < 1
                    ? SizedBox(
                        height: 700.h,
                        child: Center(
                          child: CustomText(
                              'نعتذر ، لا يوجد محتوى لهذة الصفحة حاليا'.tr),
                        ),
                      )
                    : logic.pageModel?.content?.contains('iframe') == true
                        ? InAppWebView(
                            initialOptions: options,
                            initialData: InAppWebViewInitialData(
                                data: logic.pageModel?.content ??
                                    logic.pageModel?.sEOPageDescription ??
                                    ''),
                          )
                        : SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: buildHtml(type > 2),
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
        : */
        HtmlWidget(
      logic.pageModel?.content ?? logic.pageModel?.sEOPageDescription ?? '',
      onTapUrl: (url) => launch(url),
    );
  }
}
