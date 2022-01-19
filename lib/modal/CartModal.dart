import 'dart:collection';

import 'package:hive/hive.dart';

import 'ExtraMenuItemModal.dart';
import 'package:equatable/equatable.dart';

part 'CartModal.g.dart';

@HiveType(typeId: 1)
class CartModal extends Equatable {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? category;

  @HiveField(4)
  String? price;

  @HiveField(5)
  String? quantity;

  @HiveField(6)
  String? image;

  @HiveField(7)
  String? restaurantMenuId;

  @HiveField(8)
  String? restaurantId;

  @HiveField(9)
  String? restaurantName;

  @HiveField(10)
  String? rowId;

  @HiveField(11)
  List<ExtraMenuItemModal>? extraItemList;

  @HiveField(12)
  String? lat;

  @HiveField(13)
  String? long;

  @override
  String toString() {
    return 'CartModal{id: $id, name: $name, description: $description, category: $category, price: $price, quantity: $quantity, image: $image, restaurantMenuId: $restaurantMenuId, restaurantId: $restaurantId, restaurantName: $restaurantName, rowId: $rowId, extraItemList: $extraItemList, lat: $lat, long: $long}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is CartModal &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          category == other.category &&
          price == other.price &&
          quantity == other.quantity &&
          image == other.image &&
          restaurantMenuId == other.restaurantMenuId &&
          restaurantId == other.restaurantId &&
          restaurantName == other.restaurantName &&
          rowId == other.rowId &&
          extraItemList == other.extraItemList &&
          lat == other.lat &&
          long == other.long;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      category.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      image.hashCode ^
      restaurantMenuId.hashCode ^
      restaurantId.hashCode ^
      restaurantName.hashCode ^
      rowId.hashCode ^
      extraItemList.hashCode ^
      lat.hashCode ^
      long.hashCode;

  CartModal({
    this.id,
    this.name,
    this.description,
    this.category,
    this.price,
    this.quantity,
    this.image,
    this.restaurantMenuId,
    this.restaurantId,
    this.restaurantName,
    this.rowId,
    this.extraItemList,
    this.lat,
    this.long,
  });

  @override
  List<Object> get props => [
        id!,
        name!,
        description!,
        category!,
        price!,
        quantity!,
        image!,
        restaurantMenuId!,
        restaurantId!,
        restaurantName!,
        rowId!,
        extraItemList!,
        lat!,
        long!
      ];
}
