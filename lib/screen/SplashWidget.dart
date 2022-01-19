import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/network/UserRepository.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/AuthController.dart';
import 'package:foodeze_flutter/controller/SplashController.dart';
import 'package:foodeze_flutter/notificatio/NextScreen.dart';
import 'package:foodeze_flutter/notificatio/PushNotification.dart';
import 'package:foodeze_flutter/notificatio/notification_service.dart';
import 'package:foodeze_flutter/screen/AddUserInfo.dart';
import 'package:foodeze_flutter/screen/order_status.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomePage.dart';
import 'OrderChatWidget.dart';
import 'WelcomeWidget.dart';

class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}


class _SplashWidgetState extends State<SplashWidget> {
  AuthController controller = Get.put(AuthController());

  late LocationData locationData;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    initCalled();


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
          init: SplashController(context),
          builder: (snapshot) {
            return ShowUp(
              child: Container(
                color: Colors.white,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Images.logo,
                    width: screenWidth(context),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void initCalled()async {

   // "initCalled".toast();

    await Firebase.initializeApp();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.data['title'],
        body: initialMessage.data['message'],
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['action_destination'],
        id: initialMessage.data['id'],
      );

    //  "Msg_is_not_null".toast();
      3.delay(() {


        if(notification.dataBody!.isNotEmpty && notification.dataTitle!.contains("order"))
          OrderStatus(notification.dataBody!,notification.id!,Strings.notification).navigate();
        else if(notification.dataBody!.isNotEmpty && notification.dataTitle!.contains("rider"))
          OrderChatWidget(notification.dataBody!,notification.id!,Strings.notification)
              .navigate();

        else
          HomePage("").navigate(isRemove: true);



      });



    }
    else
      {

      //  "Msg_is_null".toast();
        3.delay(() {

          checkInternetSplash();


        });


      }

  }


  openScreen() async {
    var user = await getUser();

    if (user == null)
      WelcomeWidget().navigate();
    else if (user.msg!.firstName == null ||
        user.msg!
            .firstName
            .toString()
            .isEmpty)
      AddUserInfoPage().navigate();
    else {
      var position = await controller.getLocation(context);
      if (position != null) {
        locationData = position;



        HomePage("").navigate();

      }

      else {
        print('Something is wrong with location');

        //if there is error in location again call getLocation method
        var position = await controller.getLocation(context);
        if (position != null) {
          locationData = position;


          HomePage("").navigate();
        }
        else
        {
          var position = await controller.getLocation(context);
          if (position != null) {
            locationData = position;

            HomePage("").navigate();
          }

        }


      }

      //}
    }
  }

  Future<void> checkInternetSplash() async {
    print('checkCalled');

    if (await checkInternet()){
      print('running');
      openScreen();
    }
    else {
      print('not_running');
      successAlert(false,"",context,Strings.appName,  Images.error_image, Strings.checkInternet);
    }

    var subscription = await Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('kaifcheck' + result.toString());
      //openScreen();
      if (result != ConnectivityResult.none) {
        print('openScreenCalled');
        //openScreen();
      }
    });
  }
}
