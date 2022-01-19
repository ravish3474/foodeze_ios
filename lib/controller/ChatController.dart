import 'package:flutter/material.dart';
import 'package:foodeze_flutter/modal/CustomerTicketsModal.dart';
import 'package:foodeze_flutter/modal/ViewTicketChatModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chatFeildController = TextEditingController();
  var noDataFound=false.obs;
  var chatList2 = ViewTicketChatModal().obs;
  //var chatList = ChatDatum().obs;
  var loading=false.obs;

  var chatList = <ChatDatum>[].obs;

  var addChat = ViewTicketChatModal().obs;
  var repo = ApiRepo();


  updateChatList({required String message,required String userID}) {
    print('lengthOfList'+(chatList.length-1).toString());

    chatList.add(ChatDatum(message: message,customerId: userID,fromCustomer: "1"));

    chatList.refresh();

   // for(int i=0;i<chatList.)

  }
  void updateDataFound(bool value)
  {

    noDataFound.value=value;
  }


  //fetch messaged
  Future fetchViewTicketChatAPI(String ticket_id
      ) async {
    print('fetchViewTicketChatAPI_called');
    var chatRes = await repo.fetchViewTicketChatRepo(ticket_id);


    if(chatRes.status=="1") {

      this.chatList.value = chatRes.data!;


    }
    else
      noDataFound.value=true;

return chatList;


  }


  //send messages
 void addChatToTicketAPI(String ticketId,String customerId,String message) async {
    print('addChatToTicketAPI_called');
    var addChatRes = await repo.addChatToTicketRepo(ticketId,customerId,message);


   // print('addChatRes'+addChatRes.status!);


   /*if(addChatRes.status=="1")
      this.chatList.value = addChatRes;
    else
      noDataFound.value=true;
*/
  }


}
