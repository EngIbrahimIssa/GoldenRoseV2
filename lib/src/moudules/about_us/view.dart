import '../../images.dart';
import '../_main/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logic.dart';

class AboutUsPage extends StatelessWidget {
  final AboutUsLogic logic = Get.put(AboutUsLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Image.asset(
              iconLogo,
              height: 100,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(15.sp)
                ),
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                    child: GetBuilder<MainLogic>(
                        init: Get.find<MainLogic>(),
                        builder: (logic) {
                      return logic.isStoreSettingLoading ? const CircularProgressIndicator() : Html(
                        data: logic.settingModel?.footer?.aboutUs?.text ?? '',);
                    })),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
