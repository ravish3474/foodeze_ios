import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/CardController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/CardModal.dart';
import 'package:foodeze_flutter/modal/PlaceOrder.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'PayStackPayment.dart';

class AddCardScreen extends StatefulWidget {
  PlaceOrderExtraItemModal? placeOrderData;
  double price;
  String from;
  String cateringID;
  List<String>?dataString;
  AddCardScreen(this.dataString,this.cateringID, this.from, this.placeOrderData, this.price);

  @override
  State<StatefulWidget> createState() {
    return AddCardScreenState();
  }
}

class AddCardScreenState extends State<AddCardScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CardController controller = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
          color: Colors.white,
          height: screenHeight(context),
          padding: 16.paddingAll(),
          child: Column(
            children: [
              Container(
                height: screenHeight(context) * 0.83,
                child: SingleChildScrollView(
                  child: Container(
                    child: ShowUp(
                      child: GetX<CardController>(builder: (controller) {
                        return Column(
                          children: <Widget>[
                            showTopWidget(),
                            20.horizontalSpace(),
                            CreditCardWidget(
                              cardBgColor: colorPrimary,
                              height: 170,
                              cardNumber: controller.cardNumber.value,
                              expiryDate: controller.expiryDate.value,
                              cardHolderName: controller.cardHolderName.value,
                              cvvCode: controller.cvvCode.value,
                              showBackView: controller.isCvvFocused.value,
                              obscureCardNumber: true,
                              obscureCardCvv: true,
                            ),
                            CreditCardForm(
                              formKey: formKey,
                              obscureCvv: true,
                              obscureNumber: false,
                              cardNumber: controller.cardNumber.value,
                              cvvCode: controller.cvvCode.value,
                              cardHolderName: controller.cardHolderName.value,
                              expiryDate: controller.expiryDate.value,
                              themeColor: Colors.blue,
                              cardNumberDecoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Number',
                                hintText: 'XXXX XXXX XXXX XXXX',
                              ),
                              expiryDateDecoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Expired Date',
                                hintText: 'XX/XX',
                              ),
                              cvvCodeDecoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'CVV',
                                hintText: 'XXX',
                              ),
                              cardHolderDecoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Card Holder',
                              ),
                              onCreditCardModelChange: onCreditCardModelChange,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: 5.marginAll(),
                        child: CustomButton(context,
                            textStyle: TextStyle(
                                fontSize: 16, color: Colors.white),
                            height: 60,
                            borderRadius: 35,
                            text: Strings.add, onTap: () async {
                          print('add');

                          if (formKey.currentState!.validate())
                            insertCartDetails();
                        }),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: 5.marginAll(),
                        child: CustomButton(context,
                            height: 60,
                            textStyle: TextStyle(
                                fontSize: 16, color: colorPrimary),
                            borderRadius: 35,
                            isBorder: true,
                            text: Strings.pay, onTap: () async {
                          print('pay');

                          if (formKey.currentState!.validate()) {
                            var cardModal = CardModal(
                              rowId: "23asd",
                              cardNumber:
                                  controller.cardNumber.value.toString(),
                              expiryDate:
                                  controller.expiryDate.value.toString(),
                              cardHolderName:
                                  controller.cardHolderName.value,
                              cvvCode: controller.cvvCode.value.toString(),
                            );

                            PayStackPayment().callPaymentFunction(
                              dataString: widget.dataString,
                                cateringId: widget.cateringID,
                                from: widget.from,
                                placeOrderData: widget.placeOrderData,
                                modal: cardModal,
                                amount: widget.price,
                                context: context);
                          }
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget showTopWidget() {
    return Row(
      children: [
        backButton().pressBack(),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: Strings.addCard,
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    controller.cardNumber.value = creditCardModel!.cardNumber;
    controller.expiryDate.value = creditCardModel.expiryDate;
    controller.cardHolderName.value = creditCardModel.cardHolderName;
    controller.cvvCode.value = creditCardModel.cvvCode;
    controller.isCvvFocused.value = creditCardModel.isCvvFocused;
  }

  void insertCartDetails() {
    var uuid = Uuid();

    var rowId = uuid.v1();

    print('RowId' + rowId);

    Box<CardModal> cartBox = Hive.box<CardModal>('card');
    var cardModal = CardModal(
      rowId: rowId,
      cardNumber: controller.cardNumber.value.toString(),
      expiryDate: controller.expiryDate.value.toString(),
      cardHolderName: controller.cardHolderName.value,
      cvvCode: controller.cvvCode.value.toString(),
    );

    cartBox.add(cardModal);
    Strings.cardSuccess.toast();
    Get.back();

    print('fetchCartData_Map' + cartBox.values.toString());
  }
}
