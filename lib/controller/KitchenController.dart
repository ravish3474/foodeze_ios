import 'package:foodeze_flutter/modal/KitcheModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class KitchenController extends GetxController {
  var repo = ApiRepo();
  Rx<KitcheModal> kithcenData = KitcheModal().obs;
  var loading = false.obs;

  @override
  // TODO: implement onDelete
  get onDelete => super.onDelete;



  Future<KitcheModal> fetchKitchenApi(
    String userId,
    String latitude,
    String longitude,
  ) async {
    print('FetchKitchenAPi_called');
    var kitchenDataRes = await repo.kitcheRepo(
        userId: userId, latitude: latitude, longitude: longitude);

    this.kithcenData.value = kitchenDataRes;


    print('kitchenRes'+kitchenDataRes.toString());


    return kitchenDataRes;
  }



  Future<void> addFavandUnfavAPi(int index, String? restaurantId, String? userId,) async {


    if(index!=-1) {
      kithcenData.value.favouriteRestaurant![index].restaurantFavourite!.favourite = kithcenData.value.favouriteRestaurant![index].restaurantFavourite!.favourite == "1" ? "0" : "1";
      kithcenData.refresh();
    }

    var apiRes = await repo.addFavandUnfavRepo(restaurantId: restaurantId, userId: userId);
  }
}
