import 'package:cached_network_image/cached_network_image.dart';
import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/EventHistoryController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';

import 'EventDetailsScreen.dart';

class EventHistory extends StatefulWidget {
  @override
  _EventHistoryState createState() => _EventHistoryState();
}

class _EventHistoryState extends State<EventHistory> {
  bool msgFound = false;

  EventHistoryController controller = Get.put(EventHistoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshmsg();

  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _refreshmsg() async {
    print('_refreshmsg_called');

    controller.loading.value=true;
    var msg=await controller.fetchAllEvents(await getUserId());
    if(mounted)
      controller.loading.value=false;

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
            child  :backButton().pressBack(result:"kaif"),
          ),
          title:Text(
              " Event History",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w400
            ),
          ),

        ),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body:  GetX<EventHistoryController>(builder: (controller) {
            return DeclarativeRefreshIndicator(
              refreshing: controller.loading.value,
              onRefresh: _refreshmsg,
              child:  SingleChildScrollView(
                  child: Container(
                      padding: 10.paddingAll(),
                      color: Colors.white,
                      child: ShowUp(
                          child: Column(children: [
                       // showTopWidget(),
                        40.horizontalSpace(),
                        //showCreateChatButton(),
                        getList()
                      ]))),
                )

            );
          }
        ),
      ),
    );
  }


  Widget getList() {
    var _mediaQuerymsg = MediaQuery.of(context);
    if (controller.eventsList.value.status == null ||
        controller.eventsList.value.status == "0") {
      if (controller.noDataFound.value)
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (ctx, index) {
            return noDataFoundWidget(_mediaQuerymsg.size.height*.8,
                Images.error_image, Strings.noEventHistory,false);
          },
        );
      else
        return Container(
          height: 100,
        );
    } else {
      return Container(child: showList());
    }
  }


  Widget showList() {



    return CustomList(
        shrinkWrap: true,
        axis: Axis.vertical,
        list: controller.eventsList.value.msg!,
        child: (msg, i) {
          return GestureDetector(
              onTap: ()=>showDetailBottomSheet(i),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              child: Padding(
                padding: 5.paddingAll(),
                child: Container(
                  height: 110,
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
                                height: 110,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    showTitle(controller.eventsList.value.msg![i].event_title!, 14, colorPrimary,Alignment.topLeft),
                                    5.horizontalSpace(),
                                    showTitle(convertDate2(controller.eventsList.value.msg![i].event_date!), 12, Colors.black54,Alignment.topLeft),
                                    5.horizontalSpace(),
                                    showTitle(controller.eventsList.value.msg![i].event_time!, 12, Colors.black54,Alignment.topLeft),
                                    5.horizontalSpace(),

                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 3,
                              child: Container(
                                height: 110,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    showTitleRichText("Location : ", controller.eventsList.value.msg![i].location!,null),
                                    5.horizontalSpace(),
                                    showTitleRichText("Id : ", controller.eventsList.value.msg![i].transaction_id!,null),
                                    5.horizontalSpace(),
                                    showTitleRichText(
                                        "Seats : ",
                                        controller.eventsList.value.msg![i]
                                            .no_of_person!,
                                        null),

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

  Widget boxImage(int i) {
    return Container(
      margin: 1.marginAll(),
      child: CachedNetworkImage(
        imageUrl:ApiEndpoint.EVENT_URL +
            controller.eventsList.value.msg![i].event_banner!,
        imageBuilder: (context, imageProvider) {
          return categoryImage(
              imageProvider, double.infinity, 90, BoxShape.circle);
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
          style: TextStyle(color: color==null?Colors.black:color, fontSize: 12),
          children: <TextSpan>[
            TextSpan(text: title, style: TextStyle(color: color==null?colorPrimary:color)),
          ],
        ),
      ),
    );
  }





  Row showTopWidget() {
    return Row(
      children: [
        backButton().pressBack(result:"kaif"),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: " Event History",
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }


  Widget showEnterSubjectTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff707070)),
          borderRadius: BorderRadius.circular(12)),
      child: TextField(
        keyboardType: TextInputType.name,
        maxLines: 1,
        controller: controller.subjectController,
        decoration: InputDecoration(
          hintText: Strings.enterSubject,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  showDetailBottomSheet(int i) {
    CustomDialog(context,
        widget: Container(
          height: 480,
          width: screenWidth(context),
          padding: 10.paddingAll(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Expanded(flex: 2, child: boxImage(i)),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          showText(
                              color: Colors.black,
                              text: controller.eventsList.value.msg![i].event_title!,
                              textSize: 18,
                              fontweight: FontWeight.w400,
                              maxlines: 1),
                          20.horizontalSpace(),
                          showText(
                              color: Colors.black,
                              text: controller.eventsList.value.msg![i].event_date!,
                              textSize: 14,
                              fontweight: FontWeight.w400,
                              maxlines: 1),
                          20.horizontalSpace(),
                          showText(
                              color: Colors.black,
                              text: controller.eventsList.value.msg![i].event_time!,
                              textSize: 14,
                              fontweight: FontWeight.w400,
                              maxlines: 1),
                          10.horizontalSpace(),

                        ],
                      ),
                    ),
                  ),

                  Expanded(flex:2,child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [


                      showItemTextSecond("No. of person:", controller.eventsList.value.msg![i].no_of_person!, 1),
                      showItemTextSecond("Amount:", controller.eventsList.value.msg![i].price!, 1),
                      showItemTextSecond("Success", "", 1),

                      showText(
                          color: Colors.black,
                          text: controller.eventsList.value.msg![i].city!,
                          textSize: 14,
                          fontweight: FontWeight.w400,
                          maxlines: 1),
                      showText(
                          color: Colors.black,
                          text: controller.eventsList.value.msg![i].location!,
                          textSize: 14,
                          fontweight: FontWeight.w400,
                          maxlines: 1),
                    ],
                  ),)
                ],
              ),

      Align(
        alignment: Alignment.topLeft,
        child:  showText(
                  color: Colors.black,
                  text: "Event Starter:",
                  textSize: 16,
                  fontweight: FontWeight.w400,
                  maxlines: 1)),

               3.horizontalSpace(),
      Align(
        alignment: Alignment.topLeft,
        child:showText(
                  color: colorPrimary,
                  text: controller.eventsList.value.msg![i].event_starter!,
                  textSize: 14,
                  fontweight: FontWeight.w400,
                  maxlines: 2)),
              3.horizontalSpace(),

      Align(
        alignment: Alignment.topLeft,
        child: showText(
                  color: Colors.black,
                  text: "Main Course:",
                  textSize: 16,
                  fontweight: FontWeight.w400,
                  maxlines: 1)),

               3.horizontalSpace(),
      Align(
        alignment: Alignment.topLeft,
        child: showText(
                  color: colorPrimary,
                  text: controller.eventsList.value.msg![i].main_course!,
                  textSize: 14,
                  fontweight: FontWeight.w400,
                  maxlines: 2)),


                3.horizontalSpace(),

      Align(
        alignment: Alignment.topLeft,
        child:  showText(
                  color: Colors.black,
                  text: "Event Deserts:",
                  textSize: 16,
                  fontweight: FontWeight.w400,
                  maxlines: 1)),

               3.horizontalSpace(),
      Align(
        alignment: Alignment.topLeft,
        child:  showText(
                  color: colorPrimary,
                  text: controller.eventsList.value.msg![i].desert!,
                  textSize: 14,
                  fontweight: FontWeight.w400,
                  maxlines: 2)),

                 3.horizontalSpace(),

                  Align(
                  alignment: Alignment.topLeft,
                    child: showText(
                    color: Colors.black,
                    text: "Event Drinks:",
                    textSize: 16,
                    fontweight: FontWeight.w400,
                    maxlines: 1),
                  ),

               3.horizontalSpace(),
      Align(
        alignment: Alignment.topLeft,
        child:showText(
                  color: colorPrimary,
                  text: controller.eventsList.value.msg![i].drinks!,
                  textSize: 14,
                  fontweight: FontWeight.w400,
                  maxlines: 2)),



              20.horizontalSpace(),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                        CustomButton(context,
                        height: 55,
                        textStyle: TextStyle(
                            fontSize: 16, color: Colors.white),
                        borderRadius: 35,
                        text: "Ok", onTap: () async {

                        Get.back();
                        }),
                      ],
                ),
              )




            ],
          ),
        ));
  }

  showItemTextSecond(String title, String subTitle, int maxLine) {
    return Row(
      children: [
        showText(
            color: Colors.black,
            text: title,
            textSize:14,
            fontweight:FontWeight.w400,
            maxlines: 1),
        Expanded(
          child: showText(
              color: colorPrimary,
              text: subTitle,
              textSize: 14,
              fontweight: FontWeight.w400,
              maxlines: maxLine),
        ),
      ],
    );
  }


}
