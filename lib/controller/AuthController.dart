import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/modal/ApiResponseNew.dart';
import 'package:foodeze_flutter/modal/LoginModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';



class AuthController extends GetxController {
  var code = 'VE'.obs;
  var cityName = 'Getting Location'.obs;
  var addressName = ''.obs;
  var dialCode = '+58'.obs;
  var currentPage = 0.obs;
  var isInternetRunning = true.obs;
  var  latitude="".obs;
  var  longitude="".obs;

  var repo = ApiRepo();

  TextEditingController phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();




  }

  updateInternetStatus(bool status) {
    this.isInternetRunning.value = status;
  }

  updateBottomPosition(int position) {
    this.currentPage.value = position;
  }
  updateCityAndAddressName(String cityName,String address) {
    this.cityName.value = cityName;
    this.addressName.value = address;
  }

  updateSlection({required String code, required String dialCode}) {
    this.dialCode.value = dialCode;
    this.code.value = code;
  }

  Future<LoginModal> mobilelogin(
      BuildContext context, {
        required String mobileNo,
      }) async {
    print('kaifmobile'+mobileNo);
    return await repo.mobilelogin(
        mobileNo: mobileNo);
  }


  Future<ApiResponseNew> updateDeviceTokenAPI({required String userId,
    required String deviceToken,
  }) async {
    print('deviceToken'+deviceToken);
    return await repo.updateDeviceTokenRepo(userId: userId, deviceToken: deviceToken);
  }


  //https://maps.google.com/maps/api/geocode/json?key=AIzaSyCW723GDrAHRywJl58xnQ33rUwq49hPYKo&language=en&latlng=30.2857297.78.0042402
  getAddressFromLatLng(context, double lat, double lng) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';

    var mapApiKey='';
    if(Platform.isAndroid)
      mapApiKey='AIzaSyCW723GDrAHRywJl58xnQ33rUwq49hPYKo';
    else
      mapApiKey='AIzaSyCutOXui1Cun6NUUjg0fPIHJ4UOZ4W3B_Y';

    final url = '$_host?key=$mapApiKey&language=en&latlng=$lat,$lng';
    if(lat != null && lng != null){
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print('bbbRes'+data.toString());
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else return null;
    } else return null;
  }





  Future<LocationData?> getLocation(BuildContext context) async {
    try {
      //launchProgress(context: context);
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 7));
      if (position != null) {
        final coordinates = new Coordinates(position.latitude, position.longitude);
        var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first.subAdminArea == null || addresses.first.subAdminArea.isEmpty ? addresses.first.adminArea : addresses.first.subAdminArea;


        var cityName= addresses.first.locality==null ||  addresses.first.locality.isEmpty? "City Error":  addresses.first.locality;

        // disposeProgress();
        return LocationData(
            latitude: position.latitude,
            address: addresses.first.addressLine,
            countryCode: addresses.first.countryCode,
            cityName: cityName,
            longitude: position.longitude,
            location: first);
      } else {
        // disposeProgress();
        print('firsterror');
        // "Unable to get current location".toast();
        return null;
      }
    } catch (e) {
      // disposeProgress();
      print('seconderror'+e.toString());

      "Unable to get current location".toast();
      return null;
    }
  }

  void updateCodeAndDialCode(String? countryCode, String? dial) {

    code.value=countryCode!;
    dialCode.value=dial!;
  }
}


class LocationData {
  double latitude;
  String location;
  String address;
  String cityName;
  String countryCode;
  double longitude;

  LocationData(
      {required this.cityName,required this.latitude, required this.address, required this.location, required this.longitude, required this.countryCode});
}







