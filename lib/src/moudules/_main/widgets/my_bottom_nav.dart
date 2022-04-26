import '../../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../colors.dart';
import '../../../images.dart';
import '../logic.dart';
import '../tabs/cart/logic.dart';

class MyBottomNavigation extends StatelessWidget {
  final int backCount;

  const MyBottomNavigation({Key? key, required this.backCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLogic>(builder: (logic) {
      double iconSize = 20.sp;
      return Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          backgroundColor: bottomBackgroundColor,
          unselectedItemColor: bottomUnselectedIconColor,
          selectedItemColor: bottomSelectedIconColor,
          elevation: 50,
          currentIndex: logic.navigatorValue,
          selectedLabelStyle:
              TextStyle(fontSize: 13.sp, overflow: TextOverflow.ellipsis),
          unselectedLabelStyle:
              TextStyle(fontSize: 13.sp, overflow: TextOverflow.ellipsis),
          onTap: (index) =>
              logic.changeSelectedValue(index, true, backCount: backCount),
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Image.asset(
                    iconHome,
                    width: iconSize,
                    height: iconSize,
                    color: logic.navigatorValue == 0 ? bottomSelectedIconColor : bottomUnselectedIconColor,
                  ),
                ),
                label: "المتجر".tr),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Image.asset(
                    iconCategories,
                    width: iconSize,
                    height: iconSize,
                    color: logic.navigatorValue == 1 ? bottomSelectedIconColor : bottomUnselectedIconColor,
                  ),
                ),
                label: "التصنيفات".tr),
            BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: Center(
                        child: Image.asset(
                          iconCart,
                          width: iconSize,
                          height: iconSize,
                          color: logic.navigatorValue == 2
                              ? bottomSelectedIconColor
                              : bottomUnselectedIconColor,
                        ),
                      ),
                    ),
                    GetBuilder<CartLogic>(
                        init: Get.find<CartLogic>(),
                        id: 'cart',
                        builder: (logic) {
                          if ((logic.cartModel?.productsCount ?? 0) > 0) {
                            return Positioned(
                              top: 0.0,
                              left: 20.0.w,
                              child: CircleAvatar(
                                  radius: 9.sp,
                                  backgroundColor: moveColor,
                                  child: CustomText(
                                    logic.cartModel?.productsCount.toString(),
                                    fontSize: 10,
                                    color: Colors.white,
                                  )),
                            );
                          }
                          return const SizedBox();
                        })
                  ],
                ),
                label: "السلة".tr),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Image.asset(
                    iconOrders,
                    width: iconSize,
                    height: iconSize,
                    color: logic.navigatorValue == 3 ? bottomSelectedIconColor : bottomUnselectedIconColor,
                  ),
                ),
                label: "طلباتي".tr),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Image.asset(
                    iconAccount,
                    width: iconSize,
                    height: iconSize,
                    color: logic.navigatorValue == 4 ? bottomSelectedIconColor : bottomUnselectedIconColor,
                  ),
                ),
                label: "حسابي".tr),
          ],
        ),
      );
    });
  }
}
