import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/notificatio/NextScreen.dart';
import 'package:foodeze_flutter/screen/OrderChatWidget.dart';
import 'package:foodeze_flutter/screen/order_status.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'dart:async';

class NotificationService {
  var count=1;


  //NotificationService a singleton object
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
  }

  AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        'This channel is used for important notifications.', //
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  Future<void> showNotifications(RemoteMessage message) async {

    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android:android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
     count,
        message.data['title'],
        message.data['message'],platform,
payload: message.data['title']+"k"+message.data['message']+"k"+message.data['action_destination']+"k"+message.data['id']    );



   // count++;

  }



  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future selectNotification(String? payload) async {
  //handle your logic here
  print('clickedONotification'+payload!);

  //payload: message.data['title']+0
  // "k"+message.data['message']+1
  // "k"+message.data['action_destination']+2
  // "k"+message.data['id']    );3

  var data=payload.split("k");
  print('dataPayload'+data.toString());

  if(data[0].contains("order"))
    OrderStatus(data[2],data[3],Strings.home).navigate();
 else if(data[0].contains("rider"))
    OrderChatWidget(data[2],data[3],Strings.home).navigate();

 // NextScreen(payload).navigate();




}
