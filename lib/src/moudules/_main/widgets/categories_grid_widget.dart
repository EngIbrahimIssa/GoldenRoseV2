import '../logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../entities/category_model.dart';

import '../../../colors.dart';
import '../../../images.dart';
import '../../../utils/custom_widget/custom_image.dart';
import '../../../utils/custom_widget/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesGridWidget extends StatelessWidget {
  final String? title;
  final String? moreText;
  final List<CategoryModel>? categories;

  const CategoriesGridWidget(
      {Key? key,
      required this.title,
      required this.categories,
      required this.moreText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: CustomText(
                  title ?? '',
                  fontSize: 17,
                  color: primaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (moreText != null)
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                      onTap: () {
                        MainLogic mainLogic = Get.find();
                        mainLogic.changeSelectedValue(1, true, backCount: 0);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: CustomText(
                            moreText ?? "عرض الكل".tr,
                            color: primaryColor,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            maxLines: 1,
                          )),
                          const SizedBox(
                            width: 5,
                          ),
                          RotationTransition(
                              turns: AlwaysStoppedAnimation(
                                  (isArabicLanguage ? 180 : 0) / 360),
                              child: Image.asset(iconBack,
                                  color: primaryColor, scale: 2)),
                        ],
                      )),
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: SizedBox(
              height: 150.h,
              width: (100 * (categories?.length ?? 1)).toDouble(),
              child: ListView.builder(
                  itemCount: categories?.length ?? 0,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: InkWell(
                                  onTap: () => Get.toNamed(
                                      '/category-details/${categories?[index].id}'),
                                  child: CustomImage(
                                    url: categories?[index].image,
                                    width: 90,
                                    height: 90,
                                    size: 30,
                                  )),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              categories?[index].name,
                              color: secondaryColor,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
