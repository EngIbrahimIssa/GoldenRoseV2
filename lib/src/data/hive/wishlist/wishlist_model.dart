import 'package:hive/hive.dart';

part 'wishlist_model.g.dart';

@HiveType(typeId: 0)
class WishlistModel extends HiveObject {
  @HiveField(0)
  final String? productId;

  @HiveField(1)
  final String? productName;

  @HiveField(2)
  final int? productQuantity;

  @HiveField(3)
  final double productSalePrice;

  @HiveField(4)
  final double productPrice;

  @HiveField(5)
  final String? productFormattedSalePrice;

  @HiveField(6)
  final String? productFormattedPrice;

  @HiveField(7)
  final String? productImage;

  @HiveField(8)
  final bool productHasOptions;

  @HiveField(9)
  final bool productHasFields;

  WishlistModel(
      {required this.productId,
      required this.productName,
      required this.productQuantity,
      required this.productSalePrice,
      required this.productPrice,
      required this.productFormattedSalePrice,
      required this.productFormattedPrice,
      required this.productImage,
      required this.productHasOptions,
      required this.productHasFields});
}
