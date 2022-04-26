import '../../colors.dart';
import '../../data/hive/wishlist/hive_controller.dart';
import '../../images.dart';
import '../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../app_config.dart';
import '../../data/hive/wishlist/wishlist_model.dart';
import '../../utils/item_widget/item_wishlist.dart';
import 'logic.dart';

class WishlistPage extends StatelessWidget {
  final WishlistLogic logic = Get.put(WishlistLogic());

  WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: CustomText(
            "المفضلة".tr,
            fontSize: 16,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Image.asset(iconLogoText),
            ),
          ],
        ),
        body: ValueListenableBuilder<Box<WishlistModel>>(
            valueListenable: HiveController.getWishlist().listenable(),
            builder: (context, box, _) {
              final wishlist = box.values.toList().cast<WishlistModel>();
              if (wishlist.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.only(left: 50, right: 50, bottom: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.grey,
                        size: 50.sp,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                  fontFamily: AppConfig.fontName,
                                  color: Colors.grey,
                                  fontSize: 16.sp),
                              children: [
                                TextSpan(
                                  text:
                                      "لا يوجد منتجات في القائمة، أضف منتجات لقائمة التفضيل من خلال الضغط على أيقونة في بطاقة المنتج".tr,
                                ),
                                const WidgetSpan(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Icon(
                                    Icons.favorite,
                                    color: moveColor,
                                  ),
                                )),
                                TextSpan(text: "في بطاقة المنتج".tr),
                              ]))
                    ],
                  ),
                );
              }
              return Container(
                padding: EdgeInsets.fromLTRB(15.w, 20, 15.w, 0),
                child: GridView.builder(
                  itemCount: wishlist.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65),
                  itemBuilder: (context, index) => ItemWishlist(
                    wishlist[index],
                    index,
                    horizontal: false,
                  ),
                ),
              );
            }));
  }
}
