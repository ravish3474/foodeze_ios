


import 'package:hive/hive.dart';

part 'ExtraMenuItemModal.g.dart';

@HiveType(typeId: 2)
class ExtraMenuItemModal {

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? price;
  @HiveField(3)
  String? restaurant_menu_extra_section_id;
  @HiveField(4)
  String? restaurant_id;
  @HiveField(5)
  String? restaurant_menu_item_id;
  @HiveField(6)
  String? title;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExtraMenuItemModal &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          restaurant_menu_extra_section_id ==
              other.restaurant_menu_extra_section_id &&
          restaurant_id == other.restaurant_id &&
          restaurant_menu_item_id == other.restaurant_menu_item_id &&
          title == other.title;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      restaurant_menu_extra_section_id.hashCode ^
      restaurant_id.hashCode ^
      restaurant_menu_item_id.hashCode ^
      title.hashCode;


  @override
  String toString() {
    return 'ExtraMenuItemModal{id: $id, name: $name, price: $price, restaurant_menu_extra_section_id: $restaurant_menu_extra_section_id, title: $title, restaurant_id: $restaurant_id, restaurant_menu_item_id: $restaurant_menu_item_id}';
  }




  ExtraMenuItemModal({
    this.id,
    this.name,
    this.price,
    this.restaurant_menu_extra_section_id,
    this.title,
    this.restaurant_id,
    this.restaurant_menu_item_id });






}

