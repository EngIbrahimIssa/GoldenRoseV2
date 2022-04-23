import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'wishlist_model.dart';

class HiveController extends GetxController {
  static Box<WishlistModel> getWishlist() =>
      Hive.box<WishlistModel>('wishlist_box');


 static var generalBox = Hive.box('general_box');


}