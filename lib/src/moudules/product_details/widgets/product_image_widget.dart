import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../main.dart';
import '../../../app_config.dart';
import '../../../colors.dart';
import '../../../utils/custom_widget/custom_image.dart';
import '../../../utils/custom_widget/custom_text.dart';
import '../logic.dart';

class ProductImageWidget extends StatelessWidget {
  final String productId;

  const ProductImageWidget({required this.productId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsLogic>(
        init: Get.find<ProductDetailsLogic>(),
        id: 'images',
        builder: (logic) {
          return Column(
            children: [
              Stack(
                children: [
                  logic.productModel?.images?.length == 0
                      ? CustomImage(
                          url: "",
                          width: double.infinity,
                          height: 130.h,
                          size: 50,
                        )
                      : InkWell(
                          onTap: () =>
                              logic.goToImages(logic.productModel?.images),
                          child: CustomImage(
                            url: logic
                                .productModel
                                ?.images?[logic.selectedImageIndex]
                                .image
                                ?.small,
                            width: double.infinity,
                            height: 130.h,
                            size: 50,
                          ),
                        ),
                  if ((logic.productModel?.offerLabel != null ||
                      (logic.productModel?.offerLabel?.length ?? 0) > 0 )&& !AppConfig.enhancements)
                    Positioned(
                      left: !isArabicLanguage ? 15 : null,
                      right: isArabicLanguage ? 15 : null,
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 5, right: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 4),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15.sp)),
                        child: CustomText(
                          logic.productModel?.offerLabel,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          fontSize: 9,
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              buildImagesList(logic),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        });
  }

  Center buildImagesList(ProductDetailsLogic logic) {
    return Center(
      child: SizedBox(
        height: 45.h,
        width: (51 * (logic.productModel?.images?.length ?? 0)).w,
        child: ListView.builder(
          itemCount: logic.productModel?.images?.length ?? 0,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InkWell(
            onTap: () => logic.changeSelectedImage(index),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: logic.selectedImageIndex == index
                          ? secondaryColor
                          : Colors.grey.shade300,
                      width: 2),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: CustomImage(
                url: logic.productModel?.images?[index].image?.thumbnail,
                height: double.infinity,
                width: 30.w,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
