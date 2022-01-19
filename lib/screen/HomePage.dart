import 'dart:io';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/CartController.dart';
import 'package:foodeze_flutter/notificatio/NextScreen.dart';
import 'package:foodeze_flutter/notificatio/PushNotification.dart';
import 'package:foodeze_flutter/notificatio/notification_service.dart';
import 'OrderChatWidget.dart';
import 'ProfilePage.dart';
import 'EventsPage.dart';
import 'package:foodeze_flutter/base/network/UserRepository.dart';
import 'package:foodeze_flutter/controller/AuthController.dart';
import 'package:get/get.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';

import 'KitchenPage.dart';
import 'OrdersPage.dart';
import 'CartPage.dart';
import 'order_status.dart';



class HomePage extends StatefulWidget  {
  String from;

  HomePage(this.from);

  @override
  _HomePageState createState() => _HomePageState();
}


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
 // NotificationService _notificationService = NotificationService();
  //_notificationService.showNotifications( message.data['title'], message.data['message']);



}



class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  AuthController controller=Get.put(AuthController());
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime backbuttonpressedTime = DateTime.now();
  GlobalKey bottomNavigationKey = GlobalKey();



  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  Future<String?> getToken() async {
    String? a=await _messaging.getToken();
    callSubscribeTopic();
    print('kaiftoken'+a!);
    return a;
  }

  void registerNotification() async {


    await Firebase.initializeApp();

    _messaging = FirebaseMessaging.instance;

    getToken();

  //  _messaging.subscribeToTopic('12918077506940');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');


      //if app is resume and
      // notification is receive then this code will work
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message title: ${message.data['title']}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        PushNotification notification = PushNotification(
          title:message.data['title'],
          body: message.data['message'],
          dataTitle: message.data['title'],
          dataBody: message.data['message'],
        );


        _notificationInfo = notification;

        if (_notificationInfo != null) {


          NotificationService _notificationService = NotificationService();
          //if rider chatting is false and notification is not for rider
          print('RIderChatting'+Strings.riderChatRunning.toString());

          if(!Strings.riderChatRunning)
         {
           print('ifffRun');
            _notificationService.showNotifications( message);


         }
          else
            {
              print('elseeeRunnn');

              //if notification is for order or for rider(but rider chatting is false)
              if(notification.dataBody!.isNotEmpty && !notification.dataTitle!.contains("rider"))
                _notificationService.showNotifications( message);
            }

        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body:initialMessage.data['message'],
        dataTitle: initialMessage.data['title'],
        content:  initialMessage.data['message'],
        dataBody: initialMessage.data['action_destination'],
      );

     // "home_msg_is_not_Null".toast();





      if(notification.dataBody!.isNotEmpty && notification.dataTitle!.contains("order"))
        OrderStatus(notification.dataBody!,notification.id!,Strings.home).navigate();

      else if(notification.dataBody!.isNotEmpty && notification.dataTitle!.contains("rider"))
        OrderChatWidget(notification.dataBody!,notification.id!,Strings.home)
            .navigate();





    }
    //else
     // "home_msg_is_Null".toast();
  }


  // List<Widget> viewContainer=[];
  Future<void> wait() async {

    /*if(HomePage("").from=="success")
      {
        print('success_run');*/
    await Future.delayed(Duration(milliseconds: 100));
    //}

  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print('app_is_resumeed');
        Strings.riderChatRunning=false;
        checkForInitialMessage();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:

        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('fromHome'+widget.from);
    WidgetsBinding.instance!.addObserver(this);

    registerNotification();




    //when the user click on notification this code will work
    checkForInitialMessage();



    // For handling notification when the app is in background
    // but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.data['message'],
        dataTitle: message.data['title'],
        dataBody: message.data['message'],
      );


      setState(() {
        _notificationInfo = notification;
        //_totalNotifications++;
      });




    });




    if(GetPlatform.isIOS)
      SystemChrome.setEnabledSystemUIOverlays([]);

    print('currentPage'+ controller.currentPage.value.toString());

    if(controller.currentPage.value>0) {

      controller.updateBottomPosition(0);
    }



    getUserss();

  }



  final List<Widget>  viewContainer = [
    KitchenWidget(),
    OrderWidget(),
    CartPage("home"),
    EventWidget(),
    ProfilePage(),
  ];



  @override
  Widget build(BuildContext context) {
    if(widget.from=="success") {
      print('successRunPart2');
      wait();
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Scaffold(
            key: _scaffoldKey,
            body: Container(
              color: Colors.white,
              child: GetX<AuthController>(builder: (controller) {
                return IndexedStack(
                  index:controller.currentPage.value,
                  children: viewContainer,
                );
              }),
            ),
            bottomNavigationBar: FancyBottomNavigation(
              tabs: [
                TabData(iconData: Icons.location_pin, title: "Kitchen"),
                TabData(iconData: Icons.shopping_basket, title: "Order"),
                TabData(iconData: Icons.shopping_bag_sharp, title: "Cart"),
                TabData(iconData: Icons.calendar_today_outlined, title: "Events"),
                TabData(iconData: Icons.person, title: "Profile"),
              ],
              initialSelection: 0,
              key: bottomNavigationKey,
              onTabChangedListener: (position) {
                print('onTabCHangedListener'+position.toString());
      
                if(position==2)
                  CartController().fetchCartData();
      
      
                controller.updateBottomPosition(position);
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getUserss() async {
    try {
      var user = await getUser();
      print('firstName' + user!.msg!.firstName);
      print('lastName' + user.msg!.lastName);
      print('email' + user.msg!.marketingMail);
      print('phone' + user.msg!.phone!);
    } catch (e) {
      print('userException' + e.toString());
    }
  }


  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    //Statement 1 Or statement2
    bool backButton =
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);

    if (backButton) {
      backbuttonpressedTime = currentTime;
      "Please click back again to exit".toast();
      return false;
    }
    exit(0);
    return true;
  }



  void callSubscribeTopic()async {



    String mobile=await getUserMobile();
    mobile=mobile.substring(1,mobile.length);

    String topic=await getUserId()+mobile;
    print('SubscribedTOpic_'+topic+"  "+Strings.appName.toLowerCase());

    _messaging.subscribeToTopic(topic);
    _messaging.subscribeToTopic(Strings.appName.toLowerCase());
    // var res = await authController.updateDeviceTokenAPI(userId:   await getUserId(), deviceToken: token!);

    // print('callUpdateDeviceTokenAPi' + res.status!);
  }



}


class KitchenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: 30.marginBottom(),
        child: KitchenPage());
  }
}

class OrderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: 30.marginBottom(),
        child: OrderPage());
  }
}



class EventWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: 30.marginBottom(),
        child: EventsPage());
  }


}








