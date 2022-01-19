import 'package:flutter/cupertino.dart';
import 'package:foodeze_flutter/modal/OrderHistoryModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  var repo = ApiRepo();
  var noDataFound = false.obs;
  TextEditingController subjectController = TextEditingController();
  var loading = false.obs;

  var orderList = OrderHistoryModal().obs;

  void updateDataFound(bool value) {
    noDataFound.value = value;
  }
  @override
  // TODO: implement onDelete
  get onDelete => super.onDelete;

  Future<OrderHistoryModal> fetchAllOrderApi(String userId) async {
    print('fetchAllEvents_called');
    var eventsResponse = await repo.fetchCustomerOrdersRepo(userId);

    if (eventsResponse.status == "1")
      this.orderList.value = eventsResponse;
    else
      noDataFound.value = true;




    return eventsResponse;
  }
}
