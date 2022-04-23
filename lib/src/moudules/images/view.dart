import 'package:cached_network_image/cached_network_image.dart';
import 'package:entaj/src/entities/product_details_model.dart';
import 'package:entaj/src/utils/custom_widget/custom_image.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../images.dart';
import 'logic.dart';

class ImagesPage extends StatelessWidget {
  final List<Images> images;
   int selectedImageIndex;
  final ImagesLogic logic = Get.put(ImagesLogic());

  ImagesPage(this.images, this.selectedImageIndex,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: selectedImageIndex);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.grey.shade700,
                    child: const Icon(Icons.close)),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25.sp),
                ),
                child: PageView.builder(
                  onPageChanged: (page) {
                    selectedImageIndex = page;
                    logic.update();
                  },
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return PhotoView(
                      backgroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.sp),
                          color: Colors.black),
                        errorBuilder: (a, b, c) =>
                            Image.asset(iconLogo, color: Colors.white ,scale: 3,),
                        imageProvider: CachedNetworkImageProvider(images[index].image?.fullSize ?? '',));
                  },
                  controller: pageController,
                  physics: const ClampingScrollPhysics(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<ImagesLogic>(builder: (logic) {
              return Center(
                  child: CustomText(
                "${selectedImageIndex + 1}/${images.length}",
                color: Colors.white,
              ));
            })
          ],
        ),
      ),
    );
  }
}
