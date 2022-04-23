import 'package:entaj/src/moudules/_main/logic.dart';
import 'package:entaj/src/moudules/page_details/view.dart';
import 'package:entaj/src/utils/custom_widget/custom_list_tile.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
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
            : RefreshIndicator(
                onRefresh: () => logic.getPages(true),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: logic.pagesList.length,
                      itemBuilder: (context, index) => CustomListTile(
                        logic.pagesList[index].title,
                        () =>
                            Get.to(PageDetailsPage(logic.pagesList[index], 4)),
                        null,
                      ),
                    ))
                  ],
                ),
              );
      }),
    );
  }
}
