import 'package:foodeze_flutter/modal/OrderStatusiModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class OrderStatusController extends GetxController {
  var noDataFound = false.obs;
  var loading = false.obs;

  var orderStatusData = OrderStatusiModal().obs;
  var repo = ApiRepo();

  void updateDataFound(bool value) {
    noDataFound.value = value;
  }






  //fetch messaged
  Future<OrderStatusiModal> fetchOrderStatusAPI(String orderId, String customerId) async {
    print('fetchOrderStatusAPI_called');
    var orderRes = await repo.fetchOrderStatusRepo(orderId, customerId);


    //if (orderRes.status == "1")
      this.orderStatusData.value = orderRes;
    //else
     // noDataFound.value = true;

    return orderRes;
  }
}
