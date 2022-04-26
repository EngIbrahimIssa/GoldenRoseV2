import 'package:flutter/material.dart';

import 'app_config.dart';


/// Main - Header
final headerBackgroundColor = primaryColor;
final headerForegroundColor = HexColor.fromHex('#FFFFFF');
const headerLogoColor = Colors.white;
//final headerIcon = HexColor.fromHex('#1D1D1D');

/// Main - Bottom Navigation
final bottomBackgroundColor = HexColor.fromHex('#FFFFFF');
final bottomSelectedIconColor = primaryColor;
final bottomUnselectedIconColor = HexColor.fromHex('#9FA4B2');

/// Authentication
final authButtonColor = primaryColor;
final authTextButtonColor = HexColor.fromHex('#ffffff');
final authBackgroundColor = HexColor.fromHex('#eeeeee');
final authForegroundAppbarColor = HexColor.fromHex('#000000');
final authBackgroundAppbarColor = HexColor.fromHex('#ffffff');

/// Categories
const categoryBackgroundColor = Colors.white;
const categoryTextColor = Colors.black;

const categoryHomeBackgroundColor = Colors.white;
const categoryHomeTextColor = Colors.black;

/// DropDown
const dropdownColor = Colors.grey;
const dropdownTextColor = Colors.white;
final dropdownDividerLineColor = Colors.grey.shade800;

/// Buttons.
//Login
const buttonBackgroundLoginColor =
AppConfig.showButtonWithBorder ? primaryColor: Colors.white;
const buttonTextLoginColor =
AppConfig.showButtonWithBorder ? Colors.white : primaryColor;

//Checkout
final buttonBackgroundCheckoutColor =primaryColor ;
final buttonTextCheckoutColor = Colors.white;
//Coupon
final buttonBackgroundCouponColor = primaryColor;
final buttonTextCouponColor = Colors.white;
//Call
final buttonBackgroundCallColor = primaryColor;
final buttonTextCallColor =Colors.white;
//add to cart loading
const progressColor =
    AppConfig.showButtonWithBorder ? primaryColor : Colors.white;
const textAddToCartColor =
AppConfig.showButtonWithBorder ? primaryColor : Colors.white;

/// Icons
const socialMediaIconColor = Color(0xff766030);
final iconAddToCartColor = HexColor.fromHex("#ffffff");


const primaryColor = Color(0xffcbb085);
const secondaryColor = primaryColor;
// const secondaryColor = Color.fromRGBO(132, 78, 53, 1.0);
const errorBackgroundColor = Color(0xFF616161);

const greenColor = Color(0xffcbb085);

const moveColor = Color.fromRGBO(234, 127, 127, 1.0);
const greyColor = Color.fromRGBO(159, 164, 178, 1.0);
const blueLightColor = Color.fromRGBO(179, 211, 218, 1.0);
const greenLightColor = Color(0xffcbb085);
const yalowColor = Color.fromRGBO(255, 215, 80, 1.0);
final baseColor =  Colors.grey.shade100;
final highlightColor = Colors.grey.shade300;
const blueLightSplashBackgroundColor = Color.fromRGBO(255, 255, 255, 1.0);

Map<int, Color> mapColor = {
  50: const Color.fromRGBO(203, 176 , 133, .1),
  100: const Color.fromRGBO(203, 176, 133, .2),
  200: const Color.fromRGBO(203, 176, 133, .3),
  300: const Color.fromRGBO(203, 176, 133, .4),
  400: const Color.fromRGBO(203, 176, 133, .5),
  500: const Color.fromRGBO(203, 176, 133, .6),
  600: const Color.fromRGBO(203, 176, 133, .7),
  700: const Color.fromRGBO(203, 176, 133, .8),
  800: const Color.fromRGBO(203, 176, 133, .9),
  900: const Color.fromRGBO(203, 176, 133, 1),
};

MaterialColor mainColor = MaterialColor(0xffcbb085, mapColor);

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
