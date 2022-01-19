import 'package:flutter/material.dart';
import 'package:foodeze_flutter/modal/FetchOrderChatModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderChatController extends GetxController {
  var chatFeildController = TextEditingController();
  var noDataFound = false.obs;
  var loading = false.obs;

  var chatList = <ChatDatum>[].obs;

  var addChat = FetchOrderChatModal().obs;
  var repo = ApiRepo();

  updateChatList({required String message, required String userID}) {
    print('lengthOfList' + (chatList.length - 1).toString());

    DateTime now = DateTime.now();
    String currentDataTime = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);
    print('formattedDate'+currentDataTime);


    chatList.add(ChatDatum(message: message, customerId: userID,fromCustomer: "0",chatTime: currentDataTime));

    chatList.refresh();

  }

  void updateDataFound(bool value) {
    noDataFound.value = value;
  }

  //fetch messaged
  Future fetchOrderChatAPI(String orderId) async {
    print('fetchOrderChatAPI_called');
    var chatRes = await repo.fetchOrderChatRepo(orderId);

    if (chatRes.status == "1") {
     // this.chatList.value = chatRes.data!;

      var a=chatRes.data!.reversed.toList();
      this.chatList.value =a;


    } else
      noDataFound.value = true;

    return chatList;
  }

  //send messages
  void sendCustomerToRiderChatAPI({
   required String customerId,
    required String riderId,
    required String orderId,
    required  String fromCustomer,
    required  String message,
  } ) async {
    print('sendCustomerToRiderChatAPI_called');


    print('customerId'+customerId);
    print('riderId'+riderId);
    print('orderId'+orderId);
    print('fromCustomer'+fromCustomer);
    print('message'+message);

    var addChatRes = await repo.sendCustomerToRiderChatRepo(
        customerId, riderId, orderId, fromCustomer, message);

    // print('addChatRes'+addChatRes.status!);

    /*if(addChatRes.status=="1")
      this.chatList.value = addChatRes;
    else
      noDataFound.value=true;
*/
  }
}
