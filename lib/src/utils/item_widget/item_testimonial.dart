import 'package:entaj/src/entities/home_screen_model.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemTestimonial extends StatelessWidget {
  final Items? item;
  const ItemTestimonial({Key? key,this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 15,
        ),
        Container(
          width: 300.w,
          padding: EdgeInsets.all(15.sp),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius:
              BorderRadius.circular(20.sp)),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              CustomText(
                item?.author,
                fontSize: 11,
                maxLines: 1,
                fontWeight: FontWeight.bold,
              ),
              Expanded(
                child: CustomText(
                  item?.text,
                  textAlign: TextAlign.start,
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
