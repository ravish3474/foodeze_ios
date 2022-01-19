import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/base/network/UserRepository.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/UpdateProfileController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  UpdateProfileController controller = Get.put(UpdateProfileController());
  String userId = "",
      firstName = "",
      lastName = "",
      email = "",
      uPic = "https://miro.medium.com/max/560/1*MccriYX-ciBniUzRKAUsAw.png";

  late File choosedFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserDetails();
  }

  getUserDetails() async {
    var user = await getUser();

    userId = user!.msg!.id!;
    firstName = user.msg!.firstName;
    lastName = user.msg!.lastName;
    email = user.msg!.marketingMail;

    if (user.msg!.profileImg == null ||
        user.msg!.profileImg.toString().isEmpty) {
      uPic = "https://miro.medium.com/max/560/1*MccriYX-ciBniUzRKAUsAw.png";
    } else
      uPic = ApiEndpoint.IMAGE_URL + user.msg!.profileImg;

    print('firstName' + firstName);
    print('uPic' + uPic);

    controller.fnameController.text = firstName;
    controller.lnameController.text = lastName;
    controller.emailController.text = email;
    controller.profileLoaded.value = false;
  }

  Future pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);

      if (file != null) {
        print('sallu' + file.path);
        choosedFile = file;
        controller.updateProfileImage(file.path);
        //controller.updateProfileLoaded(true);

        uploadProfileImage();

        print('kaifdata' + controller.profileImage.value);
      }
    } else {
      // User canceled the picker
    }
  }

  showPic() {
    print('showPic' + controller.profileLoaded.value.toString());

    if (controller.profileLoaded.value) {
      controller.updateProfileLoaded(false);

      return FileImage(choosedFile);
    } else
      return NetworkImage(uPic);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          await pressBack(result: await getUser());
          //Get.back(result: "Kaif");
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: GetX<UpdateProfileController>(builder: (controller) {
            return Stack(
              children: [
                ShowUp(
                  child: Container(
                    color: Colors.white,
                    height: screenHeight(context),
                    padding: 16.paddingAll(),
                    width: screenWidth(context),
                    child: Column(children: [
                      showTopWidget(),
                      20.horizontalSpace(),
                      Container(
                        width: screenWidth(context),
                        padding: 10.paddingAll(),
                        margin: 2.marginAll(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: GestureDetector(
                                onTap: () {
                                  pickFiles();
                                },
                                child: Column(
                                  children: [
                                    Container(
                                        width: 150.0,
                                        height: 150.0,
                                        decoration: new BoxDecoration(
                                            border: Border.all(),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: showPic()))),
                                  ],
                                ),
                              ),
                            ),
                            30.horizontalSpace(),
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
                              15.horizontalSpace(),
                              CustomButton(context,
                                  height: 55,
                                  borderRadius: 35,
                                  text: Strings.update, onTap: () async {
                                print('submittt');

                                if (validate()) {
                                  if (await checkInternet()) {
                                    hideKeyboard(context);
                                    launchProgress(context: context);

                                    var res = await controller.updateProfile(
                                      userId,
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

                                      successAlertSecond(
                                          context, Strings.success_msg);
                                    } else {
                                      hideKeyboard(context);
                                      Strings.went_wrong.toast();
                                    }
                                  }
                                  else

                                    Strings.checkInternet.toast();

                                } }),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            );
          }),
        ),
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

 Widget  showTopWidget()  {

    return Row(
      children: [
        backButton().pressBack(result:  getUser()),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: " Update Profile",
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }

  Future<void> uploadProfileImage() async {
    //if (controller.profileLoaded.value) {
    launchProgress(context: context);

    if (await checkInternet()) {
      var res = await controller.updateUserIamge(
          userId, controller.profileImage.value);

      disposeProgress();

      if (res.status == "1") {
        print('kaifresultImage' + res.data!.userInfo!.profileImg!);

        var user = await getUser();
        user!.msg!.profileImg = res.data!.userInfo!.profileImg!;
        await saveUser(user);

        uPic = ApiEndpoint.IMAGE_URL + res.data!.userInfo!.profileImg!;


        controller.profileLoaded.value = true;

        successAlertSecond(context, Strings.image_msg);
      } else {
        hideKeyboard(context);
        Strings.went_wrong.toast();
      }
    } else
      Strings.checkInternet.toast();
    // }
  }
}
