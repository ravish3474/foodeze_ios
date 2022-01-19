import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/network/UserRepository.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/AuthController.dart';
import 'package:foodeze_flutter/modal/LoginModal.dart';
import 'package:foodeze_flutter/screen/AddUserInfo.dart';
import 'package:foodeze_flutter/screen/HomePage.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPVerfication extends StatelessWidget {
  AuthController _loginController = Get.find();

  LoginModal loginModal;
  String inputOTP = '';
  String phone = "";

  OTPVerfication(this.loginModal, this.phone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: backButton().pressBack(),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            height: screenHeight(context),
            padding: 16.paddingAll(),
            width: screenWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             /*   SizedBox(
                  height: getstatusBarHeight(context),
                ),*/
                //backButton().pressBack(),
                ShowUp(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.horizontalSpace(),
                      Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(Images.logo)),
                      25.horizontalSpace(),
                      Text(
                        Strings.we_can,
                        style: GoogleFonts.poppins(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      20.horizontalSpace(),
                      Text(
                        '${Strings.on_Number}$phone',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      35.horizontalSpace(),
                      Container(
                        margin: 0.marginVertical(),
                        child: OTPTextField(
                          length: 6,
                          fieldWidth: 45,
                          width: MediaQuery.of(context).size.width,
                          style: TextStyle(fontSize: 14),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.box,
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                            inputOTP = pin;
                          },
                        ),
                      ),
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

                              // 2.3
                            if (inputOTP.isEmpty)
                              Strings.enterOTP.toast();
                            else if (inputOTP == loginModal.otp.toString()) {
                              print('otpMatched');
                              await saveUser(loginModal);

                              var user = await getUser();

                             // print('kaifpic'+user!.msg!.profileImg!);

                            if (user!.msg!.firstName == null || user.msg!.firstName.toString().isEmpty)
                                AddUserInfoPage().navigate();
                              else
                                HomePage("").navigate();
                            } else {
                              hideKeyboard(context);
                             Strings.otpNotMatched.toast();
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
      ),
    );
  }


}
