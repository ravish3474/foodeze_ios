import 'package:flutter/material.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/modal/AvailableLocModal.dart';
import 'package:foodeze_flutter/modal/CardModal.dart';
import 'package:foodeze_flutter/modal/CartModal.dart';
import 'package:foodeze_flutter/modal/CouponModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CartController extends GetxController {
  RxList<CartModal> cartList = <CartModal>[].obs;
  RxList<CardModal> cardList = <CardModal>[].obs;

  var riderTip = Strings.riderTip.obs;
  var enableApplyCouponButton = true.obs;
  var selectedAddress = Strings.selectAddress.obs;

  var subTotal = '0.0'.obs;
  var deliveryFee = '0.0'.obs;
  var vat = '0.0'.obs;
  var riderTipPrice = '0.0'.obs;
  var discount = '0.0'.obs;
  var grandTotal = '0.0'.obs;
  var repo = ApiRepo();

  Rx<TextStyle> dropDownTextStyle = TextStyle(color: Colors.black54).obs;
  TextEditingController coupanController = TextEditingController();
  TextEditingController instController = TextEditingController();
  Rx<CouponModal> couponRes = CouponModal().obs;

  var isEnableHomeDel = true.obs;
  var isEnablePickup = false.obs;

  late Box<CartModal> cartBox;
  late Box<CardModal> cartBox2;

  // var addressList = AvailableLocModal().obs;

  RxList<NonDelivarable> addressList = <NonDelivarable>[].obs;

  @override
  // TODO: implement onDelete
  get onDelete => super.onDelete;

  void setControllerDefaultValues() {
    riderTipPrice.value = '0.0';
    riderTip = Strings.riderTip.obs;
    isEnableHomeDel.value = true;
    isEnablePickup.value = false;
  }

  void deleteParticularItem(String rowId, int index) {
    cartList.removeAt(index);
    cartList.refresh();

    //delete particular item
    print('deletedRowId' + rowId);
    final Map<dynamic, CartModal> deliveriesMap = cartBox.toMap();
    print('deleteDateMap' + deliveriesMap.toString());

    dynamic desiredKey;

    deliveriesMap.forEach((key, value) {
      if (value.rowId == rowId) desiredKey = key;
    });

    cartBox.delete(desiredKey);

    print('deletecalled' + desiredKey.toString());
  }

  List<CartModal> fetchCartData() {
    print('sallucalled');

    try {
      setControllerDefaultValues();

      List<CartModal> tempcartList = <CartModal>[];

      cartBox = Hive.box<CartModal>('cart');
      print('cartBox'+cartBox.toString());

      final Map<dynamic, CartModal> deliveriesMap = cartBox.toMap();
      print('fetchCartData_Map' + deliveriesMap.toString());

      for (int i = 0; i < cartBox.length; i++) {
        CartModal? item = cartBox.getAt(i);
        tempcartList.add(item!);
      }

      print('carData' + tempcartList.length.toString());

      cartList.clear();
      cartList.value.addAll(tempcartList);

      // getGrandTotal()

      cartList.refresh();
    } catch (e) {
      print('CartFetchError' + e.toString());
    }

    return cartList.value;
  }

/*
  getGrandTotal() async {
    var subTotal = getSubTotal();
    print('kat_subTotal' + subTotal.toString());
    var deliveryFee = getDeliveryFee();
    print('kat_deliveryFee' + deliveryFee.toString());

    var vat = getVat();
    print('kat_vat' + vat.toString());

    var riderTip = getRiderTipPrice();
    print('kat_riderTip' + riderTip.toString());

    var discount = getDiscount();
    print('kat_discount' + discount.toString());

    var grandTotal = subTotal + deliveryFee + vat + riderTip + discount;
    print('kat_grandTotal' + grandTotal.toString());

    await Future.delayed(Duration(milliseconds: 1));


    controller.subTotal.value = (subTotal).toString();
    controller.deliveryFee.value = (deliveryFee).toString();
    controller.vat.value = (vat).toString();
    controller.riderTipPrice.value = (riderTip).toString();
    controller.discount.value = (discount).toString();
    controller.grandTotal.value = (subTotal + deliveryFee + vat + riderTip + discount).toString();

    // controller.update();

    print('subkasdjfsd' + controller.subTotal.value);
  }
*/

  void deleteParticularItemOfCard(String rowId, int index) {
    cardList.removeAt(index);
    cardList.refresh();

    //delete particular item
    print('deletedRowId' + rowId);
    final Map<dynamic, CardModal> deliveriesMap = cartBox2.toMap();
    print('deleteDateMap' + deliveriesMap.toString());

    dynamic desiredKey;

    deliveriesMap.forEach((key, value) {
      if (value.rowId == rowId) desiredKey = key;
    });

    cartBox2.delete(desiredKey);

    print('deletecalled' + desiredKey.toString());
  }

  List<CardModal> fetchCardDataOfCard() {
    print('sallucalled');

    try {
      List<CardModal> tempcartList = <CardModal>[];

      cartBox2 = Hive.box<CardModal>('card');

      final Map<dynamic, CardModal> deliveriesMap = cartBox2.toMap();
      print('fetchCartData_Map' + deliveriesMap.toString());

      for (int i = 0; i < cartBox2.length; i++) {
        CardModal? item = cartBox2.getAt(i);
        tempcartList.add(item!);
      }

      print('cardData' + tempcartList.length.toString());

      cardList.clear();
      cardList.addAll(tempcartList);
      cardList.refresh();

      print('sallucheckCard' + cardList.length.toString());
    } catch (e) {
      print('CardFetchError' + e.toString());
    }

    return cardList.value;
  }

  void updateBottomPriceValues(String subtotal, String delFee, String vatValue,
      String riderTip, String discountVal, String grandTotalValue) {
    subTotal.value = subtotal;
    deliveryFee.value = delFee;
    vat.value = vatValue;
    riderTipPrice.value = riderTip;
    discount.value = discountVal;
    grandTotal.value = grandTotalValue;

    //update();

    refresh();
  }

  Future<CouponModal> getCouponApi(String couponCode) async {
    var response = await repo.getCouponRepo(
      couponCode: couponCode,
    );

    couponRes.value = response;

    return response;
  }

  Future<AvailableLocModal?> fetchAvailableLocationAPI(
    String lat,
    String long,
  ) async {
    var data = await repo.fetchAvailableLocationRepo(
        userId: await getUserId(), lat: lat, long: long);

    print('katrinalatlong'+lat+"   "+long);

    print('DelAddr' + data.data!.deliverable!.length.toString());
    print('NonDelAddr' + data.data!.nonDelivarable!.length.toString());

    RxList<NonDelivarable> tempList = <NonDelivarable>[].obs;



    for (int i = 0; i < data.data!.deliverable!.length; i++) {
      var modal = data.data!.deliverable![i];
      modal.available = "1";
      tempList.add(modal);
    }

    for (int i = 0; i < data.data!.nonDelivarable!.length; i++) {
      var modal = data.data!.nonDelivarable![i];
      modal.available = "0";
      tempList.add(modal);
    }

    print('tempSie'+tempList.length.toString());
    print('tempSie'+tempList.toString());


    for (int i = 0; i < tempList.length; i++) {
      print('Available'+tempList[i].available!);
    }


    addressList.value.clear();

      addressList.value =tempList;

    print('addRessList'+addressList.toString());

    return data;
  }
}
