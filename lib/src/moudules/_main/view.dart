import 'dart:developer';

import '../../images.dart';
import 'widgets/my_drawer.dart';
import '../../utils/custom_widget/custom_text.dart';
import 'widgets/my_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../colors.dart';
import 'logic.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainLogic logic = Get.find();

  String subtitle = '';
  String content = '';
  String data = '';

  @override
  void initState() {
    super.initState();

    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult notification) {
      // Will be called whenever a notification is opened/button pressed.
      setState(() {
        subtitle = notification.notification.subtitle ?? '';
        content = notification.notification.body ?? '';
        data = notification.notification.additionalData?['data'];
      });
      log(subtitle);
      log(content);
      log(data);
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      event.complete(event.notification);
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {});

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // Will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
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
    newVersion.showAlertIfNecessary(context: context);
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
    return GetBuilder<MainLogic>(builder: (logic) {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        drawer: MyDrawer(),
        appBar: logic.showAppBar
            ? AppBar(
                backgroundColor: headerBackgroundColor,
                foregroundColor: headerForegroundColor,
                actions: [
                  if (false)
                    InkWell(
                        onTap: () => logic.goToNotification(),
                        child: SizedBox(
                          width: 50.w,
                          child: Stack(
                            children: [
                              Center(
                                  child: Image.asset(
                                iconNotify,
                                color: headerForegroundColor,
                              )),
                              Positioned(
                                left: 20.w,
                                top: 5,
                                right: 0,
                                child: const CircleAvatar(
                                  child: CustomText(
                                    "2",
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  backgroundColor: moveColor,
                                  radius: 12,
                                ),
                              )
                            ],
                          ),
                        )),
                  InkWell(
                      onTap: () => logic.goToSearch(),
                      child: Image.asset(iconSearch,
                          scale: 2, color: headerForegroundColor)),
                ],
                title: Image.asset(
                  iconLogoText,
                  height: 40.h,
                  color: headerLogoColor,
                ))
            : null,
        body: logic.currentScreen,
        bottomNavigationBar: const MyBottomNavigation(
          backCount: 0,
        ),
      );
    });
  }
}
