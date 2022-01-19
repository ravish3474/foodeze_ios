import 'package:flutter/cupertino.dart';
import 'package:foodeze_flutter/modal/CreateTicketModal.dart';
import 'package:foodeze_flutter/modal/CustomerTicketsModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class CustomerChatTicketController extends GetxController {
  var repo = ApiRepo();
  var noDataFound = false.obs;
  TextEditingController subjectController = TextEditingController();
  var loading = false.obs;

  var ticketsList = CustomerTicketsModal().obs;
  var createTicketRes = CreateTicketModal().obs;

  void updateDataFound(bool value) {
    noDataFound.value = value;
  }

  Future<CustomerTicketsModal> fetchCustomerChatTicketsAPI(
      String customerId) async {
    print('fetchCustomerChatTicketsAPI_called');
    var ticetksResponse = await repo.fetchCustomerChatTicketsRepo(customerId);

    if (ticetksResponse.status == "1")
      this.ticketsList.value = ticetksResponse;
    else
      noDataFound.value = true;

    //loading.value=false;

    return ticetksResponse;

    //print('statuskaif'+ticketsList.value.status!);
  }

  Future<CreateTicketModal> createTicketApi(
      String customerId, String subject) async {
    print('fetchCustomerChatTicketsAPI_called');
    var createTicketResponse = await repo.createTicketRepo(customerId, subject);

    if (createTicketResponse.status == "1")
      this.createTicketRes.value = createTicketResponse;
    else
      noDataFound.value = true;

    return createTicketResponse;
  }
}
