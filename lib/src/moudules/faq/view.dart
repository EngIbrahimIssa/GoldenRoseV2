import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../utils/custom_widget/custom_text.dart';
import 'logic.dart';

class FaqPage extends StatelessWidget {
  final logic = Get.put(FaqLogic());

  @override
  Widget build(BuildContext context) {
    logic.getSettingsList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        title: CustomText(
          "الأسئلة الشائعة".tr,
          fontSize: 16,
        ),
      ),
      body: GetBuilder<FaqLogic>(
          init: Get.find<FaqLogic>(),
          builder: (logic) {
            return logic.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: logic.list.length,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => logic.openTap(index),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: CustomText(
                                      logic.list[index].question,
                                      textAlign: TextAlign.start,
                                    )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      logic.selectedIndex == index
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: (logic.selectedIndex != index)
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: HtmlWidget(
                                        logic.list[index].answer ?? '',
                                      ),
                                    ),
                            )
                          ],
                        ),
                      );
                    });
          }),
    );
  }
}
