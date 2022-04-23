import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class FirebaseDynamicLinkService {
  static Future<String> createDynamicLink() async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://appsbunches.page.link',
      link: Uri.parse('https://teejangold.com/'),
      androidParameters: AndroidParameters(
          packageName: 'com.adobe.cc',
          minimumVersion: 2,
          fallbackUrl: Uri.parse(
              'https://play.google.com/store/apps/details?id=com.adobe.cc')),
      iosParameters: IOSParameters(
          bundleId: 'com.fanos.user',
          minimumVersion: '1.0.0',
          appStoreId: '1544077529',
          fallbackUrl: Uri.parse(
              'https://apps.apple.com/us/app/fanos-%D9%81%D8%A7%D9%86%D9%88%D8%B3/id1544077529')),
      socialMetaTagParameters: SocialMetaTagParameters(
          title: 'تطبيق تيجان جولد',
          description: 'حمل تطبيق تيجان جولد',
          imageUrl: Uri.parse(
              'https://media.zid.store/b2df7841-8071-401e-8883-77c9cb7cd9a1/851d3ee8-01a1-4d35-8885-044faf94b385-200x.png')),
    );

    var uri = await dynamicLinks.buildShortLink(parameters);

    return uri.shortUrl.toString();
  }
}
