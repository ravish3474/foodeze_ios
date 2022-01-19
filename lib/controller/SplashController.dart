import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodeze_flutter/base/network/UserRepository.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/notificatio/NextScreen.dart';
import 'package:foodeze_flutter/notificatio/PushNotification.dart';
import 'package:foodeze_flutter/screen/AddUserInfo.dart';
import 'package:foodeze_flutter/screen/HomePage.dart';
import 'package:foodeze_flutter/screen/WelcomeWidget.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';

import '../screen/map_screen.dart';
import 'AuthController.dart';

class SplashController extends GetxController {
  AuthController controller = Get.put(AuthController());

  BuildContext context;

  late LocationData locationData;

  SplashController(this.context);

  @override
  void onInit() {
    super.onInit();
  //  checkForInitialMessage();

    openScreen();

  }

  checkForInitialMessage() async {

    /*"initCalled".toast();

    await Firebase.initializeApp();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.data['title'],
        body: initialMessage.data['title'],
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );

      "Msg_is_not_null".toast();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NextScreen(initialMessage.notification?.title)),
      );


    }
    else
    {*/

     // "Msg_is_null".toast();


   // }

  }



  openScreen() async {

      var position = await controller.getLocation(context);
      if (position != null) {
        locationData = position;

      }

      else {
        print('Something is wrong with location');

        //if there is error in location again call getLocation method
        var position = await controller.getLocation(context);
        if (position != null) {
          locationData = position;



        }
        else
        {
          var position = await controller.getLocation(context);
          if (position != null) {
            locationData = position;


          }

        }


      }

      //}
    }


}


