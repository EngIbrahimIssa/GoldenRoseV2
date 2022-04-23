import 'dart:developer';

import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../.env.dart';
import 'shared_preferences.dart';

class PrefManger {
  static const SESSION = "SESSION";
  static const TOKEN = "TOKEN";
  static const AuthorizationToken = "AuthorizationToken";
  static const AccessToken = "AccessToken";
  static const RefreshToken = "RefreshToken";
  static const IS_LOGIN = "IS_LOGIN";
  static const IsHasError = "IsHasError";
  static const IS_VENDOR = "IS_VENDOR";
  static const IS_ARABIC = "IS_ARABIC";
  static const IsFromRemote = "IsFromRemote";
  static const IS_NOT_FIRST_TIME = "IS_NOT_FIRST_TIME";
  static const FULL_NAME = "FULL_NAME";

  //session
  Future setSession(String? session) async {
    await savePrefString(SESSION, session);
  }

  Future<String> getSession() async {
    return await getPrefString(SESSION);
  }

  //token
  Future setToken(String? token) async {
    await savePrefString(TOKEN, token);
  }

  Future<String> getToken() async {
    return await getPrefString(TOKEN);
  }

  final encrypter = Encrypter(AES(Key.fromUtf8(SECRET_ENCRYPT_KEY)));

  Future<void> setAuthorizationToken(String? token) async {
    try {
    //  log("setAuthorizationToken " + token.toString());
      final encrypted = encrypter.encrypt(token ?? '', iv: IV.fromLength(16));
      await savePrefString(AuthorizationToken, encrypted.base64);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> getAuthorizationToken() async {
    final String token = await getPrefString(AuthorizationToken);
    if (token == '') return token;
    final decrypted =
        encrypter.decrypt(Encrypted.fromBase64(token), iv: IV.fromLength(16));
 //   log("getAuthorizationToken " + decrypted.toString());
    return decrypted;
  }

  Future<void> setAccessToken(String? token) async {
    try {
 //     log("setAccessToken " + token.toString());
      final encrypted = encrypter.encrypt(token ?? '', iv: IV.fromLength(16));
      await savePrefString(AccessToken, encrypted.base64);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> getAccessToken() async {
    final String token = await getPrefString(AccessToken);
    if (token == '') return token;
    final decrypted =
        encrypter.decrypt(Encrypted.fromBase64(token), iv: IV.fromLength(16));
  //  log("getAccessToken " + decrypted.toString());
    return decrypted;
  }

  //fullName
  Future setFullName(String fullName) async {
    await savePrefString(FULL_NAME, fullName);
  }

  Future<String> getFullName() async {
    return await getPrefString(FULL_NAME);
  }

  //isFromRemote
  Future setIsFromRemote(bool isFromRemote) async {
    await savePrefBool(IsFromRemote, isFromRemote);
  }

  Future<bool> getIsFromRemote() async {
    return await getPrefBool(IsFromRemote);
  }
  //isLogin
  Future setIsLogin(bool isLogin) async {
    await savePrefBool(IS_LOGIN, isLogin);
  }

  Future<bool> getIsLogin() async {
    return await getPrefBool(IS_LOGIN);
  }

  //isHasError
  Future setIsHasError(bool hasError) async {
    await savePrefBool(IsHasError, hasError);
  }

  Future<bool> getIsHasError() async {
    return await getPrefBool(IsHasError);
  }

  //isVendor
  Future setIsVendor(bool isVendor) async {
    await savePrefBool(IS_VENDOR, isVendor);
  }

  Future<bool> getIsVendor() async {
    return await getPrefBool(IS_VENDOR);
  }

  //isArabicLanguage
  Future setIsArabic(bool isArabic) async {
    await savePrefBool(IS_ARABIC, isArabic);
  }

  Future<bool> getIsArabic() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool value= preferences.getBool(IS_ARABIC) ?? true;
    return value;
  }

  //isFirstTime
  Future setIsNotFirstTime(bool isFirstTime) async {
    await savePrefBool(IS_NOT_FIRST_TIME, isFirstTime);
  }

  Future<bool> getIsNotFirstTime() async {
    return await getPrefBool(IS_NOT_FIRST_TIME);
  }
}
