import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/base/network/ApiHitter.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/modal/FetchAddressModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class MapController extends GetxController {
  var addressHeading = ''.obs;
  var addressName = ''.obs;
  var cityName = ''.obs;
  var repo = ApiRepo();
  var heightOfModalBottomSheet=200.0.obs;

  TextEditingController streetController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  var noDataFound = false.obs;

  var addressList = FetchAddressModal().obs;

  Future<ApiResponse> addAddressAPI() async {
    return await repo.addAddressRepo(
        userId: await getUserId(),
        street: streetController.value.text,
        apartment: houseNoController.value.text,
        city: cityController.value.text,
        state: stateController.value.text,
        country: countryController.value.text,
        zipcode: pinCodeController.value.text,
        instructions: commentController.value.text);
  }

  Future<FetchAddressModal?> fetchAddressAPI() async {
    var data = await repo.fetchAddressRepo(userId: await getUserId());
    addressList.value = data;
    return data;
  }

  Future<ApiResponse> deleteAddressAPI(int index,String addressId) async {

    var res = await repo.deleteAddressRepo(addressId: addressId);

   // print('BeforeSize'+addressList.value.data!.length.toString());

    /*if (res.status == "1")
      {
        addressList.value.data!.removeAt(index);
        addressList.refresh();
      }
    print('AdtereSize'+addressList.value.data!.length.toString());*/


    return  repo.deleteAddressRepo(addressId: addressId);
  }
}
