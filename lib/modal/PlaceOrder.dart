// To parse this JSON data, do
//
//     final availableLocModal = availableLocModalFromJson(jsonString);

import 'dart:convert';

PlaceOrderExtraItemModal availableLocModalFromJson(String str) => PlaceOrderExtraItemModal.fromJson(json.decode(str));

String availableLocModalToJson(PlaceOrderExtraItemModal data) => json.encode(data.toJson());

class PlaceOrderExtraItemModal {
  PlaceOrderExtraItemModal({
    this.userId,
    this.quantity,
    this.paymentId,
    this.addressId,
    this.restaurantId,
    this.cod,
    this.riderTip,
    this.tax,
    this.subTotal,
    this.instructions,
    this.couponId,
    this.device,
    this.version,
    this.deliveryFee,
    this.delivery,
    this.order_time,
    this.menuItem,
  });

  String? userId;
  String? quantity;
  String? paymentId;
  String? addressId;
  String? restaurantId;
  String? cod;
  String? riderTip;
  String? tax;
  String? subTotal;
  String? instructions;
  String? couponId;
  String? device;
  String? version;
  String? deliveryFee;
  String? delivery;
  String? order_time;
  List<MenuItem>? menuItem;

  factory PlaceOrderExtraItemModal.fromJson(Map<String, dynamic> json) => PlaceOrderExtraItemModal(
    userId: json["user_id"],
    quantity: json["quantity"],
    paymentId: json["payment_id"],
    addressId: json["address_id"],
    restaurantId: json["restaurant_id"],
    cod: json["cod"],
    riderTip: json["rider_tip"],
    tax: json["tax"],
    subTotal: json["sub_total"],
    instructions: json["instructions"],
    couponId: json["coupon_id"],
    device: json["device"],
    version: json["version"],
    deliveryFee: json["delivery_fee"],
    delivery: json["delivery"],
    order_time: json["order_time"],
    menuItem: List<MenuItem>.from(json["menu_item"].map((x) => MenuItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "quantity": quantity,
    "payment_id": paymentId,
    "address_id": addressId,
    "restaurant_id": restaurantId,
    "cod": cod,
    "rider_tip": riderTip,
    "tax": tax,
    "sub_total": subTotal,
    "instructions": instructions,
    "coupon_id": couponId,
    "device": device,
    "version": version,
    "delivery_fee": deliveryFee,
    "delivery": delivery,
    "order_time": order_time,
    "menu_item": List<dynamic>.from(menuItem!.map((x) => x.toJson())),
  };
}

class MenuItem {
  MenuItem({
    this.menuItemName,
    this.menuItemQuantity,
    this.menuItemPrice,
    this.menuExtraItem,
  });

  String? menuItemName;
  String? menuItemQuantity;
  String? menuItemPrice;
  List<MenuExtraItem>? menuExtraItem;

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
    menuItemName: json["menu_item_name"],
    menuItemQuantity: json["menu_item_quantity"],
    menuItemPrice: json["menu_item_price"],
    menuExtraItem: List<MenuExtraItem>.from(json["menu_extra_item"].map((x) => MenuExtraItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "menu_item_name": menuItemName,
    "menu_item_quantity": menuItemQuantity,
    "menu_item_price": menuItemPrice,
    "menu_extra_item": List<dynamic>.from(menuExtraItem!.map((x) => x.toJson())),
  };
}

class MenuExtraItem {
  MenuExtraItem({
    this.menuExtraItemName,
    this.menuExtraItemQuantity,
    this.menuExtraItemPrice,
  });

  String? menuExtraItemName;
  String? menuExtraItemQuantity;
  String? menuExtraItemPrice;

  factory MenuExtraItem.fromJson(Map<String, dynamic> json) => MenuExtraItem(
    menuExtraItemName: json["menu_extra_item_name"],
    menuExtraItemQuantity: json["menu_extra_item_quantity"],
    menuExtraItemPrice: json["menu_extra_item_price"],
  );

  Map<String, dynamic> toJson() => {
    "menu_extra_item_name": menuExtraItemName,
    "menu_extra_item_quantity": menuExtraItemQuantity,
    "menu_extra_item_price": menuExtraItemPrice,
  };
}
