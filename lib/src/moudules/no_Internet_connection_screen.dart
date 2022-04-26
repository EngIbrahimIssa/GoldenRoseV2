import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/custom_widget/custom_text.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  const NoInternetConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      width: double.infinity,
      height: 700.h,
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off,
            color: Colors.grey,
            size: 60,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomText(
            'يرجى التأكد من اتصالك بالإنترنت'.tr,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
