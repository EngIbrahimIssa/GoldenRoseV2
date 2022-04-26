import '../../../../app_config.dart';
import '../../../../colors.dart';
import '../../../../images.dart';
import '../../logic.dart';
import '../../../../utils/custom_widget/custom_button_widget.dart';
import '../../../../utils/custom_widget/custom_list_tile.dart';
import '../../../../utils/custom_widget/custom_sized_box.dart';
import '../../../../utils/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../services/app_events.dart';
import 'logic.dart';

class AccountPage extends StatelessWidget {
  final AccountLogic logic = Get.put(AccountLogic());
  final MainLogic _mainLogic = Get.find();
  final AppEvents _appEvents = Get.find();

  AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _appEvents.logScreenOpenEvent('Account');
    logic.checkLoginState();
    return GetBuilder<AccountLogic>(builder: (logic) {
      return RefreshIndicator(
        onRefresh: () async {
          await logic.checkLoginState();
          await _mainLogic.getStoreSetting();
          logic.update();
        },
        child: Column(
          children: [
            AppBar(
              backgroundColor: headerBackgroundColor,
              foregroundColor: headerForegroundColor,
              // backgroundColor: blueLightSplashBackgroundColor,
              title: CustomText(
                "حسابي".tr,
                color: headerForegroundColor,
                fontSize: 16,
              ),
              actions: [
                if (logic.isLogin && logic.userModel != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: Image.asset(
                      iconLogoText,
                      color: headerLogoColor,
                    ),
                  )
              ],
            ),
            GetBuilder<AccountLogic>(
                id: "account",
                builder: (logic) {
                  return logic.isLoading && logic.userModel == null
                      ? const Center(child: CircularProgressIndicator())
                      : Stack(
                          children: [
                            Positioned(
                                left: -70.w,
                                right: -70.w,
                                top: (logic.isLogin && logic.userModel != null) ? -150.h : -120.h,
                                child: RotationTransition(
                                  turns: const AlwaysStoppedAnimation(-1.9 / 360),
                                  child: Image.asset(
                                    imageArt,
                                    color: blueLightSplashBackgroundColor,
                                    height: 300.h,
                                  ),
                                )),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                                child: (logic.isLogin && logic.userModel != null)
                                    ? Padding(
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        child: Row(
                                          children: [
                                            CustomText(
                                              "أهلا بك ".tr + logic.userModel!.name.toString(),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                            const Spacer(),
                                            logic.isLogoutLoading
                                                ? const CircularProgressIndicator(
                                                    strokeWidth: 1,
                                                  )
                                                : InkWell(
                                                    onTap: () => logic.logout(),
                                                    child: Row(
                                                      children: [
                                                        CustomText(
                                                          "خروج".tr,
                                                          fontSize: 14,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Image.asset(
                                                          iconLogout,
                                                          scale: 2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Image.asset(
                                            iconLogo,
                                            height: 85.h,
                                            fit: BoxFit.fitHeight,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(50.w, 10.h, 50.w, 0),
                                            child: CustomButtonWidget(
                                              title: "تسجيل / دخول مستخدم".tr,
                                              onClick: () => logic.goToLogin(),
                                              color: buttonBackgroundLoginColor,
                                              textColor: buttonTextLoginColor,
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        );
                }),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        if (logic.isLogin && logic.userModel != null)
                          CustomListTile(
                              "تعديل الملف الشخصي".tr, () => logic.goToEditAccount(), iconEdit),
                        if (AppConfig.isEnableWishlist)
                          CustomListTile(
                            "المفضلة".tr,
                            () {
                              logic.goWishlistPage();
                            },
                            iconWishlist,
                          ),
                        /*  if (logic.isLogin && logic.userModel != null)
                          CustomListTile(
                            "عنواني".tr,
                            () {},
                            iconLocation,
                          ),*/
                        if (AppConfig.isEnglishLanguageEnable)
                          InkWell(
                            onTap: () => logic.changeLanguage(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Row(
                                children: [
                                  Image.asset(
                                    iconLanguage,
                                    scale: 2,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                    "لغة التطبيق".tr,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const Spacer(),
                                  CustomText(
                                    "العربية".tr,
                                    fontWeight: FontWeight.bold,
                                    color: greenLightColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        Divider(
                          thickness: 3,
                          color: Colors.grey.shade200,
                        ),
                      ],
                    ),
                    if (_mainLogic.settingModel?.footer?.aboutUs?.enabled == true)
                      CustomListTile(
                        "من نحن".tr,
                        () => logic.goToAboutUsPage(),
                        iconAbout,
                      ),
                    if (_mainLogic.pageModelPrivacy?.contentWithoutTags?.isNotEmpty == true)
                      GetBuilder<AccountLogic>(
                          id: "privacy",
                          builder: (logic) {
                            return logic.isPrivacyLoading
                                ? const Center(child: CircularProgressIndicator())
                                : CustomListTile("سياسة الخصوصية والاستخدام".tr,
                                    () => logic.goToPrivacyPolicy(), iconPolices);
                          }),
                    if (_mainLogic.pageModelTerms?.contentWithoutTags?.isNotEmpty == true)
                      CustomListTile(
                        "الشروط والأحكام".tr,
                        () => logic.goToTermsAndConditions(),
                        iconPaper,
                      ),
                    if (_mainLogic.pageModelRefund?.contentWithoutTags?.isNotEmpty == true)
                      GetBuilder<AccountLogic>(
                          id: "refund",
                          builder: (logic) {
                            return logic.isRefundLoading
                                ? const Center(child: CircularProgressIndicator())
                                : CustomListTile(
                                    "سياسة الإستبدال والاسترجاع".tr,
                                    () => logic.getRefundPolicy(),
                                    iconRefund,
                                  );
                          }),
                    if (_mainLogic.pageModelSuggestions?.contentWithoutTags?.isNotEmpty == true)
                      CustomListTile(
                        "الشكاوى والاقتراحات".tr,
                        () => logic.goToSuggestions(),
                        iconPaper,
                      ),
                    if (_mainLogic.faqList.isNotEmpty)
                      CustomListTile(
                        'الأسئلة الشائعة'.tr,
                        () => logic.goToFaq(),
                        iconPaper,
                      ),
                    CustomListTile(
                      "خيارات الشحن".tr,
                      () => logic.goToShippingMethod(),
                      iconDeliveryMethod,
                    ),
                    CustomListTile(
                      "شارك التطبيق".tr,
                      () => logic.shareApp(),
                      iconShare,
                    ),
                    GetBuilder<MainLogic>(
                        id: 'pages',
                        init: Get.find<MainLogic>(),
                        builder: (mainLogic) {
                          return AppConfig.isSoreUseNewTheme
                              ? CustomListTile(
                                  "الصفحات الإضافية".tr,
                                  () => logic.goToPagesPage(),
                                  iconPaper,
                                )
                              : mainLogic.pagesList.isEmpty
                                  ? const SizedBox()
                                  : CustomListTile(
                                      "الصفحات الإضافية".tr,
                                      () => logic.goToPagesPage(),
                                      iconPaper,
                                    );
                        }),
                    if (AppConfig.showShippingTo)
                      Divider(
                        thickness: 3,
                        color: Colors.grey.shade200,
                      ),
                    if (AppConfig.showShippingTo)
                      CustomListTile(
                        "الشحن إلى".tr,
                        () => logic.goToCountries(),
                        iconDeliveryMethod,
                      ),
                    Divider(
                      thickness: 3,
                      color: Colors.grey.shade200,
                    ),
                     (_mainLogic.settingModel?.footer?.socialMedia?.items?.twitter == null &&
                        _mainLogic.settingModel?.footer?.socialMedia?.items?.facebook == null &&
                        _mainLogic.settingModel?.footer?.socialMedia?.items?.instagram == null &&
                        _mainLogic.settingModel?.footer?.socialMedia?.items?.snapchat == null)?SizedBox():
                      Container(
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            color: Colors.grey.shade100),
                        child: Row(
                          children: [
                            CustomText(
                              "شبكاتنا".tr,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            const Spacer(),
                            if (_mainLogic.settingModel?.footer?.socialMedia?.items?.twitter !=
                                null)
                              InkWell(
                                onTap: () => logic.goToTwitter(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    iconTwitter,
                                    color: socialMediaIconColor,
                                    scale: 2,
                                  ),
                                ),
                              ),
                            if (_mainLogic.settingModel?.footer?.socialMedia?.items?.snapchat !=
                                null)
                              InkWell(
                                onTap: () => logic.goToLinkedin(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    iconSnapchat,
                                    color: socialMediaIconColor,
                                    scale: 2,
                                  ),
                                ),
                              ),
                            if (_mainLogic.settingModel?.footer?.socialMedia?.items?.instagram !=
                                null)
                              InkWell(
                                onTap: () => logic.goToInstagram(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    iconInstagram,
                                    color: socialMediaIconColor,
                                    scale: 2,
                                  ),
                                ),
                              ),
                            if (_mainLogic.settingModel?.footer?.socialMedia?.items?.facebook !=
                                null)
                              InkWell(
                                onTap: () => logic.goToFacebook(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    iconFacebook,
                                    color: socialMediaIconColor,
                                    scale: 2,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            "تواصل معنا".tr,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          const CustomSizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (AppConfig.showCall)
                                Expanded(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(25.sp),
                                    onTap: () => logic.goToPhone(),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25.sp),
                                          color: greenLightColor),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const CustomSizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            iconCall,
                                            scale: 2,
                                            color: buttonTextCallColor,
                                          ),
                                          const CustomSizedBox(
                                            width: 5,
                                          ),
                                          CustomText(
                                            "اتصال".tr,
                                            fontSize: 11,
                                            color: buttonTextCallColor,
                                          ),
                                          const CustomSizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              const CustomSizedBox(
                                width: 5,
                              ),
                              if (AppConfig.showWhatsApp)
                                Expanded(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(25.sp),
                                    onTap: () => logic.goToWhatsApp(),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25.sp),
                                          color: greenLightColor),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const CustomSizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            iconWhatsapp,
                                            scale: 2,
                                            color: buttonTextCallColor,
                                          ),
                                          const CustomSizedBox(
                                            width: 5,
                                          ),
                                          CustomText(
                                            "واتس اب".tr,
                                            fontSize: 11,
                                            color: buttonTextCallColor,
                                          ),
                                          const CustomSizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              const CustomSizedBox(
                                width: 5,
                              ),
                              if (AppConfig.showEmail)
                                Expanded(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(25.sp),
                                    onTap: () => logic.goToEmail(),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25.sp),
                                          color: greenLightColor),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const CustomSizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            iconMail,
                                            scale: 2,
                                            color: buttonTextCallColor,
                                          ),
                                          const CustomSizedBox(
                                            width: 5,
                                          ),
                                          CustomText(
                                            "ايميل".tr,
                                            fontSize: 11,
                                            color: buttonTextCallColor,
                                          ),
                                          const CustomSizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                          const CustomSizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    if (AppConfig.showAppsBunchesLogo)
                      Divider(
                        thickness: 3,
                        color: Colors.grey.shade200,
                      ),
                    if (AppConfig.showAppsBunchesLogo)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            "تطوير".tr,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                          const CustomSizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () => logic.goToAppBunchesSite(),
                            child: Image.asset(
                              imageAppsBunches,
                              scale: 2,
                            ),
                          )
                        ],
                      ),
                    const CustomSizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
