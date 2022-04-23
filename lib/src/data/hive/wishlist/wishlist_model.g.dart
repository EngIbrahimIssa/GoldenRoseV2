// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishlistModelAdapter extends TypeAdapter<WishlistModel> {
  @override
  final int typeId = 0;

  @override
  WishlistModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishlistModel(
      productId: fields[0] as String?,
      productName: fields[1] as String?,
      productQuantity: fields[2] as int?,
      productSalePrice: fields[3] as double,
      productPrice: fields[4] as double,
      productFormattedSalePrice: fields[5] as String?,
      productFormattedPrice: fields[6] as String?,
      productImage: fields[7] as String?,
      productHasOptions: fields[8] as bool,
      productHasFields: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, WishlistModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.productQuantity)
      ..writeByte(3)
      ..write(obj.productSalePrice)
      ..writeByte(4)
      ..write(obj.productPrice)
      ..writeByte(5)
      ..write(obj.productFormattedSalePrice)
      ..writeByte(6)
      ..write(obj.productFormattedPrice)
      ..writeByte(7)
      ..write(obj.productImage)
      ..writeByte(8)
      ..write(obj.productHasOptions)
      ..writeByte(9)
      ..write(obj.productHasFields);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
