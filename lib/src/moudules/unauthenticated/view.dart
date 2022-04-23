import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_version/new_version.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../colors.dart';
import '../../images.dart';
import '../../.env.dart';
import '../../utils/custom_widget/custom_button_widget.dart';
import '../../utils/custom_widget/custom_sized_box.dart';
import '../../utils/custom_widget/custom_text.dart';
import 'logic.dart';

class UnauthenticatedPage extends StatefulWidget {
  @override
  State<UnauthenticatedPage> createState() => _UnauthenticatedPageState();
}

class _UnauthenticatedPageState extends State<UnauthenticatedPage> {
  final logic = Get.put(UnauthenticatedLogic());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkNewAppVersion();
  }


  void checkNewAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // Instantiate NewVersion manager object (Using GCP Console app as example)
    final newVersion = NewVersion(
      iOSId: packageInfo.packageName,
      androidId: packageInfo.packageName,
    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = true;

    if (simpleBehavior) {
      basicStatusCheck(newVersion);
    } else {
      advancedStatusCheck(newVersion);
    }
  }

  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context:context);
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      log(status.releaseNotes ?? '');
      log(status.appStoreLink);
      log(status.localVersion);
      log(status.storeVersion);
      log(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Custom Title',
        dialogText: 'Custom Text',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: GetBuilder<UnauthenticatedLogic>(builder: (logic) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  iconLogo,
                  height: 60.h,
                ),
                const SizedBox(
                  height: 40,
                ),
                Icon(
                  Icons.notifications,
                  color: Colors.grey.shade400,
                  size: 80.sp,
                ),
                const CustomSizedBox(
                  height: 30,
                ),
                CustomText("نعتذر لك التطبيق لا يعمل الآن".tr , fontSize: 14,),
                const CustomSizedBox(
                  height: 30,
                ),
                const CustomSizedBox(
                  height: 30,
                ),
                CustomButtonWidget(
                  title: "الانتقال للمتجر".tr,
                  color: greenLightColor,
                  width: 300.w,
                  onClick: () => launch(storeUrl),
                ),
                const CustomSizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
