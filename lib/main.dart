import 'dart:developer';

import 'package:entaj/src/.env.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/app_config.dart';
import 'src/binding.dart';
import 'src/colors.dart';
import 'src/data/hive/wishlist/wishlist_model.dart';
import 'src/data/shared_preferences/pref_manger.dart';
import 'src/localization/translations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:oktoast/oktoast.dart';

import 'src/moudules/category_details/view.dart';
import 'src/moudules/product_details/view.dart';
import 'src/splash/view.dart';

bool isArabicLanguage = true;
late FirebaseRemoteConfig remoteConfig;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('general_box');

  remoteConfig = FirebaseRemoteConfig.instance;

  if(AppConfig.isEnglishLanguageEnable){
    isArabicLanguage = await PrefManger().getIsArabic();
  }
  if (AppConfig.isEnableWishlist) {
    Hive.registerAdapter(WishlistModelAdapter());
    await Hive.openBox<WishlistModel>('wishlist_box');
  }

  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  log("###+> ${initialLink?.link.toString()}");

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Binding().dependencies();

  OneSignal.shared.setAppId(OneSignalAppId);

   OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    log("Accepted permission: $accepted");
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => GetMaterialApp(
          builder: (context, widget) {
            //add this line
            ScreenUtil.setContext(context);
            return MediaQuery(
              //Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
          ],
          debugShowCheckedModeBanner: false,
          title: appName,
          locale: Locale(isArabicLanguage ? 'ar' : 'en'),
          fallbackLocale: Locale(isArabicLanguage ? 'ar' : 'en'),
          initialBinding: Binding(),
          translations: Translation(),
          theme: ThemeData(
              fontFamily: AppConfig.fontName,
              primarySwatch: mainColor,
              appBarTheme: const AppBarTheme(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: primaryColor,
              )),
          getPages: [
            GetPage(
                name: '/product-details/:productId',
                page: () => ProductDetailsPage()),
            GetPage(
                name: '/category-details/:categoryId',
                page: () => const CategoryDetailsPage()),
          ],
          home: const SplashPage(),
        ),
      ),
    );
  }
}
