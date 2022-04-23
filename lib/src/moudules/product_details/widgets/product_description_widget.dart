import 'package:entaj/src/app_config.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:entaj/src/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../../colors.dart';
import '../logic.dart';

class ProductDescriptionWidget extends StatelessWidget {
  const ProductDescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsLogic>(
        id: 'description',
        init: Get.find<ProductDetailsLogic>(),
        builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              HtmlWidget(
                logic.description ?? '',
                textStyle: const TextStyle(
                  fontFamily: AppConfig.fontName
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              if ((logic.productModel?.description?.length ?? 0) > 500)
                GestureDetector(
                  onTap: () => logic.getDescription(all: logic.clickOnMore),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: greenColor, width: 2)),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            "المزيد".tr,
                            fontSize: 10,
                          ),
                          Icon(!logic.clickOnMore
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down)
                        ],
                      )),
                ),
            ],
          );
        });
  }
}
