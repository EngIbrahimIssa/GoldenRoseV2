import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class AppEvents extends GetxController {
  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;
  //final _facebookAppEvents = FacebookAppEvents();

  Future<void> logScreenOpenEvent(String screenName) async {
    await _firebaseAnalytics.setCurrentScreen(screenName: screenName);
   // await _facebookAppEvents.setAutoLogAppEventsEnabled(true);
  }

  Future<void> logAddToCart(String? name, String? id, double? price) async {
    await _firebaseAnalytics.logAddToCart(
        items: [AnalyticsEventItem(itemName: name, price: price, itemId: id)]);
 //   await _facebookAppEvents.logAddToCart(id: id ?? '', type: 'product', currency: 'SAR', price: price ?? 0);
  }
  Future<void> logAddToWishlist(String? name, String? id, double? price) async {
    await _firebaseAnalytics.logAddToWishlist(
        items: [AnalyticsEventItem(itemName: name, price: price, itemId: id)]);
 //   await _facebookAppEvents.logAddToCart(id: id ?? '', type: 'product', currency: 'SAR', price: price ?? 0);
  }

  Future<void> logOpenProduct(
      {String? name, String? productId, String? price}) async {
    await _firebaseAnalytics.logEvent(name: 'view_product', parameters: {
      'product_id': productId,
      'product_name': name,
      'product_price': price,
    });
  //  await _facebookAppEvents.logEvent(name: 'view_product', parameters: {
  //    'product_id': productId,
  //    'product_name': name,
  //    'product_price': price,
   // });
  }

  Future<void> logSearchEvent(String searchTerm) async {
    await _firebaseAnalytics.logSearch(searchTerm: searchTerm);
  }

  Future<void> logCheckout(
      {String? coupon, List<AnalyticsEventItem>? items, double? value}) async {
    await _firebaseAnalytics.logBeginCheckout(
        value: value, currency: 'SAR', coupon: coupon, items: items);
   // await _facebookAppEvents.logInitiatedCheckout(
   //   totalPrice: value,
   //   currency: 'SAR',
   //   numItems: items?.length,
   // );
  }
}
