import '../../images.dart';
import '../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class NotificationPage extends StatelessWidget {
  final NotificationLogic logic = Get.put(NotificationLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: CustomText(
            "الإشعارات".tr,
            fontSize: 16,
          ),
          actions: [Padding(
            padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 20),
            child: Image.asset(iconLogoText),
          )],
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 10,
              ),
              logic.notificationList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Image.asset(iconNotification),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      "طلبك الآن جاهز للشحن، سيتم إعلامك في أقرب فرصة عن تفاصيل الشحن للمتابعة",
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      "رقم الطلب #845878",
                                      fontSize: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, bottom: 100),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_none,
                              color: Colors.grey,
                              size: 100.sp,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomText(
                              "لا توجد اشعارات في الوقت الحالي".tr,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
