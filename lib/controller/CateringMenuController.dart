import 'package:foodeze_flutter/modal/FetchCateringMenuModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class CateringMenuController extends GetxController {
  var repo = ApiRepo();
  var loading = false.obs;
  var totalQty = 0.obs;

  Rx<FetchCateringMenuModal> cateringMenuResData = FetchCateringMenuModal().obs;
  var enableAddToItemButton = false.obs;
  RxList<int> selectedItems = <int>[].obs;

  Future<FetchCateringMenuModal> fetchCateringMenuAPI(
      String restaurantId, String currentTime) async {
    var response = await repo.fetchCateringMenuRepo(
        restaurantId: restaurantId, currentTime: currentTime);

    cateringMenuResData.value = response;

    print('menuRes' + cateringMenuResData.value.data!.length.toString());

    for (int i = 0; i < cateringMenuResData.value.data![0].cateringMenu!.length; i++) {
      cateringMenuResData.value.data![0].cateringMenu![i].index = "0";
    }

    cateringMenuResData.refresh();

    for (int i = 0;
        i < cateringMenuResData.value.data![0].cateringMenu!.length;
        i++)
      print('checkaif' +
          cateringMenuResData.value.data![0].cateringMenu![i].index!);

    return response;
  }
}
