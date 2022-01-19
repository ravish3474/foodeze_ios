import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/EventDetailsController.dart';
import 'package:foodeze_flutter/controller/FetchCateringController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/EventHistoryModal.dart';
import 'package:foodeze_flutter/modal/EventModal.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';

import 'AddCardScreen.dart';
import 'PayStackPayment.dart';
import 'ShowImage.dart';

class EventDetailsScreen extends StatefulWidget {
  EventDatum modal;
//late EventDatumMy modal2;
String from='';
//String data='';

  EventDetailsScreen(this.modal,this.from);

 // EventDetailsScreen.namedConst(this.modal2);

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  EventDetailsController controller = Get.put(EventDetailsController());
  FetchCateringController cateringController = Get.put(FetchCateringController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    // widget.modal.quantity="3";

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ShowUp(
          child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                    height: screenHeight(context) * 0.86,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          showTopWidget(widget.modal.event_title!),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              20.horizontalSpace(),
                              showKitchenImage(),
                              10.horizontalSpace(),
                              showStartDateAndTime(),
                              10.horizontalSpace(),
                              showItemText(Images.startMenuIcon, "Start Menu ",
                                  widget.modal.event_starter!, 15),
                              10.horizontalSpace(),
                              showItemText(
                                  Images.mainCourseIcon,
                                  "Main Course: ",
                                  widget.modal.main_course!,
                                  1),
                              10.horizontalSpace(),
                              showItemText(Images.drinksIcons, "Drinks ",
                                  widget.modal.drinks!, 1),
                              10.horizontalSpace(),
                              showItemText(Images.desertIcon, "Dessert ",
                                  widget.modal.desert!, 1),
                              10.horizontalSpace(),
                              showItemText(
                                  Images.quantityIcon,
                                  "Availability Left ",
                                  widget.modal.quantity!,
                                  1),
                              10.horizontalSpace(),
                              showItemText(Images.priceIcon,
                                  "Price Per Person ", "R "+widget.modal.price!, 1),
                              10.horizontalSpace(),
                              showItemText(Images.locationIcon, "Location ",
                                  widget.modal.location!, 1),
                              10.horizontalSpace(),
                              showItemText(Images.locationIcon, "Province ",
                                  widget.modal.province!, 1),
                              10.horizontalSpace(),
                              showItemText(Images.locationIcon, "City ",
                                  widget.modal.city!, 1),
                              10.horizontalSpace(),
                              showItemText(
                                  Images.descriptionIcon,
                                  "Description ",
                                  widget.modal.event_description!,
                                  15)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      5.horizontalSpace(),
                      Container(
                        margin: 5.marginAll(),
                        child: CustomButton(context,
                            height: 55,
                            textStyle: TextStyle(
                                fontSize: 16, color: Colors.white),
                            borderRadius: 35,
                            text: Strings.rsvp, onTap: () async {

                          if(int.parse(widget.modal.quantity!)==0)
                            "There are no seat left".toast();
                          else
                          askToPaymentAlert();
                        }),
                      ),
                      8.horizontalSpace(),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget showTopWidget(String title) {
    return Row(
      children: [
        backButton().pressBack(),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: title,
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }

  showKitchenImage() {
    return GestureDetector(
      onTap: ()=>    ShowImage(ApiEndpoint.EVENT_URL+widget.modal.event_banner!).navigate(),

    child: Container(
        child: CachedNetworkImage(
          imageUrl: ApiEndpoint.EVENT_URL+widget.modal.event_banner!,
          imageBuilder: (context, imageProvider) {
            return categoryImageSecond(
                imageProvider, double.infinity, 180, BoxShape.rectangle);
          },
          placeholder: (context, url) {
            return Container(
              width: double.infinity,
              height: 180,
              child: CircularProgressIndicator(),
            );
          },
          errorWidget: (context, url, error) {
            return showPlaceholderImage(
                image: Images.cover_placeholder,
                width: double.infinity,
                height: 180);
          },
        ),
      ),
    );
  }

  showStartDateAndTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: colorPrimary),
            borderRadius: new BorderRadius.all(Radius.circular(5)),
          ),
          child: showTitleRichText(
              "Start Date : ", convertDate2(widget.modal.event_date!), null),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: colorPrimary),
            borderRadius: new BorderRadius.all(Radius.circular(5)),
          ),
          child: showTitleRichText(
              "Start Time : ", widget.modal.event_time!, null),
        ),
      ],
    );
  }

  showItemText(String image, String title, String subTitle, int maxLine) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorPrimary),
        borderRadius: new BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: 10.paddingAll(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                image,
                color: colorPrimary,
                height: 30,
                width: 30,
              ),
            ),
            Expanded(
              flex: 2,
              child: showText(
                  color: Colors.black,
                  text: title,
                  textSize: 16,
                  fontweight: FontWeight.w400,
                  maxlines: 1),
            ),
            Expanded(
              flex: 2,
              child: showText(
                  color: colorPrimary,
                  text: subTitle,
                  textSize: 16,
                  fontweight: FontWeight.w400,
                  maxlines: maxLine),
            ),
          ],
        ),
      ),
    );
  }

  showItemTextSecond(String title, String subTitle, int maxLine) {
    return Container(
      child: Padding(
        padding: 10.paddingAll(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            showText(
                color: Colors.black,
                text: title,
                textSize: title==Strings.totalPay?18:16,
                fontweight: title==Strings.totalPay?FontWeight.w600:FontWeight.w400,
                maxlines: 1),
            showText(
                color: colorPrimary,
                text: subTitle,
                textSize: title==Strings.totalPay?18:16,
                fontweight: title==Strings.totalPay?FontWeight.w600:FontWeight.w400,
                maxlines: maxLine),
          ],
        ),
      ),
    );
  }

  Widget showTitleRichText(
    String subTitle,
    String title,
    Color? color,
  ) {
    return Padding(
      padding: 10.paddingAll(),
      child: RichText(
        maxLines: 1,
        text: TextSpan(
          text: subTitle,
          style: TextStyle(
              color: color == null ? Colors.black : color, fontSize: 16),
          children: <TextSpan>[
            TextSpan(
                text: title,
                style: TextStyle(color: color == null ? colorPrimary : color)),
          ],
        ),
      ),
    );
  }

  askToPaymentAlert() {
    CustomDialog(context,
        widget: Container(
          height: 380,
          width: screenWidth(context),
          padding: 10.paddingAll(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Expanded(flex: 2, child: boxImage()),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          showText(
                              color: Colors.black,
                              text: widget.modal.event_title!,
                              textSize: 18,
                              fontweight: FontWeight.w400,
                              maxlines: 1),
                          20.horizontalSpace(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              showText(
                                  color: Colors.black,
                                  text: widget.modal.event_date!,
                                  textSize: 14,
                                  fontweight: FontWeight.w400,
                                  maxlines: 1),
                              showText(
                                  color: Colors.black,
                                  text: widget.modal.event_time!,
                                  textSize: 14,
                                  fontweight: FontWeight.w400,
                                  maxlines: 1),
                            ],
                          ),
                          10.horizontalSpace(),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: showText(
                                    color: Colors.black,
                                    text: widget.modal.city!,
                                    textSize: 14,
                                    fontweight: FontWeight.w400,
                                    maxlines: 1),
                              ),
                              Expanded(
                                flex: 1,
                                child: showText(
                                    color: Colors.black,
                                    text: widget.modal.location!,
                                    textSize: 14,
                                    fontweight: FontWeight.w400,
                                    maxlines: 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              showItemTextSecond("Price", "R "+widget.modal.price!, 1),
              10.horizontalSpace(),
              showItemTextSecond("Vat", "% "+widget.modal.tax!, 1),
              10.horizontalSpace(),
              showItemTextSecond("Total Pay ", "R "+getToalPay(), 1),
              10.horizontalSpace(),
              20.horizontalSpace(),



              Row(
                children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: 2.marginAll(),
                          child: CustomButton(context,
                          height: 50,
                          textStyle: TextStyle(color: colorPrimary,fontSize: 13),
                          isBorder: true,
                          text: Strings.cancel,
                          onTap: () {
                            Get.back();


                          },
                          width: screenWidth(context)),
                        ),
                      ),

                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: 2.marginAll(),
                      child: CustomButton(context,
                          height: 50,
                          textStyle: TextStyle(color: Colors.white,fontSize: 13),

                          text: Strings.advancePay,
                          onTap: () {

                        Get.back();
                        openBookingBottomSheet();

                          },
                          width: screenWidth(context)),
                    ),
                  ),
                    ],
              )
            ],
          ),
        ));
  }

  Widget boxImage() {
    return Container(
      margin: 1.marginAll(),
      child: CachedNetworkImage(
        imageUrl: ApiEndpoint.EVENT_URL +
            widget.modal.event_banner!,
        imageBuilder: (context, imageProvider) {
          return categoryImage(
              imageProvider, double.infinity, 80, BoxShape.circle);
        },
        placeholder: (context, url) {
          return Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: lightGrey,
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.5, 0.5),
                  blurRadius: 0.5,
                ),
              ],
            ),
          );
        },
        errorWidget: (context, url, error) {
          return showPlaceholderImage(
            image: Images.cover_placeholder,
            width: double.infinity,
            height: 80,
          );
        },
      ),
    );
  }

  String getToalPay() {

    double tax=int.parse(widget.modal.price!)*int.parse(widget.modal.tax!)/100;

  //  double percent=int.parse(widget.modal.price!)*int.parse(widget.modal.tax!)/100;

    return (int.parse(widget.modal.price!)+tax).toString();

  }


String getToalPayPayment() {

    double tax=int.parse(widget.modal.price!)*int.parse(widget.modal.tax!)/100;

  //  double percent=int.parse(widget.modal.price!)*int.parse(widget.modal.tax!)/100;

   double price=double.parse(widget.modal.price!);
   int  qty=controller.totalQty.value;

    print('salluQty'+controller.totalQty.value.toString());

    double res=(price+tax)*qty;



    return res.toString();

  }


  Future<void> openBookingBottomSheet() async {

    controller.totalQty.value=0;

    Future<void> future = showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return GetX<EventDetailsController>(
              builder: (controller) {
                return SingleChildScrollView(
                      primary: true,
                      child: Container(
                        margin: 20.marginTop(),
                        padding: 10.paddingAll(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            showTopWidget("Event Booking"),

                            20.horizontalSpace(),

                            showQuantity(),
                            10.horizontalSpace(),
                            showItemTextSecond("Price", "R "+widget.modal.price!, 1),
                            10.horizontalSpace(),
                            showItemTextSecond("Vat", "% "+widget.modal.tax!, 1),
                            10.horizontalSpace(),
                            showItemTextSecond(Strings.totalPay, "R "+getToalPayPayment(), 1),
                            20.horizontalSpace(),

                            CustomButton(context,
                                height: 50,
                                text: Strings.proceedPayment,
                                onTap: () {

                              if(controller.totalQty.value>int.parse(widget.modal.quantity!)) {

                               var seats=widget.modal.quantity.toString();
                               ("There are only " +seats +" seats left").toast();
                              }
                               else {
                                Get.back();

                                showCardBottomSheet(getToalPayPayment(), "1",
                                    controller.totalQty.value.toString());
                              }  },
                                width: screenWidth(context))



                          ],
                        ),
                      ));
              }
            );

          }),
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    print('closeModal');


  }

  Padding showQuantity() {
    return Padding(
      padding: 10.paddingAll(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          showText(
              color: Colors.black,
              text: "Number Of People",
              textSize: 17,
              fontweight: FontWeight.w400,
              maxlines: 1),
          Container(
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: new BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: colorPrimary,
                  offset: Offset(0.5, 0.5),
                  blurRadius: 0.5,
                ),
              ],
            ),
            height: 60,
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 130.0,
              height: 60.0,
              child: Material(
                type: MaterialType.canvas,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(20.0),
                color: colorPrimary.withOpacity(0.7),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      left: 10.0,
                      bottom: null,
                      child: GestureDetector(
                          onTap: () {
                            if(controller.totalQty.value>0) {
                              controller.totalQty.value -= 1;
                              print('minus_clicked' + controller.totalQty.value
                                  .toString());
                            }


                          },
                          child: Icon(Icons.remove,
                              size: 30.0, color: Color(0xFF6D72FF))),
                    ),
                    Positioned(
                        right: 10.0,
                        top: null,
                        child: GestureDetector(
                          onTap: () {
                            controller.totalQty.value+=1;
                            print('plus_clicked'+controller.totalQty.value.toString());




                          },
                          child: Icon(Icons.add,
                              size: 30.0, color: Color(0xFF6D72FF)),
                        )),
                    GestureDetector(
                      child: Material(
                        color: lightGrey,
                        shape: const CircleBorder(),
                        elevation: 5.0,
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  child: child, scale: animation);
                            },
                            child: Text(
                              controller.totalQty.value.toString(),
                              style: TextStyle(
                                  color: Color(0xFF6D72FF), fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  showCardBottomSheet(String price, String id,String totalQty) async {
    print('cadcalled');
    cateringController.fetchCardDataOfCard();

    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) =>
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return GetX<FetchCateringController>(builder: (controller) {
                  return SingleChildScrollView(
                      child: Container(
                        margin: 10.marginTop(),
                        padding: 20.paddingBootom(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [showCardsList(price,id,totalQty)],
                        ),
                      ));
                });
              }),
    );
  }


  Widget showCardsList(String price, String id, String totalQty) {
    //vertical list
    return Container(
      padding: 5.paddingAll(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showAllCardTop(price,id),
          10.horizontalSpace(),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: cateringController.cardList.length,
            itemBuilder: (_, i) {

              return Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  margin: 5.marginAll(),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.5, 0.5),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  padding: 10.paddingAll(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async{

                            Get.back();

                            print('evetnid'+widget.modal.id!);

                            List<String>dataString=[];
                            dataString.add(widget.modal.id!);
                            dataString.add(await getUserId());
                            dataString.add(totalQty);
                            dataString.add(widget.modal.restaurent_id!);
                            dataString.add("1");

                            PayStackPayment().callPaymentFunction(dataString:dataString,cateringId:id,from: Strings.event,placeOrderData: null, modal: cateringController.cardList[i], amount: double.parse(price),context: context);





                          },
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: showText(
                                        color: Colors.black,
                                        text: cateringController.cardList[i].cardNumber
                                            .toString(),
                                        textSize: 20,
                                        fontweight: FontWeight.w400,
                                        maxlines: 1),
                                  ),
                                ),
                                15.verticalSpace(),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      cateringController.deleteParticularItemOfCard(
                                          cateringController.cardList[i].rowId!, i);
                                    },
                                    child: Image.asset(
                                      Images.delete_icon,
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 16,
              );
            },
          ),
        ],
      ),
    );
  }
  showAllCardTop(String price, String id) {
    return Container(
      padding: 4.paddingAll(),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: showText(
                  color: Colors.black,
                  text: "All Cards",
                  textSize: 20,
                  fontweight: FontWeight.w400,
                  maxlines: 1),
            ),
          ),
          15.verticalSpace(),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () async {
                Get.back();


                List<String>dataString=[];
                dataString.add(widget.modal.id!);
                dataString.add(await getUserId());
                dataString.add(controller.totalQty.value.toString());
                dataString.add(widget.modal.restaurent_id!);
                dataString.add("1");



                AddCardScreen(dataString,id,Strings.event,null,double.parse(price)).navigate();

              },
              child: Padding(
                padding: 5.paddingAll(),
                child: Image.asset(
                  Images.addIcon,
                  height: 35,
                  width: 35,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
