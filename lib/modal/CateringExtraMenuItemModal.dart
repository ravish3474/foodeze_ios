import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'CateringExtraMenuItemModal.g.dart';

@HiveType(typeId: 5)
class CateringExtraMenuItemModal extends Equatable  {


  final String? id;
  @HiveField(0)

  final  String? menuExtraItemName;
  @HiveField(1)

  final  String? menuExtraItemPrice;
  @HiveField(2)

  final String? menuExtraItemQuantity;
  @HiveField(3)

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is CateringExtraMenuItemModal &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          menuExtraItemName == other.menuExtraItemName &&
          menuExtraItemPrice == other.menuExtraItemPrice &&
          menuExtraItemQuantity == other.menuExtraItemQuantity;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      menuExtraItemName.hashCode ^
      menuExtraItemPrice.hashCode ^
      menuExtraItemQuantity.hashCode;


  @override
  String toString() {
    return 'CateringExtraMenuItemModal{id: $id, menuExtraItemName: $menuExtraItemName, menuExtraItemPrice: $menuExtraItemPrice, menuExtraItemQuantity: $menuExtraItemQuantity}';
  }





  const CateringExtraMenuItemModal({this.id, this.menuExtraItemName,
      this.menuExtraItemPrice, this.menuExtraItemQuantity});


  @override
  List<Object> get props => [id!,menuExtraItemName!,menuExtraItemPrice!,menuExtraItemQuantity!];


}

