
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:get/get.dart';

class AddToItemController extends GetxController {
  var liked = false.obs;
  var totalQty = 0.obs;
  var totalExtraItemQty = 0.obs;
  var totalCartItem = 0.obs;
  var totalPrice = 0.obs;
  var enableAddToItemButton=false.obs;
  var addToCartText=Strings.addToCart.obs;
  RxList<int> selectedItems = <int>[].obs;




}
