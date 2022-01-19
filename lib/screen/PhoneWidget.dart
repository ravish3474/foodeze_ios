import 'package:connectivity/connectivity.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/network/UserRepository.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/CustomTextField.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/AuthController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/screen/CountryListDialog.dart';
import 'package:foodeze_flutter/screen/OTPVerification.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AddUserInfo.dart';
import 'HomePage.dart';

class PhoneWidget extends StatefulWidget {

  PhoneWidget({Key? key}) : super(key: key);

  @override
  _PhoneWidgetState createState() => _PhoneWidgetState();
}

class _PhoneWidgetState extends State<PhoneWidget> {
  AuthController _loginController = Get.put(AuthController());

  AuthController controller = Get.put(AuthController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    takeLocation();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: backButton().pressBack(),
        ),
      ),
      body: GetX<AuthController>(
          init: _loginController,
          builder: (controller) {
            return Stack(
              children: [
                Container(
                  color: Colors.white,
                  height: screenHeight(context),
                  padding: 16.paddingAll(),
                  width: screenWidth(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    /*  SizedBox(
                        height: getstatusBarHeight(context),
                      ),*/
                      // backButton().pressBack(),
                      5.horizontalSpace(),
                      ShowUp(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            5.horizontalSpace(),
                            Align(
                                alignment: Alignment.center,
                                child: Image.asset(Images.logo)),
                            10.horizontalSpace(),
                            Text(
                              Strings.whats_Your_Number,
                              style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            ),
                            10.horizontalSpace(),
                            Text(
                              Strings.we_protect,
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      10.horizontalSpace(),
                      ShowUp(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: 30.marginBottom(),
                              padding: 16.paddingAll(),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(35)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.5, 0.5),
                                    blurRadius: 0.5,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 40,
                                      child: GestureDetector(
                                        onTap: () async {
                                          CountryEntity data = await CountryListDialog().navigate(isAwait: true);
                                          if (data != null) {
                                            print('dataCame'+data.countryCode!);

                                            controller.code.value =
                                            data.countryCode!;
                                            controller.dialCode.value =
                                            data.dialCode!;
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: 10.paddingAll(),
                                              child: Text(
                                                controller.code.value,
                                                style:
                                                GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color:
                                                    Colors.green,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                            ),
                                            8.verticalSpace(),
                                            SvgPicture.asset(
                                              Images.arrowDown,
                                              color: Colors.green,
                                            ),
                                            10.verticalSpace(),
                                            SvgPicture.asset(
                                                Images.dividerLine,
                                                color: Colors.green),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  10.verticalSpace(),
                                  Text(
                                    controller.dialCode.value,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: colorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  10.verticalSpace(),
                                  Expanded(
                                    child:


                                    CustomTextField(
                                      controller: controller.phoneController,
                                      textStyle: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: colorPrimary,
                                          fontWeight: FontWeight.bold),
                                      hint: '(000) 000 00 00',
                                      collapsed: true,
                                      isNumber: true,
                                    ),



                                  )
                                ],
                              ),
                            ),
                            35.horizontalSpace(),

                          ],
                        ),
                      ),

                      Expanded(
                        child: ShowUp(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              CustomButton(context,
                                  height: 55,
                                  borderRadius: 35,
                                  text: Strings.next, onTap: () async {


                                if (controller.phoneController.getValue().toString().isNotEmpty)
                                    {

                                      if(await checkInternet()) {
                                        launchProgress(context: context);
                                        var phone = '${controller
                                            .dialCode}${controller
                                            .phoneController.getValue()}';
                                        var res = await _loginController.mobilelogin(context, mobileNo: phone);

                                        print('resultkaif' + res.otp.toString());
                                        disposeProgress();
                                        //res.message!.toast();
                                        if (res.status == "1") {
                                          if (phone == "+911234567899") {
                                          await saveUser(res);

                                          var user = await getUser();
                                          if (user!.msg!.firstName == null ||
                                              user.msg!.firstName
                                                  .toString()
                                                  .isEmpty)
                                            AddUserInfoPage().navigate();
                                          else
                                            HomePage("").navigate();
                                        } else
                                          OTPVerfication(res, phone).navigate();
                                          //OTPVerfication(res, phone).navigate();
                                        }
                                        else {
                                          hideKeyboard(context);
                                          Strings.went_wrong.toast();
                                        }
                                      }
                                      else {
                                        Strings.checkInternet.toast();
                                        hideKeyboard(context);
                                      }

                                       }
                                    else{

                                      Strings.checkMobile.toast();
                                      print('empty');
                                      hideKeyboard(context);
                                    }


                                  }),
                              8.horizontalSpace(),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],
            );
          }),
    );
  }




  Future<void> takeLocation() async {
    var position = await controller.getLocation(context);


    if (position != null) {
      getLocationData(position);
    } else {
      var position = await controller.getLocation(context);
      if (position != null) {
        getLocationData(position);
      } else {
        var position = await controller.getLocation(context);

        if (position != null)
        getLocationData(position);

      }
    }
  }

  Future<void> getLocationData(LocationData position) async {
    var longitude = position.longitude;
    var latitude = position.latitude;
    var location = position.location;

try {
  var addresses = await Geocoder.local.findAddressesFromQuery(location);
  var first = addresses.first;


  var flist = codes().where((a) => a.countryCode == first.countryCode);
  List<CountryEntity> countries = flist.toList();
  var a = countries[0].dialCode;
  print('datakaif' + a.toString());
  controller.updateCodeAndDialCode(
      countries[0].countryCode, countries[0].dialCode);
}catch(e)
    {
      print('errorn_in_number_phone_widget'+e.toString());
    }

  }

}
