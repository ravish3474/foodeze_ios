import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/CateringController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/CateringExtraMenuItemModal.dart';
import 'package:foodeze_flutter/modal/CateringModal.dart';
import 'package:foodeze_flutter/modal/CateringSendModal.dart';
import 'package:foodeze_flutter/screen/HomePage.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'CateringMenuScreen.dart';

class AddCateringRequest extends StatefulWidget {
  @override
  _AddCateringRequestState createState() => _AddCateringRequestState();
}

class _AddCateringRequestState extends State<AddCateringRequest> {
  CateringController controller = Get.put(CateringController());
  var restaurantId = "";
  var restaurantName = "";
  var restaurantMinorder = "";
  var restaurantTax = "";
  late Box<CateringModal> cartBox = Hive.box<CateringModal>('catering');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartBox.clear();

    controller.fetchCateringRestaurantAPI();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pressBack(result:controller.sendCateringReqData.value.status);
        //Get.back(result: "Kaif");
        return true;
      },
      child: SafeArea(child: Scaffold(
        body: SingleChildScrollView(
          child: GetX<CateringController>(builder: (controller) {
            return Container(
              color: Colors.white,
              padding: 16.paddingAll(),
              width: screenWidth(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showTopWidget(Strings.cateringReq),
                  13.horizontalSpace(),
                  ShowUp(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.horizontalSpace(),
                        showMenuDropdown(),
                        10.horizontalSpace(),
                        showCateringMenuAndView(),
                        10.horizontalSpace(),
                        showCateringLocation(),
                        10.horizontalSpace(),
                        showCateringCityProvince(),
                        10.horizontalSpace(),
                        showCateringTitle(),
                        10.horizontalSpace(),
                        showCateringDescription(),
                        10.horizontalSpace(),
                        dateTimeHourseWidget(),
                        10.horizontalSpace(),
                        showDeliveryPickupButton(),
                        10.horizontalSpace(),
                        showDeliveryPickupTime(),
                        10.horizontalSpace(),
                        showComment(),
                        20.horizontalSpace(),
                      ],
                    ),
                  ),
                  ShowUp(
                    child: Container(
                      margin: 5.marginAll(),
                      child: CustomButton(context,
                          height: 55,
                          borderRadius: 35,
                          text: Strings.submit, onTap: () async {
                        if (validate()) {
                          print('submittt');
                          if (await checkInternet()) {
                            hideKeyboard(context);
                            launchProgress(context: context);

                            var sendCatModal = getCateringData();

                            var res = await controller.sendCateringRequestAPI(
                                eventDescription:
                                    controller.descriptionController.getValue(),
                                timeDate: controller.timeController.getValue(),
                                duration:
                                    controller.hourseController.getValue(),
                                restaurantId: restaurantId,
                                eventLocation: controller
                                    .cateringLocationController
                                    .getValue(),
                                eventCity: controller.cityController.getValue(),
                                eventProvince:
                                    controller.provinceController.getValue(),
                                deliveryPickup: controller.isEnableHomeDel.value
                                    ? "1"
                                    : "0",
                                deliveryTime:
                                    controller.delPickController.getValue(),
                                comment:
                                    controller.commentController.getValue(),
                                userId: await getUserId(),
                                androidVersion: await getAppVersion(),
                                eventTitle:
                                    controller.titleController.getValue(),
                                tax: restaurantTax,
                                subtotal: getSubtotal(),
                                jsonCheck: sendCatModal);

                            disposeProgress();

                            if (res.status == "1")
                              successAlert(context);
                            else
                              Strings.went_wrong.toast();
                          } else
                            Strings.checkInternet.toast();
                        }
                      }),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      )),
    );
  }

  Widget showMenuDropdown() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black54,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          iconEnabledColor: colorPrimary,
          isExpanded: true,
          hint: Text(
            Strings.selectMenu,
          ),
          // Not necessary for Option 1
          value: controller.selectedMenu.value,
          onChanged: (newValue) {
            controller.selectedMenu.value = newValue as String;
            if (newValue == Strings.selectMenu) {
              controller.dropDownTextStyle.value =
                  TextStyle(color: Colors.black54);

              restaurantId = "";
              restaurantName = "";
              restaurantMinorder = "";
              restaurantTax = "";
            } else {
              controller.dropDownTextStyle.value =
                  TextStyle(color: Colors.black);

              for (var f in controller.cateringResData.value.data!
                  .where((item) => item.name == newValue)) {
                restaurantId = f.id!;
                restaurantName = f.name!;
                restaurantMinorder = f.minOrderPrice!;
                restaurantTax = f.tax!;
                break;
              }

              print('restaurantId' + restaurantId);
              print('restaurantName' + restaurantName);
              print('restaurantMinorder' + restaurantMinorder);
              print('restaurantTax' + restaurantTax);
            }

            hideKeyboard(context);
          },
          items: getRestaurantList().map((location) {
            return DropdownMenuItem(
              child:
                  new Text(location, style: controller.dropDownTextStyle.value),
              value: location,
            );
          }).toList(),
        ),
      ),
    );
  }

  List getRestaurantList() {
    var restaurantList = [];

    if (controller.cateringResData.value.data != null) {
      restaurantList.add(Strings.selectMenu);

      for (int i = 0; i < controller.cateringResData.value.data!.length; i++)
        restaurantList.add(controller.cateringResData.value.data![i].name);
    }

    return restaurantList;
  }

  List getHourseList() {
    var hourseList = [
      Strings.hours,
      "1 hours",
      "2 hours",
      "3 hours",
      "4 hours",
      "5 hours",
      "6 hours",
      "7 hours",
      "8 hours",
      "9 hours",
      "10 hours",
      "11 hours",
      "12 hours",
    ];

    return hourseList;
  }

  Widget showCateringLocation() {
    return inputTextFieldWidget(
      controller: controller.cateringLocationController,
      title: Strings.cateringLocation,
      icon: Icon(Icons.location_pin, color: colorPrimary),
      keyboardType: TextInputType.name,
      isEnable: true,
    );
  }

  Widget showCateringTitle() {
    return inputTextFieldWidget(
      controller: controller.titleController,
      title: Strings.cateringTitle,
      icon: Icon(Icons.title, color: colorPrimary),
      keyboardType: TextInputType.name,
      isEnable: true,
    );
  }

  Widget showCateringDescription() {
    return inputTextFieldWidget(
      controller: controller.descriptionController,
      title: Strings.cateringDesc,
      icon: Icon(Icons.description_outlined, color: colorPrimary),
      keyboardType: TextInputType.multiline,
      isEnable: true,
    );
  }

  Widget dateTimeHourseWidget() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => selectDate(),
            child: Container(
              margin: 5.marginRight(),
              child: inputTextFieldWidget(
                  controller: controller.dateController,
                  title: Strings.date,
                  icon: Icon(Icons.date_range, color: colorPrimary),
                  keyboardType: TextInputType.name,
                  isEnable: false),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => selectTime("first"),
            child: Container(
              margin: 5.marginRight(),
              child: inputTextFieldWidget(
                  controller: controller.timeController,
                  title: Strings.time,
                  icon: Icon(Icons.timer, color: colorPrimary),
                  keyboardType: TextInputType.name,
                  isEnable: false),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: showHoursDropdown(),
        ),
      ],
    );
  }

  Widget showHoursDropdown() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black54,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          iconEnabledColor: Colors.white,
          isExpanded: true,
          hint: Text(
            Strings.hours,
          ),
          // Not necessary for Option 1
          value: controller.selectedHours.value,
          onChanged: (newValue) {
            controller.selectedHours.value = newValue as String;
            if (newValue == Strings.hours)
              controller.dropDownTextStyle2.value =
                  TextStyle(color: Colors.black54);
            else {
              controller.dropDownTextStyle2.value =
                  TextStyle(color: Colors.black);
              controller.hourseController.text = newValue;
            }
            hideKeyboard(context);
          },
          items: getHourseList().map((location) {
            return DropdownMenuItem(
              child: new Text(location,
                  style: controller.dropDownTextStyle2.value),
              value: location,
            );
          }).toList(),
        ),
      ),
    );
  }

  Row showTopWidget(String title) {
    return Row(
      children: [
        backButton().pressBack(result:controller.sendCateringReqData.value.status),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: title,
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }

  successAlert(context) {
    CustomDialog(context,
        widget: Container(
          padding: 20.paddingAll(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Strings.appName,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 30.0,
                      color: Colors.black.withOpacity(0.47))),
              16.horizontalSpace(),
              Image.asset(
                Images.done,
                width: screenWidth(context),
                height: 150,
              ),
              30.horizontalSpace(),
              Text(
                Strings.success_catering,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.withOpacity(0.47)),
                textAlign: TextAlign.center,
              ),
              30.horizontalSpace(),
              CustomButton(context, height: 50, text: 'Ok', onTap: () {
                print('okClicked');

                // Get.reset();
               // HomePage("").navigate(isInfinity: true);

               // pressBack(result:controller.sendCateringReqData.value.status);

                Get.back();

                Get.back(result:controller.sendCateringReqData.value.status);



              }, width: screenWidth(context) / 2.8)
            ],
          ),
        ));
  }

  void selectDate() {
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true,
        minTime: DateTime(2021, 1, 1),
        maxTime: DateTime(2050, 12, 31), onConfirm: (date) {
      print('confirm $date');
      var _date = '${date.day}-${date.month}-${date.year}';
      print('kaifdate' + _date);

      controller.dateController.text = _date;
      hideKeyboard(context);
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  void selectTime(String from) {
    DatePicker.showTimePicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true, onConfirm: (time) {
      print('confirm $time');
      var _time = '${time.hour}:${time.minute}:${time.second}';

      if (from == "first")
        controller.timeController.text = _time;
      else
        controller.delPickController.text = _time;
      hideKeyboard(context);
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  showCateringMenuAndView() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () async {
              if (restaurantId.toString().isEmpty) {
                "Please select menu".toast();
                return;
              }

              String result = await CateringMenuScreen(restaurantId,
                      restaurantName, restaurantTax, restaurantMinorder)
                  .navigate(isAwait: true);

              print('backResult' + result);
              if (int.parse(result) > 0)
                controller.isCartBoxFilled.value = true;
            },
            child: Container(
              margin: 5.marginRight(),
              child: inputTextFieldWidget(
                  controller: controller.commentController,
                  title: Strings.cateringMenu,
                  icon: Icon(Icons.fastfood_outlined, color: colorPrimary),
                  keyboardType: TextInputType.name,
                  isEnable: false),
            ),
          ),
        ),
        getViewButton(),
      ],
    );
  }

  showCateringCityProvince() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: 5.marginRight(),
            child: inputTextFieldWidget(
                controller: controller.cityController,
                title: Strings.cateringCity,
                icon: Icon(Icons.location_city_sharp, color: colorPrimary),
                keyboardType: TextInputType.name,
                isEnable: true),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: 5.marginRight(),
            child: inputTextFieldWidget(
                controller: controller.provinceController,
                title: Strings.cateringProvince,
                icon: Icon(Icons.food_bank, color: colorPrimary),
                keyboardType: TextInputType.name,
                isEnable: true),
          ),
        ),
      ],
    );
  }

  showDeliveryPickupButton() {
    print('isEnablDel' + controller.isEnableHomeDel.value.toString());
    print('isEnablPick' + controller.isEnablePickup.value.toString());

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: 3.marginAll(),
            child: CustomButton(context,
                height: 45,
                isBorder: controller.isEnableHomeDel.value ? false : true,
                borderColor: controller.isEnableHomeDel.value
                    ? Colors.white
                    : colorPrimary,
                textStyle: TextStyle(
                    fontSize: 16,
                    color: controller.isEnableHomeDel.value
                        ? colorWhite
                        : colorPrimary),
                borderRadius: 35,
                text: Strings.delivery, onTap: () async {
              controller.isEnableHomeDel.value = true;
              controller.isEnablePickup.value = false;

              print('delClicked' + controller.isEnableHomeDel.value.toString());
            }),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: 3.marginAll(),
            child: CustomButton(context,
                height: 45,
                isBorder: controller.isEnablePickup.value ? false : true,
                borderColor: controller.isEnablePickup.value
                    ? Colors.white
                    : colorPrimary,
                textStyle: TextStyle(
                    fontSize: 16,
                    color: controller.isEnablePickup.value
                        ? Colors.white
                        : colorPrimary),
                borderRadius: 35,
                text: Strings.pickup, onTap: () async {
              controller.isEnableHomeDel.value = false;
              controller.isEnablePickup.value = true;

              print('picclicked' + controller.isEnablePickup.value.toString());
            }),
          ),
        ),
      ],
    );
  }

  showDeliveryPickupTime() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => selectTime("second"),
            child: Container(
              margin: 5.marginRight(),
              child: inputTextFieldWidget(
                  controller: controller.delPickController,
                  title: Strings.delPickTime,
                  icon: Icon(Icons.timer, color: colorPrimary),
                  keyboardType: TextInputType.name,
                  isEnable: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget showComment() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff707070)),
          borderRadius: BorderRadius.circular(12)),
      child: TextField(
        controller: controller.commentController,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: Strings.comments,
          labelStyle: TextStyle(color: Colors.black54),
          hintText: Strings.comment,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  bool validate() {
    String location = controller.cateringLocationController.getValue();
    String city = controller.cityController.getValue();
    String province = controller.provinceController.getValue();
    String title = controller.titleController.getValue();
    String description = controller.descriptionController.getValue();
    String date = controller.dateController.getValue();
    String time = controller.timeController.getValue();
    String hours = controller.hourseController.getValue();
    String delPickTime = controller.delPickController.getValue();
    String comments = controller.commentController.getValue();

    if (controller.selectedMenu.value == Strings.selectMenu) {
      Strings.pleaseSelectMenu.toast();
      return false;
    } else if (cartBox.length <= 0) {
      Strings.pleaseSelectCateringItem.toast();
      return false;
    } else if (location.isEmpty) {
      Strings.pleaseSelectLocation.toast();
      return false;
    } else if (city.isEmpty) {
      Strings.pleaseSelectCity.toast();
      return false;
    } else if (province.isEmpty) {
      Strings.pleaseSelectProvince.toast();
      return false;
    } else if (title.isEmpty) {
      Strings.pleaseSelectTitle.toast();
      return false;
    } else if (description.isEmpty) {
      Strings.pleaseSelectDescription.toast();
      return false;
    } else if (date.isEmpty) {
      Strings.pleaseSelectDate.toast();
      return false;
    } else if (time.isEmpty) {
      Strings.pleaseSelectTime.toast();
      return false;
    } else if (controller.selectedHours.value == Strings.hours) {
      Strings.pleaseSelectHours.toast();
      return false;
    } else if (delPickTime.isEmpty) {
      Strings.pleaseSelectDelPickTime.toast();
      return false;
    }
    return true;
  }

  getCateringData() {
    List<MenuItem> menuItemList222 = [];
    List<CateringSendModal> sendList = [];
    List<String> jsonList = [];
    for (int i = 0; i < cartBox.length; i++) {
      CateringSendModal modal = CateringSendModal();
      List<MenuExtraItem> menuList = [];
      print('extrLength' + cartBox.getAt(i)!.extraItemList!.length.toString());

      for (int j = 0; j < cartBox.getAt(i)!.extraItemList!.length; j++) {
        MenuExtraItem menuExtraItem = MenuExtraItem(
            menuExtraItemName:
                cartBox.getAt(i)!.extraItemList![j].menuExtraItemName,
            menuExtraItemPrice:
                cartBox.getAt(i)!.extraItemList![j].menuExtraItemPrice,
            menuExtraItemQuantity:
                cartBox.getAt(i)!.extraItemList![j].menuExtraItemQuantity);
        menuList.add(menuExtraItem);
      }

      MenuItem item = MenuItem(
          menuItemName: cartBox.getAt(i)!.name,
          menuItemQuantity: cartBox.getAt(i)!.quantity,
          menuItemPrice: cartBox.getAt(i)!.price,
          menuExtraItem: menuList);

      List<MenuItem> menuItemList = [];
      menuItemList.add(item);

      menuItemList222.add(item);

      modal.menuItem = menuItemList;

      sendList.add(modal);

      String itemFIrst = jsonEncode(sendList[i]);
      String menuItemListRes = jsonEncode(menuItemList);
      itemFIrst = itemFIrst.substring(1, itemFIrst.length - 1);
      printWrapped('itemFIrst' + itemFIrst);

      jsonList.add(itemFIrst);
    }

    String menuItemList222333 = jsonEncode(menuItemList222);
    menuItemList222333 = "{  \"menu_item\":" + menuItemList222333 + "}";

    printWrapped('menuItemListRes' + menuItemList222333);

    /*   String result = jsonEncode(sendList);
    // result.d

    printWrapped('resultBefore' + result);


    result = result.substring(1, result.length - 1);

    print('resultList' + result);

    var jsonListString=jsonList.toString();

    jsonListString = "{"+jsonListString.substring(1, jsonListString.length - 1)+"}";

    print('jsonListString' + jsonListString);
*/

    return menuItemList222333;
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  getSubtotal() {
    print('subTotalCalled'+cartBox.length.toString());

    final Map<dynamic, CateringModal> deliveriesMap = cartBox.toMap();


    print('CartData'+deliveriesMap.toString());

    double subTotal = 0.0;
    for (int i = 0; i < cartBox.length; i++) {
      print('price'+cartBox.getAt(i)!.price!);
    //  subTotal += double.parse(cartBox.getAt(i)!.price!);

      subTotal += double.parse(cartBox.getAt(i)!.price!)* (double.parse(cartBox.getAt(i)!.quantity!));


      var extrtotal = 0.0;
      for (int j = 0; j < cartBox.getAt(i)!.extraItemList!.length; j++) {
        extrtotal +=
            double.parse(cartBox.getAt(i)!.extraItemList![j].menuExtraItemPrice!);
      }

      subTotal += extrtotal;
    }

    print('subTotal' + subTotal.toString());

    return subTotal.toString();
  }

  getItemTotal(int i) {
    double subTotal = 0.0;

      subTotal += double.parse(cartBox.getAt(i)!.price!)* (double.parse(cartBox.getAt(i)!.quantity!));

      var extrtotal = 0.0;
      for (int j = 0; j < cartBox.getAt(i)!.extraItemList!.length; j++) {
        extrtotal += double.parse(cartBox.getAt(i)!.extraItemList![j].menuExtraItemPrice!);
      }

      subTotal += extrtotal;


    print('subTotalKaif' + subTotal.toString());

    return subTotal.toString();
  }

  getViewButton() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
          elevation: 18.0,
          color: controller.isCartBoxFilled.value ? colorPrimary : lightGrey,

          clipBehavior: Clip.antiAlias,
          // A
          child: MaterialButton(
              minWidth: double.infinity,
              height: 55,
              color:
                  controller.isCartBoxFilled.value ? colorPrimary : lightGrey,
              child: new Text(Strings.view,
                  style: new TextStyle(fontSize: 18.0, color: Colors.white)),
              onPressed: () {
                if (controller.isCartBoxFilled.value) {
                  showViewItemBottomSheet();
                }
              }),
        ),
      ),
    );
  }

  Future<void>? showViewItemBottomSheet() async {

   controller.fetchCateringData();

    Future<void> future = showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return GetX<CateringController>(
          builder: (controller) {
            return SingleChildScrollView(
                primary: true,
                child: Container(
                  margin: 20.marginTop(),
                  padding: 20.paddingBootom(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [showExtraList(controller.cartList)],
                  ),
                ));
          }
        );
      }),
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    print('closeModal');
  }

  Widget showExtraList(List<CateringModal> list) {
    //vertical list
    return Padding(
      padding: 3.paddingAll(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: 5.paddingAll(),
              child: showTopWidget(Strings.back)),
          10.horizontalSpace(),


          Padding(
            padding: 3.paddingAll(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                    showTitle(Strings.viewCatDetails, 16, Colors.black87, Alignment.center),
                    showTitleRichText("Total: ",getSubtotal(), null),
                  ],
            ),
          ),
          Divider(
            thickness: 1.5,
            height: 6,
          ),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (_, i) {


              return Padding(
                padding: 5.paddingAll(),
                child: Card(
                  elevation: 4,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        showTitle(Strings.cateringMenuItem, 16, colorPrimary,
                            Alignment.center),

                        showDeleteIcon(i),

                        showTitleRichText("Item Name : ", list[i].name!, null),

                        showTitleRichText("Item : ", list[i].quantity! + " X " + list[i].price!, null),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding: 5.paddingRight(),
                                child: showTitleRichText("Total : ", (int.parse(list[i].quantity!) *  int.parse(list[i].price!)).toString(), null))),

                        _horizontalListViewBottom(list[i].extraItemList),
                        5.horizontalSpace(),




                        list[i].extraItemList!.length>0?  Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding: 5.paddingAll(),
                                child: showTitleRichText("Item Total : ",getItemTotal(i), null))):Container(),


                      ]),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 10,
              );
            },
          ),
        ],
      ),
    );
  }

  showDeleteIcon(int i) {
    return GestureDetector(
      onTap: () {

        int length=controller.deleteParticularItem(i);
        if(length<=0)
          {
            Get.back();
            controller.isCartBoxFilled.value=false;
          }

      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: 5.paddingRight(),
            child: Image.asset(
              Images.delete_icon,
              height: 20,
              width: 20,
            )),
      ),
    );
  }

  Widget _horizontalListViewBottom(List<CateringExtraMenuItemModal>? list) {
    //controller.selectedItems.clear();

    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: list!.length,
      scrollDirection: Axis.vertical,
      /*itemBuilder: (data_,index) =>_buildBox(color: colorPrimary),*/
      itemBuilder: (_, i) {
        return Padding(
          padding: 6.paddingAll(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: new BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0, 3),
                  blurRadius: 15,
                ),
              ],
            ),
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                showTitleRichText("Extra Item Name : ", list[i].menuExtraItemName!, null),
                showTitleRichText("Item : ",
                    list[i].menuExtraItemQuantity! + " X " + list[i].menuExtraItemPrice!, null),
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding: 5.paddingRight(),
                        child: showTitleRichText("Total : ", (int.parse(list[i].menuExtraItemQuantity!) *  int.parse(list[i].menuExtraItemPrice!)).toString(), null))),


              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 3,
        );
      },
    );
  }

  Widget showTitleRichText(
    String subTitle,
    String title,
    Color? color,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 5),
      child: RichText(
        maxLines: 1,
        text: TextSpan(
          text: subTitle,
          style: TextStyle(
              color: color == null ? Colors.black : color, fontSize: 14),
          children: <TextSpan>[
            TextSpan(
                text: title,
                style: TextStyle(color: color == null ? colorPrimary : color)),
          ],
        ),
      ),
    );
  }

  Widget showTitle(
      String title, double size, Color color, Alignment alignment) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 0, left: 3.0),
        child: Align(
            alignment: alignment,
            child: showText(
                color: color,
                text: title,
                textSize: size,
                fontweight: FontWeight.w600,
                maxlines: 1)),
      ),
    );
  }
}
