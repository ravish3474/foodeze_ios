import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/modal/ApiResponseNew.dart';
import 'package:foodeze_flutter/modal/CateringModal.dart';
import 'package:foodeze_flutter/modal/FetchCateringResModal.dart';
import 'package:foodeze_flutter/modal/UpdateModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CateringController extends GetxController {
  var repo = ApiRepo();
  var profileImage = ''.obs;
  var profileLoaded = false.obs;
  var isEnableHomeDel = true.obs;
  var isEnablePickup = false.obs;
  Rx<FetchCateringResModal> cateringResData = FetchCateringResModal().obs;

  TextEditingController selectMenuController = TextEditingController();
  TextEditingController cateringLocationController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController hourseController = TextEditingController();
  TextEditingController delPickController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  var selectedMenu = Strings.selectMenu.obs;
  var selectedHours = Strings.hours.obs;
  var isCartBoxFilled =false.obs;
  Rx<TextStyle> dropDownTextStyle = TextStyle(color: Colors.black54).obs;
  Rx<TextStyle> dropDownTextStyle2 = TextStyle(color: Colors.black54).obs;
  Rx<ApiResponseNew> sendCateringReqData = ApiResponseNew().obs;
  late Box<CateringModal> cartBox;
  RxList<CateringModal> cartList = <CateringModal>[].obs;


  List<CateringModal> fetchCateringData() {
    print('sallucalled');

    try {

      List<CateringModal> tempcartList = <CateringModal>[];

      cartBox = Hive.box<CateringModal>('catering');

      final Map<dynamic, CateringModal> deliveriesMap = cartBox.toMap();
      print('fetchCartData_Map' + deliveriesMap.toString());

      for (int i = 0; i < cartBox.length; i++) {
        CateringModal? item = cartBox.getAt(i);
        tempcartList.add(item!);
      }

      print('carData' + tempcartList.length.toString());

      cartList.clear();
      cartList.addAll(tempcartList);

      cartList.refresh();
    } catch (e) {
      print('CartFetchError' + e.toString());
    }

    return cartList;
  }

  int  deleteParticularItem( int index) {
    cartList.removeAt(index);
    cartList.refresh();


    if(cartBox.isEmpty)
      isCartBoxFilled.value=false;

    //delete particular item
    print('deletedRowId' + index.toString());
    final Map<dynamic, CateringModal> deliveriesMap = cartBox.toMap();
    print('deleteDateMap' + deliveriesMap.toString());

    dynamic desiredKey;

  /*  deliveriesMap.forEach((key, value) {
      if (value.rowId == rowId) desiredKey = key;
    });*/

    cartBox.deleteAt(index);

    return cartBox.length;

   // print('deletecalled' + desiredKey.toString());
  }


  Future<FetchCateringResModal> fetchCateringRestaurantAPI(
  ) async {
    var response= await repo.fetchCateringRestaurantRepo();

    cateringResData.value=response;

    return response;

  }

  Future<ApiResponseNew> sendCateringRequestAPI({
    required String eventDescription,
    required String timeDate,
    required String duration,
    required String restaurantId,
    required String eventLocation,
    required String eventCity,
    required String eventProvince,
    required String deliveryPickup,
    required String deliveryTime,
    required String comment,
    required String userId,
    required String androidVersion,
    required String eventTitle,
    required String tax,
    required String subtotal,
    required String jsonCheck
  }) async {
    print('eventDescription'+eventDescription);
    print('timeDate'+timeDate);
    print('duration'+duration);
    print('restaurantId'+restaurantId);
    print('eventLocation'+eventLocation);
    print('eventCity'+eventCity);
    print('eventProvince'+eventProvince);
    print('deliveryPickup'+deliveryPickup);
    print('deliveryTime'+deliveryTime);
    print('comment'+comment);
    print('userId'+userId);
    print('androidVersion'+androidVersion);
    print('eventTitle'+eventTitle);
    print('tax'+tax);
    print('subtotal'+subtotal);
    print('jsonCheck'+jsonCheck);

    var response= await repo.sendCateringRequestRepo(
      eventDescription: eventDescription,
      timeDate: timeDate,
      duration: duration,
      restaurantId: restaurantId,
      eventLocation: eventLocation,
      eventCity: eventCity,
      eventProvince: eventProvince,
      deliveryPickup: deliveryPickup,
      deliveryTime: deliveryTime,
      comment: comment,
      userId: userId,
      androidVersion: androidVersion,
      eventTitle: eventTitle,
      tax: tax,
      subtotal: subtotal,
      jsonCheck: jsonCheck,

    );
    sendCateringReqData.value=response;



    return response;

  }
}
