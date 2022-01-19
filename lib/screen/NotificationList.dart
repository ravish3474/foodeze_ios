import 'package:cached_network_image/cached_network_image.dart';
import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/controller/ProfileDetailController.dart';
import 'package:foodeze_flutter/controller/NotificationController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/NotificationModal.dart';
import 'package:foodeze_flutter/screen/HomePage.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';


class NotificationList extends StatefulWidget {


  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
 

  NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

_refreshData();


  }


  void _refreshData()  async {
    print('_refreshData_called');

    controller.loading.value=true;
    var notificationData = await controller.fetchNotificationAPI();
    //print('notidata'+notificationData.data!.length.toString());
    if(mounted)
      controller.loading.value=false;

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: ()async{

          Get.back();
          return    true;

        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GetX<NotificationController>(
            builder: (controller) {
              return DeclarativeRefreshIndicator(
                refreshing: controller.loading.value,
                onRefresh: _refreshData,
                child:  SingleChildScrollView(
                    child: Container(
                        padding: 10.paddingAll(),
                        color: Colors.white,
                        child: ShowUp(child: Column(children: [showTopWidget(), getList()]))),
                  )

              );
            }
          ),
        ),
      ),
    );
  }

  Widget getList() {
    var _mediaQueryData = MediaQuery.of(context);
    if (controller.notificatinList.value.status == null ||
        controller.notificatinList.value.status == "0") {
      if (controller.noDataFound.value)
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (ctx, index) {
            return noDataFoundWidget(_mediaQueryData.size.height, Images.error_image,
                "No Notification Found",false);
          },
        );
      else
        return Container(height: 100,);
    } else {
      return Container(margin: 20.marginTop(), child: showList());
    }
  }

  Widget showList() {
    return CustomList(
        shrinkWrap: true,
        axis: Axis.vertical,
        list: controller.notificatinList.value.data!,
        child: (data, i) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            child: Padding(
              padding: 5.paddingAll(),
              child: Container(
                height: 120,
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
                            flex: 3,
                            child: Container(
                              height: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  showNotificationTitle(i),
                                  5.horizontalSpace(),
                                  showDate(i),

                                ],
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget showNotificationTitle(int i) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 0, left: 3.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: showText(
                color: Colors.black,
                text: controller.notificatinList.value.data![i].notification!,
                textSize: 16,
                fontweight: FontWeight.w400,
                maxlines: 3)),
      ),
    );
  }



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
  }

  Widget boxImage(int i) {

   return  Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.5, 0.5),
              blurRadius: 0.5,
            ),
          ],
        ),
        width: double.infinity,
        height: 100,
        child: Padding(
            padding: 2.paddingAll(),
            child: Image.asset(Images.logo2)));
  }



  Row showTopWidget() {
    return Row(
      children: [
        backButton().pressBack(),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: " Notifications",
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }
}
