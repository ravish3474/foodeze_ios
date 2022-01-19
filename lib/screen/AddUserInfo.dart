import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/network/UserRepository.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/AddUserController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/screen/HomePage.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUserInfoPage extends StatefulWidget {
  @override
  _AddUserInfoPageState createState() => _AddUserInfoPageState();
}

class _AddUserInfoPageState extends State<AddUserInfoPage> {
  AddUserController controller = Get.put(AddUserController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          closeAPP();
          return true;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                      /*SizedBox(
                        height: getstatusBarHeight(context),
                      ),*/
                      /*backButton(),*/
                      1.horizontalSpace(),
                      ShowUp(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.horizontalSpace(),
                            Align(
                                alignment: Alignment.center,
                                child: Image.asset(Images.logo)),
                            20.horizontalSpace(),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                Strings.createProfile,
                                style: GoogleFonts.poppins(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                            ),
                            20.horizontalSpace(),
                            firstNameWidget(),
                            20.horizontalSpace(),
                            lastNameWidget(),
                            20.horizontalSpace(),
                            emailWidget(),
                          ],
                        ),
                      ),
                      20.horizontalSpace(),
                      Expanded(
                        child: ShowUp(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              35.horizontalSpace(),
                              CustomButton(context,
                                  height: 55,
                                  borderRadius: 35,
                                  text: Strings.submit, onTap: () async {
                                print('submittt');

                                if (validate()) {
                                  if (await checkInternet()) {
                                    launchProgress(context: context);

                                    var res = await controller.updateProfile(
                                      await getUserId(),
                                      controller.fnameController.getValue(),
                                      controller.lnameController.getValue(),
                                      controller.emailController.getValue(),
                                    );

                                    print('resultkaif' + res.status.toString());
                                    disposeProgress();
                                    if (res.status == "1") {
                                      var user = await getUser();

                                      user!.msg!.marketingMail =
                                          controller.emailController.getValue();
                                      user.msg!.firstName =
                                          controller.fnameController.getValue();
                                      user.msg!.lastName =
                                          controller.lnameController.getValue();

                                      await saveUser(user);

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
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget firstNameWidget() {
    return inputTextFieldWidget(
        controller: controller.fnameController,
        title: Strings.fName,
        icon: Icon(Icons.account_circle_outlined, color: colorPrimary),
        keyboardType: TextInputType.name,
        isEnable: true);
  }

  Widget lastNameWidget() {
    return inputTextFieldWidget(
        controller: controller.lnameController,
        title: Strings.lName,
        icon: Icon(Icons.account_circle_outlined, color: colorPrimary),
        keyboardType: TextInputType.name,
        isEnable: true);
  }

  Widget emailWidget() {
    return inputTextFieldWidget(
        controller: controller.emailController,
        title: Strings.email,
        icon: Icon(Icons.email_outlined, color: colorPrimary),
        keyboardType: TextInputType.emailAddress,
        isEnable: true);
  }

  bool validate() {
    String fName = controller.fnameController.getValue();
    String email = controller.emailController.getValue();

    if (fName.isEmpty) {
      "Please enter first name".toast();
      return false;
    } else if (email.isEmpty) {
      "Please enter email".toast();
      return false;
    } else if (email.length > 0 && !email.isEmail) {
      "Please enter valid email".toast();
      return false;
    }
    return true;
  }

  successAlert(context) {
    CustomDialog(context,
        barrierDismissible: false,
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
                Strings.success_created,
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
}
