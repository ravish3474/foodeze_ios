import 'package:cached_network_image/cached_network_image.dart';
import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/FetchCateringController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/ViewCateringDetails.dart';
import 'package:foodeze_flutter/screen/AddCateringRequest.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AddCardScreen.dart';
import 'PayStackPayment.dart';

class FetchCateringRequests extends StatefulWidget {
  @override
  _FetchCateringRequestsState createState() => _FetchCateringRequestsState();
}

class _FetchCateringRequestsState extends State<FetchCateringRequests> {
  FetchCateringController controller = Get.put(FetchCateringController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshData();
  }

  void _refreshData() async {
    print('_refreshData_called');

    controller.loading.value = true;
    var notificationData =
        await controller.fetchCateringRequestAPI(await getUserId());
    //print('notidata'+notificationData.data!.length.toString());
    if (mounted) controller.loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: backButton().pressBack(),
          ),
          title:Text(
            Strings.catering,
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w400
            ),
          ),

        ),
        backgroundColor: Colors.white,
        body: GetX<FetchCateringController>(builder: (controller) {
          return DeclarativeRefreshIndicator(
              refreshing: controller.loading.value,
              onRefresh: _refreshData,
              child: Column(
                children: [
                  Container(
                      height: screenHeight(context) * .80,
                      margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                      child: SingleChildScrollView(
                        child: ShowUp(
                            child: Column(
                                children: [

                                 // showTopWidget(),

                                  getList()])),
                      )),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 55,
                          margin: 5.marginAll(),
                          child: CustomButton(context,
                              height: 55,
                              textStyle:
                                  TextStyle(fontSize: 16, color: Colors.white),
                              borderRadius: 35,
                              text: Strings.cateringReq, onTap: () async {
                          var result=await   AddCateringRequest().navigate(isAwait:true);
                          print('BackFromAddCatering'+result);
                            if(result=="1")
                            _refreshData();

                          }),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        }),
      ),
    );
  }

  Widget getList() {
    var _mediaQueryData = MediaQuery.of(context);
    if (controller.fetchCateringReqData.value.status == null ||
        controller.fetchCateringReqData.value.status == "0") {
      if (controller.noDataFound.value)
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (ctx, index) {
            return noDataFoundWidget(_mediaQueryData.size.height,
                Images.error_image, "No Catering Request Found", false);
          },
        );
      else
        return Container(
          height: 100,
        );
    } else {
      return Container(margin: 20.marginTop(), child: showList());
    }
  }

  Widget showList() {
    return CustomList(
        shrinkWrap: true,
        axis: Axis.vertical,
        list: controller.fetchCateringReqData.value.data!,
        child: (data, i) {
          return GestureDetector(
            onTap: (){

              fetchCateringDetails(controller.fetchCateringReqData.value.data![i].id,controller.fetchCateringReqData.value.data![i].restaurantId,);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              child: Padding(
                padding: 5.paddingAll(),
                child: Container(
                  height: 145,
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: boxImage(i)),
                          SizedBox(width: 10),
                          Expanded(
                              flex: 2,
                              child: Container(
                                height: 130,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    showTitle(
                                        controller.fetchCateringReqData.value
                                                .data![i].eventTitle!
                                                .substring(0, 1)
                                                .toUpperCase() +
                                            controller.fetchCateringReqData.value
                                                .data![i].eventTitle!
                                                .substring(
                                                    1,
                                                    controller
                                                        .fetchCateringReqData
                                                        .value
                                                        .data![i]
                                                        .eventTitle!
                                                        .length),
                                        16,
                                        colorPrimary,Alignment.topLeft),
                                    5.horizontalSpace(),
                                    showTitle(
                                        controller.fetchCateringReqData.value
                                            .data![i].deliveryDateTime!,
                                        14,
                                        Colors.black54,Alignment.topLeft),
                                    5.horizontalSpace(),
                                    showPendingorPaYNowButton(controller
                                        .fetchCateringReqData
                                        .value
                                        .data![i]
                                        .status!,i),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 4,
                              child: Container(
                                height: 130,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    showTitleRichText(
                                      "Tax : ",
                                      "R " +
                                          controller.fetchCateringReqData.value
                                              .data![i].tax!,null
                                    ),
                                    showTitleRichText(
                                        "Delivery Fee : ",
                                        controller.fetchCateringReqData.value
                                                    .data![i].deliveryFee ==
                                                null
                                            ? "Empty"
                                            : "R " +
                                                controller.fetchCateringReqData
                                                    .value.data![i].deliveryFee,null),
                                    showTitleRichText(
                                        "Subtotal : ",
                                        "R " +
                                            double.parse(controller.fetchCateringReqData.value
                                                .data![i].subTotal!).toPrecision(2).toString(),null),
                                    showTitleRichText(
                                        "Total : ",
                                        "R " +
                                            double.parse(controller.fetchCateringReqData.value
                                                .data![i].price!).toPrecision(2).toString(),null),
                                    showTitleRichText(
                                        "Time : ",
                                        controller.fetchCateringReqData.value
                                            .data![i].duration!,null),
                                    showDeleteIcon(i),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget showTitle(String title, double size, Color color,Alignment alignment) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 0, left: 3.0),
        child: Align(
            alignment: alignment,
            child: showText(
                color: color,
                text: title,
                textSize: size,
                fontweight: FontWeight.w600,
                maxlines: 1)),
      ),
    );
  }

  Widget showTitleRichText(
    String subTitle,
    String title,
      Color? color,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 5),
      child: RichText(
        maxLines: 1,
        text: TextSpan(
          text: subTitle,
          style: TextStyle(color: color==null?Colors.black:color, fontSize: 14),
          children: <TextSpan>[
            TextSpan(text: title, style: TextStyle(color: color==null?colorPrimary:color)),
          ],
        ),
      ),
    );
  }

/*



  Widget showDate(int i) {


    return Container(
        child: Padding(
      padding: EdgeInsets.only(top: 2, left: 0.0),
      child: Row(

        children: [
          Expanded(
            flex: 1,
            child: Icon(
              Icons.calendar_today_outlined,
              color: colorPrimary,
              size: 20,
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: showText(
                  color: Colors.black,
                  text: convertDate(controller.notificatinList.value.data![i].created!),
                  textSize: 16,
                  fontweight: FontWeight.w300,
                  maxlines: 1),
            ),
          ),
        ],
      ),
    ));
  }*/

  Widget boxImage(int i) {
    return Container(
      margin: 1.marginAll(),
      child:CachedNetworkImage(
        imageUrl:ApiEndpoint.CATERING_MENU_ITEM_URL_2 +
            controller.fetchCateringReqData.value.data![i].image!,
        imageBuilder: (context, imageProvider) {
          return categoryImage(
              imageProvider, double.infinity, 100, BoxShape.circle);
        },
        placeholder: (context, url) {
          return Container(
            width:double.infinity,
            height: 100,
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
          return showPlaceholderCircleImage();


        },
      ),
    );
  }



  Row showTopWidget() {
    return Row(
      children: [
        backButton().pressBack(),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: Strings.catering,
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }

  showPendingorPaYNowButton(String status, int i) {
    return CustomButton(context,
        height: 30,
        width: 70,
        borderColor: getButtonColor(status),
        isBorder: true,
        textStyle: TextStyle(fontSize: 12, color: getButtonColor(status)),
        onTap: () {

      print('welcome');

      if (status == "3")
        {


          showCardBottomSheet(controller.fetchCateringReqData.value
              .data![i].price!,controller.fetchCateringReqData.value
              .data![i].id!);

        }


    }, borderRadius: 10, text: getStringButton(status));
  }


  showCardBottomSheet(String price, String id) async {
    controller.fetchCardDataOfCard();

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
                          children: [showCardsList(price,id)],
                        ),
                      ));
                });
              }),
    );
  }

  Widget showCardsList(String price, String id) {
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
            itemCount: controller.cardList.length,
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

                            PayStackPayment().callPaymentFunction(  dataString: null,cateringId:id,from: "catering",placeOrderData: null, modal: controller.cardList[i], amount: double.parse(price),context: context);

                          },
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: showText(
                                        color: Colors.black,
                                        text: controller.cardList[i].cardNumber
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
                                      controller.deleteParticularItemOfCard(
                                          controller.cardList[i].rowId!, i);
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




                AddCardScreen(null,id,Strings.catering,null,double.parse(price)).navigate();

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

  getStringButton(String status) {
    if (status == "1")
      return Strings.pending;
    else if (status == "2")
      return Strings.completed;
    else if (status == "3")
      return Strings.payNow;
    else if (status == "4")
      return Strings.rejected;
    else if (status == "5")
      return Strings.scheduled;
  }

  getButtonColor(status) {
    if (status == "1")
      return colorAccent;
    else if (status == "2")
      return color1;
    else if (status == "3")
      return colorPrimary;
    else if (status == "4")
      return Colors.red;
    else if (status == "5") return color1;
  }

  showDeleteIcon(int i) {
    return GestureDetector(
      onTap: () {
        askToDelete(context, i);
      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: 5.paddingRight(),
            child: Image.asset(
              Images.delete_icon,
              height: 25,
              width: 25,
            )),
      ),
    );
  }

  askToDelete(context, int i) {
    CustomDialog(context,
        widget: Container(
          padding: 20.paddingAll(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Strings.appName,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 30.0,
                      color: Colors.black.withOpacity(0.47))),
              16.horizontalSpace(),
              Image.asset(
                Images.error_image,
                height: 100,
              ),
              30.horizontalSpace(),
              Text(
                'Are you sure want to delete catering item?',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.47)),
                textAlign: TextAlign.center,
              ),
              30.horizontalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(context, height: 50, text: 'No', isBorder: true,
                      onTap: () {
                    pressBack();
                  }, width: screenWidth(context) / 2.8),
                  CustomButton(context, height: 50, text: 'Yes', onTap: () {


                    controller.deleteCateringAPI(i,controller.fetchCateringReqData.value.data![i].id!);



                    print('afterLength'+controller.fetchCateringReqData.value.data!.toString());



                    Get.back();
                  }, width: screenWidth(context) / 2.8)
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> fetchCateringDetails(String? id, String? restaurantId) async {

    print('kaidId'+id!);
    print('restaurantId'+restaurantId!);


    launchProgress(context: context);
    ViewCateringDetails data = await controller.fetchCateringDetailsAPI(id,restaurantId);
    print('viewData'+data.toString());
    print('viewData222'+data.msg!.length.toString());

    disposeProgress();


    showViewDetailsBottomSheet(data.msg![0].cateringOrderMenuItem);

  }




  Future<void>? showViewDetailsBottomSheet(List<CateringOrderMenuItem>? list) {

    Future<void> future = showModalBottomSheet(
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
            return  SingleChildScrollView(
                  primary: true,
                  child: Container(
                    margin: 20.marginTop(),
                    padding: 20.paddingBootom(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        showExtraList(list)],


                    ),
                  ));

          }),
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    print('closeModal');
  }

  Widget showExtraList(List<CateringOrderMenuItem>? list) {
    //vertical list
    return Padding(
      padding: 3.paddingAll(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Align(
              child: showTitle(
                  Strings.viewCatOrder,
                  18,
                  Colors.black87,Alignment.center),
            ),
          ),
          Divider(
            thickness: 1.5,
            height: 6,
          ),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: list!.length,
            itemBuilder: (_, i) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                   showTitle(
                  Strings.cateringMenuItem,
                  16,
                  colorPrimary,Alignment.center),
                        showTitleRichText(
                          "Item Name : ", list[i].name!,
                            null ), showTitleRichText(
                          "Item Quantity : ", list[i].quantity!,
                        null), showTitleRichText(
                          "Item Price : ", "R "+double.parse(list[i].price!).toPrecision(2).toString(),
                        null),




                    _horizontalListViewBottom(list[i].cateringOrderMenuExtraItem),
                    5.horizontalSpace(),
                  ]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 10,
              );
            },
          ),

        ],
      ),
    );
  }



  Widget _horizontalListViewBottom(List<CateringOrderMenuExtraItem>? list) {
    //controller.selectedItems.clear();

    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: list!.length,
      scrollDirection: Axis.vertical,
      /*itemBuilder: (data_,index) =>_buildBox(color: colorPrimary),*/
      itemBuilder: (_, i) {
        return Padding(
          padding: 0.paddingAll(),
          child: Container(

            decoration: BoxDecoration(
              color: colorPrimary,
              gradient:  LinearGradient(
                  colors: [
                    colorSecondPrimary,
                    colorPrimary,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp)
                  ,
              border:
             Border.all(color: colorSecondPrimary) ,
              borderRadius: new BorderRadius.all(Radius.circular(10)),
              boxShadow:
                  [
                BoxShadow(
                  color: colorPrimary,
                  offset: Offset(0, 3),
                  blurRadius: 15,
                ),
              ]
                  ,
            ),

            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                showTitleRichText(
                  "Name : ", list[i].name!,Colors.white
                ), showTitleRichText(
                  "Quantity : ", list[i].quantity!,Colors.white
                ), showTitleRichText(
                  "Price : ", "R "+double.parse(list[i].price!).toPrecision(2).toString(),Colors.white
                )

              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 3,
        );
      },
    );
  }



}
