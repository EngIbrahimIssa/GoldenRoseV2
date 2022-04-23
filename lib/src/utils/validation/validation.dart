import 'package:get/get.dart';

class Validation {

  static String? commentValidate(val) {
    return val!.isEmpty ? 'التعليق مطلوب'.tr : null;
  }

  static String? nameValidate(val) {
    return val!.isEmpty ? 'الاسم الكامل مطلوب'.tr : null;
  }

  static String? emailValidate(val) {
    return val!.isEmpty
        ? 'البريد الإلكتروني مطلوب'.tr
        : !GetUtils.isEmail(val)
            ? "البريد الالكتروني غير صالح".tr
            : null;
  }

  static String? phoneValidate(val) {
    return val!.isEmpty
        ? 'رقم الجوال مطلوب'.tr
        : val.length != 9
            ? "يجب ان يتكون الرقم من 9 أرقام".tr
            : null;
  }
  static String? phoneOTP(val) {
    return val!.isEmpty
        ? 'رمز التأكيد مطلوب'.tr
        : val.length != 4
            ? "يجب ان يتكون الرمز من 4 أرقام".tr
            : null;
  }

  static String? passwordValidate(val) {
    return val!.isEmpty ? 'كلمة المرور مطلوبة'.tr : null;
  }

}
