import '../../../entities/module_model.dart';
import '../../../utils/custom_widget/custom_image.dart';
import 'package:flutter/material.dart';
import '../../../colors.dart';
import '../../../utils/custom_widget/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PartnersWidget extends StatelessWidget {
    final String? title;
    final List<Gallery>? gallery;

  const PartnersWidget({Key? key, required this.title, required this.gallery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (gallery == null || gallery?.length == 0)
        ? const SizedBox()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    CustomText(
                      title ?? '',
                      fontSize: 17,
                      color: primaryColor,
                      fontWeight: FontWeight.w900,
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100.h,
                child: ListView.builder(
                    itemCount: gallery?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomImage(url: gallery?[index].image , width: 100,),
                        )),
              )
            ],
          );
  }
}
