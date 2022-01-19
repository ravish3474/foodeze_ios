import 'package:foodeze_flutter/modal/NotificationModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var repo = ApiRepo();
  var noDataFound = false.obs;
  var loading = false.obs;

  Rx<NotificationModal> notificatinList = NotificationModal().obs;

  void updateDataFound(bool value) {
    noDataFound.value = value;
  }

  Future<NotificationModal> fetchNotificationAPI() async {
    print('fetchNotificationAPI_called');
    var notificationResponse = await repo.fetchNotificationsRepo();

    if (notificationResponse.status == "1")
      this.notificatinList.value = notificationResponse;
    else
      noDataFound.value = true;

    //print('NotificationStatus' + notificatinList.value.status!);

    return notificationResponse;
  }
}
