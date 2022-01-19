import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:foodeze_flutter/modal/CardModal.dart';

import 'package:foodeze_flutter/modal/LoginModal.dart';
import 'package:foodeze_flutter/modal/RestrauListByCatModal.dart';
import 'package:foodeze_flutter/modal/UpdateModal.dart';
import 'package:foodeze_flutter/modal/UpdateProfileModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CardController extends GetxController {

  var cardNumber = ''.obs;
  var expiryDate = ''.obs;
  var cardHolderName = ''.obs;
  var cvvCode = ''.obs;
  var isCvvFocused = false.obs;
  RxList<CardModal> cardList=<CardModal>[].obs;
  late  Box<CardModal> cartBox;


  void deleteParticularItemOfCard(String rowId, int index) {

    cardList.removeAt(index);
    cardList.refresh();


  //  if (cartList.isEmpty)
   //   noDataFound.value = true;

    //delete particular item
    print('deletedRowId' + rowId);
    final Map<dynamic, CardModal> deliveriesMap = cartBox.toMap();
    print('deleteDateMap' + deliveriesMap.toString());

    dynamic desiredKey;

    deliveriesMap.forEach((key, value) {
      if (value.rowId == rowId) desiredKey = key;
    });

    cartBox.delete(desiredKey);

    print('deletecalled' + desiredKey.toString());






  }

  List<CardModal> fetchCardDataOfCard()  {
    print('sallucalled');

    try {


      List<CardModal> tempcartList=<CardModal>[];

      cartBox = Hive.box<CardModal>('card');

      final Map<dynamic, CardModal> deliveriesMap = cartBox.toMap();
      print('fetchCartData_Map' + deliveriesMap.toString());





      for (int i = 0; i < cartBox.length; i++) {
        CardModal? item = cartBox.getAt(i);
        tempcartList.add(item!);
      }

      print('carData' + tempcartList.length.toString());




      cardList.clear();
      cardList.value.addAll(tempcartList);
      cardList.refresh();





      print('sallucheck'+cardList.length.toString());

     /* if (cartList.isEmpty)
      {
        print('EmptryRun');
        noDataFound.value = true;
      }*/






    }
    catch(e)
    {
      print('CartFetchError'+e.toString());

    }

    return cardList.value;



  }





}
