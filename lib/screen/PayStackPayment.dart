import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/CardModal.dart';
import 'package:foodeze_flutter/modal/PlaceOrder.dart';
import 'package:get/get.dart';

import 'SuccessPaymentScreen.dart';

class PayStackPayment {
  callPaymentFunction({required  List<String>?dataString,required String cateringId,required String from,required PlaceOrderExtraItemModal? placeOrderData,required CardModal modal, required double amount, required BuildContext context}) async {
    final plugin = PaystackPlugin();

    await plugin.initialize(publicKey: Strings.paystackPublicKey);

    Charge charge = Charge()
      ..currency = "ZAR"
      ..amount = amount.toInt()*100 // In base currency
      ..email = await getUserEmail()
      ..card = _getCardFromUI(modal);

    charge.reference = _getReference();

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: true,
        logo: MyLogo(),
      );

      if (response.message.toLowerCase().contains("success")) {
        Get.back();
        placeOrderData?.paymentId=_getReference();

        SuccessPayment(amount.toString(),dataString,placeOrderData,from,cateringId,_getReference()).navigate();


      } else
        Strings.went_wrong.toast();

      print('KaifResponse = $response');

    } catch (e) {
      Strings.went_wrong.toast();
      rethrow;
    }
  }




  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI(CardModal modal) {
    return PaymentCard(
      number: modal.cardNumber,
      cvc: modal.cvvCode,
      expiryMonth: int.parse(modal.expiryDate!.substring(0, 2)),
      expiryYear: int.parse(modal.expiryDate!.substring(3, 5)),
    );
  }
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      child: Text(
        Strings.appName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
