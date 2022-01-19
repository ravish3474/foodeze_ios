import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/CartController.dart';
import 'package:foodeze_flutter/controller/PlaceOrderController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/ApiResponseNew.dart';
import 'package:foodeze_flutter/modal/CartModal.dart';
import 'package:foodeze_flutter/modal/CateringModal.dart';
import 'package:foodeze_flutter/modal/PlaceOrder.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'HomePage.dart';

class SuccessPayment extends StatefulWidget {
  PlaceOrderExtraItemModal? placeOrderData;
  String from='';
  String cateringId='';
  String paymentId='';
  String amount='';
  List<String>?dataString;

  SuccessPayment(this.amount,this.dataString,this.placeOrderData, this.from,this.cateringId,this.paymentId);





  @override
  _SuccessPaymentState createState() => _SuccessPaymentState();
}

class _SuccessPaymentState extends State<SuccessPayment> {
  PlaceOrderController controller = Get.put(PlaceOrderController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    print('WidgetForm'+widget.from);

    if (widget.from == Strings.cart) {
      Box<CartModal> cartBox = Hive.box<CartModal>('cart');
      cartBox.clear();
      print('success_cart_size'+cartBox.length.toString());

      callCartAPi();

    }
    else if(widget.from==Strings.event)
      {
        callEventAPi();
      }

   else {

      Box<CateringModal> cartBox = Hive.box<CateringModal>('catering');
      cartBox.clear();
      print('success_catering_size'+cartBox.length.toString());


      callCateringAPi();
    }

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        gotoHomePage();
        return true;
      },
      child: SafeArea(
          child: Scaffold(
        body: Container(
          padding: 20.paddingAll(),
          color: Colors.white,
          height: screenHeight(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              showTopWidget(),
              16.horizontalSpace(),
              Image.asset(
                Images.done,
                width: screenWidth(context),
                height: 250,
              ),
              30.horizontalSpace(),
              Text(Strings.payment_Success,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                      color: colorPrimary)),
            ],
          ),
        ),
      )),
    );
  }

  Row showTopWidget() {
    return Row(
      children: [
        GestureDetector(onTap: () => gotoHomePage(), child: backButton()),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: Strings.paymentSuccess,
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }



  void gotoHomePage() async {
    Get.reset();
    HomePage("success").navigate(isInfinity: true);
  }

  void callCartAPi() async {

    String result = jsonEncode(widget.placeOrderData);
    var data = await controller.placeOrderAPI(result);

    print('kaifResponse' + data.toString());
  }

  void callCateringAPi() async {

    ApiResponseNew data = await controller.payCateringAPI(cateringId:widget.cateringId ,paymentId: widget.paymentId);

    print('kaifResponseCatering................'+widget.cateringId+" "+widget.paymentId);
    print('kaifResponseCatering' + data.status!);
  }

  void callEventAPi() async {

   // I/flutter (13228): payEventRepo{status: 2, data: {msg: Tickets Sold Out! Any amount deducted will be refunded soon.}}



    var data = await controller.payEventAPI(eventId: widget.dataString![0], customerId: widget.dataString![1], noOfPerson: widget.dataString![2], totalAmount: widget.amount, restaurantId: widget.dataString![3], referenceNo: widget.paymentId, paymentStatus: "1");


    print('kaifResponseEvent' + data.toString());
  }
}
