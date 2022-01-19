import 'package:flutter/cupertino.dart';
import 'package:foodeze_flutter/modal/EventModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  var repo = ApiRepo();
  var noDataFound = false.obs;
  TextEditingController subjectController = TextEditingController();
  var loading = false.obs;

  var eventsList = EventModal().obs;
  @override
  // TODO: implement onDelete
  get onDelete => super.onDelete;

  void updateDataFound(bool value) {
    noDataFound.value = value;
  }

  Future<EventModal> fetchAllEvents() async {
    print('fetchAllEvents_called');
    var eventsResponse = await repo.fetchAllEventsRepo();

    if (eventsResponse.status == "1")
      this.eventsList.value = eventsResponse;
    else
      noDataFound.value = true;
   



 /*  var modal=EventDatum(
     city: "city",
     desert: "desert",
     drinks: "drinks",
     event_banner: "https://i.picsum.photos/id/193/536/354.jpg?hmac=IpCKIpR6LJnZ5gmC0IsCYss0TXvP1nQd1MSKzYkwkYI",
     event_date: "event_date",
     event_description: "event_description",
     event_starter: "event_starter",
     event_time: "event_time",
     event_title: "event_title",
     id: "1",
     location: "location",
     main_course: "main_course",
     price: "100",
     quantity: "1",
     restaurent_id: "52",
     tax: "10",
     transaction_id: "2",
     province: "province",

   );

   List<EventDatum>list=[modal,modal,modal,modal,modal,modal,modal,modal];


   EventModal s=EventModal(status: "1",data: list);*/

  //   eventsList.value=s;

    return eventsResponse;
  }
}
