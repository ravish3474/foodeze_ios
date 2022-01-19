import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/modal/CardModal.dart';
import 'package:foodeze_flutter/modal/CartModal.dart';
import 'package:foodeze_flutter/modal/CateringModal.dart';
import 'package:foodeze_flutter/modal/ExtraMenuItemModal.dart';
import 'package:foodeze_flutter/screen/SplashWidget.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'modal/CartModal.dart';
import 'modal/CateringExtraMenuItemModal.dart';
import 'modal/ExtraMenuItemModal.dart';

import 'notificatio/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();
  await CountryCodes.init();

  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter<CartModal>(CartModalAdapter());
  Hive.registerAdapter<ExtraMenuItemModal>(ExtraMenuItemModalAdapter());
  Hive.registerAdapter<CardModal>(CardModalAdapter());
  Hive.registerAdapter<CateringModal>(CateringModalAdapter());
  Hive.registerAdapter<CateringExtraMenuItemModal>(CateringExtraMenuItemModalAdapter());
  await Hive.openBox<CartModal>("cart");
  await Hive.openBox<CardModal>("card");
  await Hive.openBox<CateringModal>("catering");


 /* await SentryFlutter.init(
          (options) {
        options.dsn = 'https://621ec1541abe4f4fa2d8ec288060298d@o1016680.ingest.sentry.io/5990896';
      });*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.appName,
        theme: ThemeData(
          primarySwatch: materialColor(),
        ),
        home: /*RateScreen(Strings.vk,"6","2")*/ /*AddCateringRequest()*/ SplashWidget()
        /*CateringMenuScreen("2","Tiget Lilly","15","50")*/
        ,
      );

  }
}

materialColor() {
  Map<int, Color> colorCodes = {
    50: Color(0xFFa6cb45),
    100: Color(0xFFa6cb45),
    200: Color(0xFFa6cb45),
    300: Color(0xFFa6cb45),
    400: Color(0xFFa6cb45),
    500: Color(0xFFa6cb45),
    600: Color(0xFFa6cb45),
    700: Color(0xFFa6cb45),
    800: Color(0xFFa6cb45),
    900: Color(0xFFa6cb45),
  };
  // Green color code: FF93cd48
  MaterialColor customColor = MaterialColor(0xFF93cd48, colorCodes);

  return customColor;
}
