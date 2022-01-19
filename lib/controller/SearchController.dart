import 'package:foodeze_flutter/modal/SearchModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var repo = ApiRepo();
  var noDataFound = false.obs;

  Rx<SearchModal> searchList = SearchModal().obs;

  void updateDataFound(bool value) {
    noDataFound.value = value;
  }

  void fetchSearchRestaurantAPi(
    String? keyword,
    String latitude,
    String longitude,
  ) async {
    print('fetchSearchRestaurantAPi_Called' + keyword!);
    var searchRes = await repo.fetchSearchRestaurantRepo(
        keyword: keyword, latitude: latitude, longitude: longitude);

    if (searchList.value.status == "1")
      updateDataFound(false);
    else
      updateDataFound(true);

    this.searchList.value = searchRes;

    if (searchList.value.status == "1")
      print('fetchRestaurantListBYCati_Data' +
          searchList.value.data!.length.toString());
  }
}
