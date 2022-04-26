import 'package:entaj/src/moudules/faq/view.dart';

import '../../app_config.dart';

import '../../.env.dart';
import '../../utils/functions.dart';
import '../_main/logic.dart';
import '../delivery_option/view.dart';
import '../page_details/view.dart';
import '../../utils/custom_widget/custom_list_tile.dart';
import '../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PagesPage extends StatelessWidget {
  final PagesLogic logic = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          "الصفحات الإضافية".tr,
          fontSize: 16,
        ),
      ),
      body: GetBuilder<MainLogic>(
          id: "pages",
          builder: (logic) {
            return logic.isPagesLoading
                ? const Center(child: CircularProgressIndicator())
                : AppConfig.isSoreUseNewTheme
                    ? RefreshIndicator(
                        onRefresh: () => logic.getHomeScreen(themeId: softThemeId),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (logic.footerSettings?.links_1_title != null)
                                  CustomText(
                                    logic.footerSettings?.links_1_title,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: logic.footerSettings?.links1Links?.length ?? 0,
                                  itemBuilder: (context, index) => CustomListTile(
                                    logic.footerSettings?.links1Links?[index].title,
                                    () => onTap(logic.footerSettings?.links1Links?[index].url,
                                        logic.footerSettings?.links1Links?[index].title),
                                    null,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                if (logic.footerSettings?.links_2_title != null)
                                  CustomText(
                                    logic.footerSettings?.links_2_title,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: logic.footerSettings?.links2Links?.length ?? 0,
                                  itemBuilder: (context, index) => CustomListTile(
                                    logic.footerSettings?.links2Links?[index].title,
                                    () => onTap(logic.footerSettings?.links2Links?[index].url,
                                        logic.footerSettings?.links2Links?[index].title),
                                    null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => logic.getPages(true),
                        child: Column(
                          children: [
                            Expanded(
                                child: ListView.builder(
                              itemCount: logic.pagesList.length,
                              itemBuilder: (context, index) => CustomListTile(
                                logic.pagesList[index].title,
                                () => Get.to(PageDetailsPage(
                                    pageModel: logic.pagesList[index],
                                    title: logic.pagesList[index].title,
                                    type: 4)),
                                null,
                              ),
                            ))
                          ],
                        ),
                      );
          }),
    );
  }

  onTap(String? url, String? title) {
    if (url?.contains('shipping-and-payment') == true) {
      Get.to(DeliveryOptionPage());
    } else if (url?.contains('https://') == true || url?.contains('http://') == true) {
      goToLink(url);
    } else if (url?.contains('/faqs') == true) {
      Get.to(FaqPage());
    } else {
      Get.to(PageDetailsPage(type: 5, title: title, url: url));
    }
  }
}
