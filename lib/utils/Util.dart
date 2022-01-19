import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


//convert date from yyyy-MM-dd hh:mm:ss to dd-MMM-yyyy hh:mm:ss format
String convertDate(String input)
{

  var inputFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
  var date1 = inputFormat.parse(input);

  var outputFormat = DateFormat("dd-MMM-yyyy hh:mm:ss a");
  var date2 = outputFormat.format(date1);

  return date2;

}




String  addTwoHourTime(String input22) {

  var originalInput;

  // var input = '2021-10-26 07:30:29';

  print('input22'+input22);

  originalInput=convertDate(input22);//input26-Oct-2021 07:30:29 AM

  var arrayOfTime222=input22.split(" ");
  var arrayOfTime=originalInput.split(" ");

  var inputFormat = DateFormat("dd-MMM-yyyy hh:mm:ss a");
  DateTime date1 = inputFormat.parse(originalInput);



  var  result= TimeOfDay.fromDateTime(date1.add(Duration(minutes: 120)));
  var output=result.hour.toString()+":"+result.minute.toString();

  var hour=result.hour.toString();
  var min=result.minute.toString();

  if(hour.length==1)
    hour="0"+hour;

  if(min=="0")
    min="0"+min;

  else if(min.length==1)
    min="0"+min;


  var finalDate=arrayOfTime222[0]+" "+hour+":"+min+":"+"00";

  var hourstime=  DateFormat.jm().format(DateTime.parse(finalDate));


  output=arrayOfTime[0]+" "+hourstime;

  var kaifRes=output.split(" ");

  print('resultkafi'+kaifRes[0]+" "+kaifRes[1].toString());


  return kaifRes[0]+" "+kaifRes[1].toString();

}



//convert date from yyyy-MM-dd  to dd-MMM-yyyy format
String convertDate2(String input)
{

  var inputFormat = DateFormat("yyyy-MM-dd");
  var date1 = inputFormat.parse(input);

  var outputFormat = DateFormat("dd-MMM-yyyy");
  var date2 = outputFormat.format(date1);

  return date2;

}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}


double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}




bool validateMobile(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,15}$)';
  RegExp regExp = new RegExp(patttern);
  return regExp.hasMatch(value);
}

double getstatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}

String randomString(int strlen) {
  var alpha =
      "ARBAEROMCBHAKJJNKKWROJOAIIAHRAMNSNDFNWNNWNXBFBWFEWUEWBBEUWEWBFBWBZKAKKNAKNBWWARAHNAKNAN";
  var numeric = "1234567890987654321123451234567890678900987654321";

  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 1; i < strlen + 1; i++) {
    if (i % 2 == 0)
      result += alpha[rnd.nextInt(alpha.length)];
    else
      result += numeric[rnd.nextInt(numeric.length)];
  }
  return result;
}


launchProgress({
  required BuildContext context,
  String message = 'Processing..',
}) {
  CustomDialog(context,
      durationmilliseconds: 1,
      isLoader: true,
      barrierDismissible: false,
      widget: Center(child: CircularProgressIndicator()));
}

disposeProgress() {
  Get.back();
}
