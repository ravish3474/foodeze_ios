
import 'dart:convert';

CateringSendModal cateringSendModalFromJson(String str) => CateringSendModal.fromJson(json.decode(str));

String cateringSendModalToJson(CateringSendModal data) => json.encode(data.toJson());

class CateringSendModal {
    CateringSendModal({
        this.menuItem,
    });

    List<MenuItem>? menuItem;

    factory CateringSendModal.fromJson(Map<String, dynamic> json) => CateringSendModal(
        menuItem: List<MenuItem>.from(json["menu_item"].map((x) => MenuItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "menu_item": List<dynamic>.from(menuItem!.map((x) => x.toJson())),
    };
}

class MenuItem {
    MenuItem({
        this.menuExtraItem,
        this.menuItemName,
        this.menuItemPrice,
        this.menuItemQuantity,
    });

    List<MenuExtraItem>? menuExtraItem;
    String? menuItemName;
    String? menuItemPrice;
    String? menuItemQuantity;

    factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        menuExtraItem: List<MenuExtraItem>.from(json["menu_extra_item"].map((x) => MenuExtraItem.fromJson(x))),
        menuItemName: json["menu_item_name"],
        menuItemPrice: json["menu_item_price"],
        menuItemQuantity: json["menu_item_quantity"],
    );

    Map<String, dynamic> toJson() => {
        "menu_extra_item": List<dynamic>.from(menuExtraItem!.map((x) => x.toJson())),
        "menu_item_name": menuItemName,
        "menu_item_price": menuItemPrice,
        "menu_item_quantity": menuItemQuantity,
    };
}

class MenuExtraItem {
    MenuExtraItem({
        this.menuExtraItemName,
        this.menuExtraItemPrice,
        this.menuExtraItemQuantity,
    });

    String? menuExtraItemName;
    String? menuExtraItemPrice;
    String? menuExtraItemQuantity;

    factory MenuExtraItem.fromJson(Map<String, dynamic> json) => MenuExtraItem(
        menuExtraItemName: json["menu_extra_item_name"],
        menuExtraItemPrice: json["menu_extra_item_price"],
        menuExtraItemQuantity: json["menu_extra_item_quantity"],
    );

    Map<String, dynamic> toJson() => {
        "menu_extra_item_name": menuExtraItemName,
        "menu_extra_item_price": menuExtraItemPrice,
        "menu_extra_item_quantity": menuExtraItemQuantity,
    };
}
