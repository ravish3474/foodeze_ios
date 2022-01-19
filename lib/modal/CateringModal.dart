import 'dart:collection';

import 'package:hive/hive.dart';

import 'CateringExtraMenuItemModal.dart';
import 'ExtraMenuItemModal.dart';
import 'package:equatable/equatable.dart';


part 'CateringModal.g.dart';

@HiveType(typeId: 4)
class CateringModal extends Equatable  {
  @HiveField(0)
  final String? id;


  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? price;

  @HiveField(3)
   String? quantity;

  @HiveField(4)
  final List<CateringExtraMenuItemModal>? extraItemList;
  @override
  String toString() {
    return 'CateringModal{id: $id, name: $name, price: $price, quantity: $quantity, extraItemList: $extraItemList}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is CateringModal &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          quantity == other.quantity &&
          extraItemList == other.extraItemList;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      extraItemList.hashCode;






    CateringModal({this.id, this.name, this.price, this.quantity,
      this.extraItemList});




  @override
  List<Object> get props => [id!,name!,price!,quantity!,extraItemList!];








}





