import 'package:foodeze_flutter/modal/RestrauListByCatModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class ShowRestrauByListController extends GetxController {
  var repo = ApiRepo();
  var noDataFound = false.obs;
  var loading = false.obs;

  Rx<RestrauListByCatModal> restauListByCat = RestrauListByCatModal().obs;

  void updateDataFound(bool value) {
    noDataFound.value = value;
  }

  Future<RestrauListByCatModal> fetchRestaurantListBYCat(
    String? category,
    String latitude,
    String longitude,
  ) async {
    print('fetchRestaurantListBYCati_called');
    var restaurentListByCatRes = await repo.fetchRestaurantListByCatRepo(
        category: category, latitude: latitude, longitude: longitude);

    this.restauListByCat.value = restaurentListByCatRes;

    if (restauListByCat.value.status == "1")
      print('fetchRestaurantListBYCati_Data' +
          restauListByCat.value.data!.length.toString());

    return restaurentListByCatRes;
  }
}
