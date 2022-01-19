/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/CreateEventController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/screen/HomePageNotification.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  CreateEventController controller = Get.put(CreateEventController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Get.back();
          return true;
        },
        child: Scaffold(
            body: GetX<CreateEventController>(
              builder: (controller) {
                return SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: 16.paddingAll(),
            width: screenWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showTopWidget(),
                13.horizontalSpace(),
                ShowUp(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.horizontalSpace(),
                      eventTitle(),
                      20.horizontalSpace(),
                      eventDescription(),
                      20.horizontalSpace(),
                      dateTimeWidget(),
                      20.horizontalSpace(),
                      showKitchenDropDown(),
                      20.horizontalSpace(),
                      yourMenu(),
                      20.horizontalSpace(),
                      foodQuantityAndLocation(),
                      20.horizontalSpace(),
                      cityAndProvince(),
                    ],
                  ),
                ),
                ShowUp(
                  child: Column(
                    children: [
                      50.horizontalSpace(),
                      CustomButton(context,
                          height: 55,
                          borderRadius: 35,
                          text: Strings.submit, onTap: () async {
                        print('submittt');

                        if (validate()) {
                          if (await checkInternet()) {
                            launchProgress(context: context);

                            var res = await controller.createEventAPI(
                              await getUserId(),
                              controller.eventTitleController.getValue(),
                              controller.eventDescController.getValue(),
                              "1",
                              controller.eventDateController.getValue(),
                              controller.eventHoursController.getValue(),
                              controller.eventMenuController.getValue(),
                              controller.eventQuantityController.getValue(),
                              controller.eventLocationController.getValue(),
                              controller.eventCityController.getValue(),
                              controller.eventProvinceController.getValue(),
                            );

                            print('resultkaif' + res.status.toString());
                            disposeProgress();
                            if (res.status == "1") {
                              successAlert(context);
                            } else {
                              hideKeyboard(context);
                              Strings.went_wrong.toast();
                            }
                          } else
                            Strings.checkInternet.toast();
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
              }
            )),
      ),
    );
  }

  Widget showKitchenDropDown() {
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
          hint: Text(Strings.selectKitchen,),
          // Not necessary for Option 1
          value: controller.selectedKithcen.value,
          onChanged: (newValue) {


            controller.selectedKithcen.value = newValue as String;
            if(newValue==Strings.selectKitchen)
              controller.dropDownTextStyle.value=TextStyle(color: Colors.black54);
            else
              controller.dropDownTextStyle.value=TextStyle(color: Colors.black);

              hideKeyboard(context);

          },
          items: getMonth().map((location) {
            return DropdownMenuItem(
              child: new Text(location,style: controller.dropDownTextStyle.value),
              value: location,
            );
          }).toList(),
        ),
      ),
    );
  }

  List getMonth() {
    var monthList = [
      "Select Kithchen",
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return monthList;
  }

  Widget eventTitle() {


    return inputTextFieldWidget(
        controller: controller.eventTitleController,
        title: Strings.eventTitle,
        icon: Icon(Icons.title_outlined, color: colorPrimary),
        keyboardType: TextInputType.name,
        isEnable: true,
    );
  }

  Widget eventDescription() {

    return inputTextFieldWidget(
        controller: controller.eventDescController,
        title: Strings.eventDesc,
        icon: Icon(Icons.description_outlined, color: colorPrimary),
        keyboardType: TextInputType.name,
        isEnable: true,
    );
  }

  Widget dateTimeWidget() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => selectDate(),
            child: Container(
              margin: 5.marginRight(),
              child: inputTextFieldWidget(
                  controller: controller.eventDateController,
                  title: Strings.eventDate,
                  icon: Icon(Icons.date_range, color: colorPrimary),
                  keyboardType: TextInputType.name,
                  isEnable: false),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => selectTime(),
            child: inputTextFieldWidget(
                controller: controller.eventHoursController,
                title: Strings.eventHours,
                icon: Icon(Icons.date_range, color: colorPrimary),
                keyboardType: TextInputType.name,
                isEnable: false),
          ),
        ),
      ],
    );
  }

  Widget yourMenu() {
    return inputTextFieldWidget(
        controller: controller.eventMenuController,
        title: Strings.eventMenu,
        icon: Icon(Icons.menu_book, color: colorPrimary),
        keyboardType: TextInputType.name,
        isEnable: true);
  }

  Widget foodQuantityAndLocation() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: 5.marginRight(),
            child: inputTextFieldWidget(
                controller: controller.eventQuantityController,
                title: Strings.eventQuantity,
                icon:
                    Icon(Icons.production_quantity_limits, color: colorPrimary),
                keyboardType: TextInputType.name,
                isEnable: true),
          ),
        ),
        Expanded(
          flex: 1,
          child: inputTextFieldWidget(
              controller: controller.eventLocationController,
              title: Strings.eventLocation,
              icon: Icon(Icons.location_pin, color: colorPrimary),
              keyboardType: TextInputType.name,
              isEnable: true),
        ),
      ],
    );
  }

  Widget cityAndProvince() {



    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(right: 5),
             child: inputTextFieldWidget(
                  controller: controller.eventCityController,
                  title: Strings.eventCity,
                  icon: Icon(Icons.location_pin, color: colorPrimary),
                  keyboardType: TextInputType.name,
                  isEnable: true)
          ),
        ),



        Expanded(
          flex: 1,
          child:  inputTextFieldWidget(
              controller: controller.eventProvinceController,
              title: Strings.eventProvince,
              icon: Icon(Icons.event_available_rounded, color: colorPrimary),
              keyboardType: TextInputType.name,
              isEnable: true),
        ),
      ],
    );
  }

  bool validate() {
    String title = controller.eventTitleController.getValue();
    String description = controller.eventDescController.getValue();
    String date = controller.eventDateController.getValue();
    String hours = controller.eventHoursController.getValue();
    String menu = controller.eventMenuController.getValue();
    String quantity = controller.eventQuantityController.getValue();
    String location = controller.eventLocationController.getValue();
    String city = controller.eventCityController.getValue();
    String province = controller.eventProvinceController.getValue();
    String selectedKitchen = controller.selectedKithcen.value;

    if (title.isEmpty) {
      "Please enter event title".toast();
      return false;
    } else if (description.isEmpty) {
      "Please enter event description".toast();
      return false;
    } else if (date.isEmpty) {
      "Please select event date".toast();
      return false;
    } else if (hours.isEmpty) {
      "Please select event hours".toast();
      return false;
    } else if (selectedKitchen == "Select Kithchen") {
      "Please select kitchen".toast();
      return false;
    } else if (menu.isEmpty) {
      "Please enter  menu".toast();
      return false;
    } else if (quantity.isEmpty) {
      "Please enter quantity".toast();
      return false;
    } else if (city.isEmpty) {
      "Please enter city".toast();
      return false;
    } else if (province.isEmpty) {
      "Please enter province".toast();
      return false;
    }

    return true;
  }

  Row showTopWidget() {
    return Row(
      children: [
        backButton().pressBack(result: "kaif"),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: " Create Event",
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
              Text(Strings.app_name,
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
                Strings.success_event,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.withOpacity(0.47)),
                textAlign: TextAlign.center,
              ),
              30.horizontalSpace(),
              CustomButton(context, height: 50, text: 'Ok', onTap: () {
                HomePage("").navigate(isInfinity: true);
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

      controller.eventDateController.text = _date;
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  void selectTime() {
    DatePicker.showTimePicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true, onConfirm: (time) {
      print('confirm $time');
      var _time = '${time.hour}:${time.minute}:${time.second}';
      controller.eventHoursController.text = _time;
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
}
*/
