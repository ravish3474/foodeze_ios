import 'package:foodeze_flutter/modal/ApiResponseNew.dart';
import 'package:foodeze_flutter/modal/CardModal.dart';
import 'package:foodeze_flutter/modal/CateringFetchRequest.dart';
import 'package:foodeze_flutter/modal/NotificationModal.dart';
import 'package:foodeze_flutter/modal/ViewCateringDetails.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class FetchCateringController extends GetxController {
  var repo = ApiRepo();
  var noDataFound = false.obs;
  var loading = false.obs;
  late Box<CardModal> cartBox2;
  RxList<CardModal> cardList = <CardModal>[].obs;

  Rx<CateringFetchRequest> fetchCateringReqData = CateringFetchRequest().obs;
  Rx<ViewCateringDetails> viewCateringDetails = ViewCateringDetails().obs;

  void updateDataFound(bool value) {
    noDataFound.value = value;
  }

  Future<CateringFetchRequest> fetchCateringRequestAPI(String userId) async {
    print('fetchCateringRequestAPI_called');
    var dataRes = await repo.fetchCateringRequestRepo(userId: userId);

    if (dataRes.status == "1")
      this.fetchCateringReqData.value = dataRes;
    else
      noDataFound.value = true;


    return dataRes;
  }

  Future<ViewCateringDetails> fetchCateringDetailsAPI( String orderId, String restaurantId) async {
    print('fetchCateringDetailsAPI_called');
    var dataRes = await repo.fetchCateringDetailsRepo(orderId: orderId,restaurantId: restaurantId);

    if (dataRes.code == 200)
      this.viewCateringDetails.value = dataRes;
    else
      noDataFound.value = true;


    return dataRes;
  }




  Future<void> deleteCateringAPI(int i,String orderId) async {

   fetchCateringReqData.value.data!.removeAt(i);
   fetchCateringReqData.refresh();

   if (fetchCateringReqData.value.data!.length <= 0) {
     noDataFound.value = true;
     fetchCateringReqData.value.status = null;
     fetchCateringReqData.value.data!.clear();
     fetchCateringReqData.refresh();

   }
      print('deleteCateringAPI_called');
      var dataRes = await repo.deleteCateringReqRepo(orderId: orderId);



  }

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
}
