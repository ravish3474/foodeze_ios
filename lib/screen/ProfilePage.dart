import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/base/network/UserRepository.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/AuthController.dart';
import 'package:foodeze_flutter/controller/ProfileDetailController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/LoginModal.dart';
import 'package:foodeze_flutter/screen/CustomerChatTicket.dart';
import 'package:foodeze_flutter/screen/UpdateProfile.dart';
import 'package:foodeze_flutter/screen/WelcomeWidget.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'NotificationList.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>  {
  ProfileDetailController controller = Get.put(ProfileDetailController());
  AuthController authController=Get.find();
  late final FirebaseMessaging _messaging;

  @override
  void initState() {
    // TODO: implement initState

    print('called__Fifth');


    super.initState();
    getUserDetails();
  }





  getUserDetails() async {
    var user = await getUser();

    controller.userId.value = user!.msg!.id!;
    controller.firstName.value = user.msg!.firstName;
    controller.lastName.value = user.msg!.lastName;
    controller.email.value = user.msg!.marketingMail;

    if (user.msg!.profileImg == null ||
        user.msg!.profileImg.toString().isEmpty) {
      controller.uPic.value =
          "https://miro.medium.com/max/560/1*MccriYX-ciBniUzRKAUsAw.png";
    } else
      controller.uPic.value = ApiEndpoint.IMAGE_URL + user.msg!.profileImg;

    print('ProfileName' + controller.firstName.value);
    print('uPic' + controller.uPic.value);

    controller.profileLoaded.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: GetX<ProfileDetailController>(
              builder: (controller) {
            return Container(
              color: Colors.white,
              alignment: Alignment.center,
              padding: 5.paddingAll(),
              child: ShowUp(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   /* showText(
                        color: colorPrimary,
                        text: "Account",
                        textSize: 25,
                        fontweight: FontWeight.w500,
                        maxlines: 1),*/
                    15.horizontalSpace(),
                    Container(
                      height: 200,
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: new LinearGradient(
                              colors: [
                                colorPrimary,
                                colorprimary2,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              tileMode: TileMode.clamp)),
                      child: Column(
                        children: [
                          15.horizontalSpace(),
                          GestureDetector(
                              onTap: ()  async{

                              LoginModal user = await UpdateProfile().navigate(isAwait: true);



                              controller.uPic.value=ApiEndpoint.IMAGE_URL + user.msg!.profileImg;
                              controller.firstName.value=user.msg!.firstName;
                              controller.lastName.value=user.msg!.lastName;



                              },
                              child: Container(
                                  width: 120.0,
                                  height: 120.0,
                                  decoration: new BoxDecoration(
                                      border: Border.all(),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: showPic())))),
                          15.horizontalSpace(),
                          showText(
                              color: Colors.black,
                              text:
                                  controller.firstName.value[0].toUpperCase() +controller.firstName.value.substring(1,controller.firstName.value.length)+ " "+ controller.lastName.value[0].toUpperCase() +controller.lastName.value.substring(1,controller.lastName.value.length),
                              textSize: 23,
                              fontweight: FontWeight.w400,
                              maxlines: 1),
                        ],
                      ),
                    ),
                    Container(
                      padding: 10.paddingAll(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          25.horizontalSpace(),
                          GestureDetector(
                              onTap: () => CustomerChatTicket().navigate(),
                              child: showTextLayout(Strings.message, Icons.email)),
                          25.horizontalSpace(),
                          GestureDetector(
                              onTap: () => NotificationList().navigate(),
                              child: showTextLayout(
                                Strings.notification,
                                Icons.notifications,
                              )),
                          25.horizontalSpace(),
                          GestureDetector(
                              onTap: () async {

                                LoginModal user = await UpdateProfile().navigate(isAwait: true);

                                controller.uPic.value=ApiEndpoint.IMAGE_URL +user.msg!.profileImg;
                                controller.firstName.value=user.msg!.firstName;
                                controller.lastName.value=user.msg!.lastName;

                              },
                              child: showTextLayout(
                                  Strings.accountDetails, Icons.person)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ShowUp(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 30),
                              child: CustomButton(context,
                                  height: 55,
                                  borderRadius: 35,
                                  text: Strings.logout, onTap: () async {
                                logOut(context);
                              }),
                            ),
                            8.horizontalSpace(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }

  showPic() {
    print('UserPicProfilePage' + controller.uPic.value);

    if (controller.profileLoaded.value)
      return NetworkImage(controller.uPic.value);


  }

  Widget showTextLayout(String title, IconData icon) {
    return Container(
      child: Padding(
        padding: 0.paddingAll(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 1,
                      child: ClipOval(
                        child: Material(
                          color: colorPrimary, // Button color
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {},
                            child: SizedBox(width: 20, height: 40, child: Icon(icon,color: Colors.white,)),
                          ),
                        ),
                      )    ),
                  Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          showText(
                              color: Colors.black,
                              text: title,
                              textSize: 18,
                              fontweight: FontWeight.w400,
                              maxlines: 1)
                        ],
                      ),
                    ),
                  ),
                ]),
            5.horizontalSpace(),
            Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }

  logOut(context) {
    CustomDialog(context,
        widget: Container(
          padding: 20.paddingAll(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Logout',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 30.0,
                      color: Colors.black.withOpacity(0.47))),
              16.horizontalSpace(),
              Image.asset(
                Images.error_image,
                height: 150,
              ),
              30.horizontalSpace(),
              Text(
                'Are you sure want to logout?',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.47)),
                textAlign: TextAlign.center,
              ),
              30.horizontalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(context, height: 50, text: 'No', isBorder: true,
                      onTap: () {
                    pressBack();
                  }, width: screenWidth(context) / 2.8),
                  CustomButton(context, height: 50, text: 'Yes', onTap: () {

                    callUnSubscribeTopic();

                    clearPreference();
                    WelcomeWidget().navigate(isInfinity: true);
                  }, width: screenWidth(context) / 2.8)
                ],
              ),
            ],
          ),
        ));
  }

  void callUnSubscribeTopic()  async {
    String mobile=await getUserMobile();
    mobile=mobile.substring(1,mobile.length);

    String topic=await getUserId()+mobile;
    print('SubscribedTOpic_'+topic+"  "+Strings.appName.toLowerCase());


    _messaging = FirebaseMessaging.instance;
    _messaging.unsubscribeFromTopic(topic);
    _messaging.unsubscribeFromTopic(Strings.appName.toLowerCase());
   // var res = await authController.updateDeviceTokenAPI(userId:   await getUserId(), deviceToken: token!);

   // print('callUpdateDeviceTokenAPi' + res.status!);
  }
}
