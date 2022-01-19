import 'package:foodeze_flutter/modal/VirtualKitchenModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class VIrtualKitchController extends GetxController {
  var repo = ApiRepo();
  var noDataFound = false.obs;
  var loading = false.obs;
  var liked = false.obs;

  Rx<VirtualKitchenModal> virtualKitchendata = VirtualKitchenModal().obs;

  void updateDataFound(bool value) {
    noDataFound.value = value;
  }

  Future<VirtualKitchenModal> fetchVirtualKitchenApi(
    String? restaurantId,
    String currentTime,
  ) async {
    print('fetchVirtualKitchenApi_called');
    var virtualKitchenRes = await repo.fetchVirtualKitchenRepo(
        restaurant_id: restaurantId, current_time: currentTime);

    if (virtualKitchenRes.data != null) {
      //if ( virtualKitchenRes.data![0].restaurantMenu!.isNotEmpty) {
      print('success');
      //data is available

      this.virtualKitchendata.value = virtualKitchenRes;



      updateDataFound(false);
      /*} else {
        print('failed');
        updateDataFound(true);
      }*/

    } else
      updateDataFound(true);

    if (virtualKitchendata.value.data != null)
      print('virtualKitchenData' +
          virtualKitchendata.value.data!.length.toString());

    return virtualKitchenRes;
  }
}
