import 'package:flutter/cupertino.dart';
import 'package:foodeze_flutter/modal/EventHistoryModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class EventHistoryController extends GetxController {
  var repo = ApiRepo();
  var noDataFound = false.obs;
  TextEditingController subjectController = TextEditingController();
  var loading = false.obs;

  var eventsList = EventHistoryModal().obs;

  void updateDataFound(bool value) {
    noDataFound.value = value;
  }

  Future<EventHistoryModal> fetchAllEvents(String userId) async {
    print('fetchAllEvents_called');
    var eventsResponse = await repo.fetchEventsHistoryRepo(userId);

    if (eventsResponse.status == "1")
      this.eventsList.value = eventsResponse;
    else
      noDataFound.value = true;

    return eventsResponse;
  }
}
