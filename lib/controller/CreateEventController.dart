import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/modal/UpdateModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class CreateEventController extends GetxController {
  var repo = ApiRepo();
  var profileImage = ''.obs;
  var profileLoaded = false.obs;

  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventDescController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventHoursController = TextEditingController();
  TextEditingController eventMenuController = TextEditingController();
  TextEditingController eventQuantityController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController eventCityController = TextEditingController();
  TextEditingController eventProvinceController = TextEditingController();
  var selectedKithcen = Strings.selectKitchen.obs;
  Rx<TextStyle> dropDownTextStyle = TextStyle(color: Colors.black54).obs;

  Future<UpdateModal> createEventAPI(
    String userId,
    String eventTitle,
    String eventDescription,
    String kitchenId,
    String eventDate,
    String eventHours,
    String eventMenu,
    String foodQuantity,
    String eventLocation,
    String eventCity,
    String eventProvince,
  ) async {
    return await repo.createEventRepo(
      userId: userId,
      eventTitle: eventTitle,
      eventDescription: eventDescription,
      kitchenId: kitchenId,
      eventDate: eventDate,
      eventHours: eventHours,
      eventMenu: eventMenu,
      foodQuantity: foodQuantity,
      eventLocation: eventLocation,
      eventCity: eventCity,
      eventProvince: eventProvince,
    );
  }
}
