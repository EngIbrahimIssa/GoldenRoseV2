import 'package:entaj/src/colors.dart';
import 'package:entaj/src/entities/module_model.dart';
import 'package:entaj/src/utils/custom_widget/custom_image.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturesWidget extends StatelessWidget {
  final List<StoreFeatures> storeFeatures;
  const FeaturesWidget({Key? key, required this.storeFeatures}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: headerBackgroundColor,
      width: double.infinity,
      child: Column(
        children: storeFeatures.map((e) => Column(
          children: [
            SizedBox(height: 10.h,),
            CustomImage(url: e.image/* , width: 300.w,*/),
            SizedBox(height: 10.h,),
            CustomText(e.title ,fontSize: 16 ,maxLines: 1, color: headerForegroundColor,)
          ],
        )).toList(),
      ),
    );
  }
}
