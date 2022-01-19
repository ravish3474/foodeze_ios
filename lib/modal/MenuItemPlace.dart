
class MenuItemPlace {
  String? menu_item_name;
  String? menu_item_quantity;
  String? menu_item_price;
  List<MenuExtraItemPlace>? menu_extra_item;

  @override
  String toString() {
    return 'menu_item{menu_item_name: $menu_item_name, menu_item_quantity: $menu_item_quantity, menu_item_price: $menu_item_price, menu_extra_item: $menu_extra_item}';
  }

  MenuItemPlace({this.menu_item_name, this.menu_item_quantity, this.menu_item_price, this.menu_extra_item});




  Map toJson() => {
    'menu_item_name':menu_item_name,
    'menu_item_quantity':menu_item_quantity,
    'menu_item_price':menu_item_price,
    "menu_extra_item": List<MenuExtraItemPlace>.from(menu_extra_item!.map((x) => x.toJson())),
  };






}

class MenuExtraItemPlace{
String? menu_extra_item_name;
String? menu_extra_item_quantity;
String? menu_extra_item_price;

@override
String toString() {
  return 'menu_extra_item{menu_extra_item_name: $menu_extra_item_name, menu_extra_item_quantity: $menu_extra_item_quantity, menu_extra_item_price: $menu_extra_item_price}';
}


MenuExtraItemPlace({this.menu_extra_item_name, this.menu_extra_item_quantity, this.menu_extra_item_price});

Map toJson() => {
  'menu_extra_item_name':menu_extra_item_name,
  'menu_extra_item_quantity':menu_extra_item_quantity,
  'menu_extra_item_price':menu_extra_item_price,
};

}










