import 'package:entaj/src/binding.dart';
import 'package:entaj/src/colors.dart';
import 'package:entaj/src/entities/category_model.dart';
import 'package:entaj/src/moudules/category_details/view.dart';
import 'package:entaj/src/utils/custom_widget/custom_image.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemCategory extends StatelessWidget {
  final CategoryModel? categoryModel;

  const ItemCategory(this.categoryModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.sp),
      onTap: () => categoryModel == null
          ? null
          : Get.toNamed("/category-details/${categoryModel?.id}"),
/*Get.to(CategoryDetailsPage(categoryModel: categoryModel,) , binding: Binding())*/
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.sp),
        child: Container(
          color: categoryBackgroundColor,
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: CustomImage(
                    url: categoryModel?.image,
                    width: double.infinity,
                    size: 30,
                  )),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        categoryModel?.name,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: categoryTextColor,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      CustomText(
                        categoryModel?.description ??
                            categoryModel?.sEOCategoryDescription,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: categoryTextColor,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
