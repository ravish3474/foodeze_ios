import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../animations/ShowUp.dart';
import '../common/CommonWidgets.dart';
import '../common/Images.dart';
import '../common/Strings.dart';
import '../controller/MapController.dart';

class MapScreen extends StatefulWidget {
  double latitude;
  double longitude;

  MapScreen(this.latitude, this.longitude);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController controller = Get.put(MapController());

  late GoogleMapController mapController;
  Set<Circle> _circles = HashSet<Circle>();
  Set<Marker> markers = HashSet<Marker>();
  double zoomVal = 12.0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  late LatLng _center;

  late BuildContext globalContext;

  Completer<GoogleMapController> _controller = Completer();

  double heightOfModalBottomSheet=200;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _center = LatLng(widget.latitude, widget.longitude);

    getAddress(_center);

    print('MapCalled' +
        widget.latitude.toString() +
        "  " +
        widget.longitude.toString());

    if (widget.latitude != null) _setCircles(widget.latitude, widget.longitude);

    markers.add(Marker(
      markerId: MarkerId(_center.toString()),
      position: _center,
      infoWindow: InfoWindow(
        title: 'I am here',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ));
  }

  @override
  Widget build(BuildContext context) {
    this.globalContext = context;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: GetX<MapController>(builder: (controller) {
          return ShowUp(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: screenHeight(context) * .86,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          showTopWidget(" Address"),
                          Container(
                            height: screenHeight(context) * .5,
                            child: GoogleMap(
                              onTap: _handleTap,
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                  target:
                                      LatLng(widget.latitude, widget.longitude),
                                  zoom: zoomVal),
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              markers: markers,
                              circles: _circles,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                            ),
                          ),
                          showTappedAddress("Address"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ShowUp(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: 5.marginAll(),
                              child: CustomButton(context,
                                  height: 50,
                                  textStyle: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                  borderRadius: 35,
                                  text: Strings.showAddress, onTap: () async {
                                launchProgress(context: context);

                                var data = await controller.fetchAddressAPI();

                                print('fetchAddressAPI' +
                                    data!.status.toString() +
                                    " " +
                                    data.data!.length.toString());

                                disposeProgress();

                                if (data.status == "1")
                                  showFetchAdressBottomSheet();
                                else if (data.status == "400")
                                  Strings.went_wrong.toast();
                                else
                                  Strings.noAddress.toast();
                              }),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: 5.marginAll(),
                              child: CustomButton(context,
                                  height: 50,
                                  isBorder: true,
                                  borderColor: colorPrimary,
                                  textStyle: TextStyle(
                                      fontSize: 16, color: colorPrimary),
                                  borderRadius: 35,
                                  text: Strings.addAddress, onTap: () async {
                                    showAddAddressSheet();
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget showTopWidget(String from) {
    return Padding(
      padding: 16.paddingAll(),
      child: Row(
        children: [
          backButton().pressBack(),
          15.verticalSpace(),
          showText(
              color: Colors.black,
              text: from,
              textSize: 20,
              fontweight: FontWeight.w400,
              maxlines: 1)
        ],
      ),
    );
  }

  void _setCircles(double latitude, double longitude) {
    _circles.add(
      Circle(
          onTap: () {
            print("_setCircles");
          },
          circleId: CircleId("0"),
          center: LatLng(latitude, longitude),
          radius: 3000,
          strokeWidth: 1,
          fillColor: Color.fromRGBO(0, 196, 89, 0.4)),
    );
  }

  _handleTap(LatLng point) async {
    markers.clear();

    getAddress(point);

    print('ClickeLatLong' + point.toString());

    setState(() {
      markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am here',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      ));
    });
  }

  showTappedAddress(String title) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: 5.paddingAll(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showText(
                color: colorPrimary,
                text: controller.addressHeading.value,
                textSize: 18,
                fontweight: FontWeight.w600,
                maxlines: 1),
            10.horizontalSpace(),
            showText(
                color: Colors.black,
                text: controller.addressName.value,
                textSize: 16,
                fontweight: FontWeight.w400,
                maxlines: 3),
          ],
        ),
      ),
    );
  }


  showAddAddressSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
        topLeft: const Radius.circular(25.0),
    topRight: const Radius.circular(25.0),
    ),
    ),
    backgroundColor: Colors.white,
    context: context,
    builder: (context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 670,
        child: Column(
          children: <Widget>[
            5.horizontalSpace(),
            showTopWidget(Strings.addAddress),
            5.horizontalSpace(),
            bottomSheetForm(),
          ],
        ),
      ),
    )));

  }


  Widget bottomSheetForm(){

    return Expanded(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[


             /* Align(
                alignment: Alignment.center,
                child: showText(
                    color: colorPrimary,
                    text: Strings.addAddress,
                    textSize: 18,
                    fontweight: FontWeight.w600,
                    maxlines: 1),
              ),*/
              10.horizontalSpace(),
              showStreetTextWidget(),
              10.horizontalSpace(),
              showHouseNoTextWidget(),
              10.horizontalSpace(),
              showCityTextWidget(),
              10.horizontalSpace(),
              showStateTextWidget(),
              10.horizontalSpace(),
              showCountryTextWidget(),
              10.horizontalSpace(),
              showPincodeTextWidget(),
              10.horizontalSpace(),
              showCommentTextWidget(),
              40.horizontalSpace(),
              CustomButton(context,
                  height: 50,
                  textStyle: TextStyle(fontSize: 16, color: Colors.white),
                  borderRadius: 35,
                  text: Strings.save, onTap: () async {
                    if (validate()) {
                      hideKeyboard(context);
                      if (await checkInternet()) {
                        launchProgress(context: context);

                        var res = await controller.addAddressAPI();
                        print('resultkaif' + res.status.toString());
                        disposeProgress();
                        Get.back();

                        if (res.status == "1") {
                          successAlertSecond(
                              globalContext, Strings.success_address);
                        } else
                          Strings.went_wrong.toast();
                      } else
                        Strings.checkInternet.toast();
                    }
                  }),

            ],
          ),
        ],
      ),
    );
  }





  bool validate() {
    String street = controller.streetController.getValue();
    String house = controller.houseNoController.getValue();
    String city = controller.cityController.getValue();
    String state = controller.stateController.getValue();
    String country = controller.countryController.getValue();
    String pin = controller.pinCodeController.getValue();
    String comment = controller.commentController.getValue();

    /* if (street.isEmpty) {
      "Please enter street".toast();
      return false;
    } */ /*else if (house.isEmpty) {
      "Please enter house no/unit no.".toast();
      return false;
    }*/
    if (city.isEmpty) {
      "Please enter city".toast();
      return false;
    } else if (state.isEmpty) {
      "Please enter state".toast();
      return false;
    } else if (country.isEmpty) {
      "Please enter country".toast();
      return false;
    } else if (pin.isEmpty) {
      "Please enter zip code".toast();
      return false;
    }
    /*else if (comment.isEmpty) {
      "Please enter comment".toast();
      return false;
    }*/

    return true;
  }

  Widget showStreetTextWidget() {
    return inputTextFieldWidget(
        height: 60,
        controller: controller.streetController,
        title: Strings.street,
        icon: Icon(Icons.account_circle_outlined, color: colorPrimary),
        keyboardType: TextInputType.text,
        isEnable: true);
  }

  Widget showHouseNoTextWidget() {
    return inputTextFieldWidget(
        height: 60,
        controller: controller.houseNoController,
        title: Strings.houseNo,
        icon: Icon(Icons.account_circle_outlined, color: colorPrimary),
        keyboardType: TextInputType.text,
        isEnable: true);
  }

  Widget showCityTextWidget() {
    return inputTextFieldWidget(
        height: 60,
        controller: controller.cityController,
        title: Strings.city,
        icon: Icon(Icons.email_outlined, color: colorPrimary),
        keyboardType: TextInputType.text,
        isEnable: true);
  }

  Widget showStateTextWidget() {
    return inputTextFieldWidget(
        height: 60,
        controller: controller.stateController,
        title: Strings.state,
        icon: Icon(Icons.account_circle_outlined, color: colorPrimary),
        keyboardType: TextInputType.text,
        isEnable: true);
  }

  Widget showCountryTextWidget() {
    return inputTextFieldWidget(
        height: 60,
        controller: controller.countryController,
        title: Strings.country,
        icon: Icon(Icons.account_circle_outlined, color: colorPrimary),
        keyboardType: TextInputType.text,
        isEnable: true);
  }

  Widget showPincodeTextWidget() {
    return inputTextFieldWidget(
        height: 60,
        controller: controller.pinCodeController,
        title: Strings.zipCode,
        icon: Icon(Icons.email_outlined, color: colorPrimary),
        keyboardType: TextInputType.number,
        isEnable: true);
  }

  Widget showCommentTextWidget() {
    return inputTextFieldWidget(
        height: 60,
        controller: controller.commentController,
        title: Strings.comment2,
        icon: Icon(Icons.email_outlined, color: colorPrimary),
        keyboardType: TextInputType.multiline,
        isEnable: true);
  }

  void clearControllerValue() {
    controller.streetController.text = "";
    controller.houseNoController.text = "";
    controller.commentController.text = "";
  }

  Future<void> getAddress(LatLng point) async {
    final coordinates = new Coordinates(point.latitude, point.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first.subAdminArea == null ||
            addresses.first.subAdminArea.isEmpty
        ? addresses.first.adminArea
        : addresses.first.subAdminArea;

    var cityName =
        addresses.first.locality == null || addresses.first.locality.isEmpty
            ? ""
            : addresses.first.locality;

    var address = addresses.first.addressLine;

    if (controller.addressHeading.value.isEmpty)
      controller.addressHeading.value = Strings.address;

    controller.addressName.value = address;

    controller.cityController.text = cityName;
    controller.stateController.text = addresses.first.adminArea;
    controller.countryController.text = addresses.first.countryName;
    controller.pinCodeController.text = addresses.first.postalCode;
  }

   showFetchAdressBottomSheet() async {

   return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) =>  StatefulBuilder(
     builder: (BuildContext context, StateSetter setState){
              return GetX<MapController>(
              builder: (controller) {
              return SingleChildScrollView(
                  child: Container(
                margin: 10.marginTop(),
                padding: 20.paddingBootom(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [showList()],
                ),
              ));
            }
          );
        }
      ),
    );
  }

  Widget showList() {
    //vertical list
    return Padding(
      padding: 5.paddingAll(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showTopWidget(" Address"),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: controller.addressList.value.data!.length,
            itemBuilder: (_, i) {
              return Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  margin: 5.marginAll(),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.5, 0.5),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  padding: 10.paddingAll(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (await checkInternet()) {
                              launchProgress(context: context);
                              var res = await controller.deleteAddressAPI(i, controller.addressList.value.data![i].id!);
                              disposeProgress();

                              if (res.status == "1") {


                                controller.addressList.value.data!.removeAt(i);
                                controller.addressList.refresh();

                                if(controller.addressList.value.data!.length<=0)
                                  Get.back();


                                successAlertSecond(
                                    globalContext, Strings.success_address_delete);
                              } else
                                Strings.went_wrong.toast();
                            } else
                              Strings.checkInternet.toast();
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                                padding: 0.paddingAll(),
                                child: Image.asset(
                                  Images.delete_icon,
                                  height: 30,
                                  width: 30,
                                )

                            ),
                          ),
                        ),
                        showFetchedHouseNo(i),
                        10.horizontalSpace(),
                        showFetchedStreet(i),
                        10.horizontalSpace(),
                        showFetchedCity(i),
                        10.horizontalSpace(),
                        showFetchedState(i),
                        10.horizontalSpace(),
                        showFetchedCountry(i),
                        10.horizontalSpace(),
                        showFetchedPinCode(i),
                      ]),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 16,
              );
            },
          ),
        ],
      ),
    );
  }

  showFetchedHouseNo(int i) {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 1,
      text: TextSpan(
        text: "House no." + ":   ",
        style: TextStyle(color: colorPrimary, fontSize: 18),
        children: <TextSpan>[
          TextSpan(
              text: controller.addressList.value.data![i].apartment!.isEmpty?"NA":controller.addressList.value.data![i].apartment,
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  showFetchedStreet(int i) {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 1,
      text: TextSpan(
        text: "Street" + ":           ",
        style: TextStyle(color: colorPrimary, fontSize: 18),
        children: <TextSpan>[
          TextSpan(
      text:controller.addressList.value.data![i].street!.isEmpty?"NA":controller.addressList.value.data![i].street,
         
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
  showFetchedCity(int i) {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 1,
      text: TextSpan(
        text: Strings.city + ":               ",
        style: TextStyle(color: colorPrimary, fontSize: 18),
        children: <TextSpan>[
          TextSpan(
              text: controller.addressList.value.data![i].city!,
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  showFetchedState(int i) {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 1,
      text: TextSpan(
        text: Strings.state + ":            ",
        style: TextStyle(color: colorPrimary, fontSize: 18),
        children: <TextSpan>[
          TextSpan(
              text: controller.addressList.value.data![i].state!,
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  showFetchedCountry(int i) {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 1,
      text: TextSpan(
        text: Strings.country + ":        ",
        style: TextStyle(color: colorPrimary, fontSize: 18),
        children: <TextSpan>[
          TextSpan(
              text: controller.addressList.value.data![i].country!,
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  showFetchedPinCode(int i) {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 1,
      text: TextSpan(
        text: Strings.zipCode + ":       ",
        style: TextStyle(color: colorPrimary, fontSize: 18),
        children: <TextSpan>[
          TextSpan(
              text: controller.addressList.value.data![i].zip!,
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
