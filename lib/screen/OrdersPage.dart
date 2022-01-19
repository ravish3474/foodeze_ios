import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/OrderHistoryController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/screen/order_status.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool dataFound = false;

  OrderHistoryController controller = Get.put(OrderHistoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('called__Second');


    _refreshData();

  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _refreshData() async {
    print('_refreshData_called');

    controller.loading.value=true;
    var data=await controller.fetchAllOrderApi(await getUserId());
    if(mounted)
      controller.loading.value=false;

  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body:  GetX<OrderHistoryController>(builder: (controller) {
          return DeclarativeRefreshIndicator(
              refreshing: controller.loading.value,
              onRefresh: _refreshData,
              child:  SingleChildScrollView(
                child: Container(
                    padding: 10.paddingAll(),
                    color: Colors.white,
                    child: ShowUp(
                        child: Column(children: [
                          showTopWidget(),
                          20.horizontalSpace(),
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
    var _mediaQueryData = MediaQuery.of(context);
    if (controller.orderList.value.status == null ||
        controller.orderList.value.status == "0") {
      if (controller.noDataFound.value)
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (ctx, index) {
            return noDataFoundWidget(_mediaQueryData.size.height*.8,
                Images.error_image, Strings.noOrderHistory,false);
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
        list: controller.orderList.value.data!,
        child: (data, i) {
          return Material(
            child: InkWell(
              splashColor: colorPrimary,

              onTap: () => {OrderStatus(controller.orderList.value.data![i].customerOrderId!,controller.orderList.value.data![i].restaurantId!,Strings.orderStatus).navigate()},
              child: Card(


                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                child: Padding(
                  padding: 5.paddingAll(),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.all(Radius.circular(15)),
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
                            Expanded(flex: 1, child: boxImage()),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      showNotificationTitle(i),
                                      20.horizontalSpace(),
                                      showTotalAmount(i),
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
            ),
          );
        });
  }

  Widget showNotificationTitle(int i) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 0, left: 6.0),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: RichText(
                maxLines: 2,
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  children: <TextSpan>[
                    TextSpan(
                        text: "#" + controller.orderList.value.data![i].customerOrderId!+" ",
                        style: TextStyle(color:colorPrimary)),
                  ],
                  text: "Order id ",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget showTotalAmount(int i) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 0, left: 6.0),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: RichText(
                maxLines: 2,
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  children: <TextSpan>[
                    TextSpan(
                        text: "R " + controller.orderList.value.data![i].price!+" ",
                        style: TextStyle(color:colorPrimary)),
                  ],
                  text: "Total Amount ",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }




  Widget showTitle(String title) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 0, left: 6.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: showText(
                color: Colors.black,
                text: title,
                textSize: 16,
                fontweight: FontWeight.w400,
                maxlines: 2)),
      ),
    );
  }


  Widget boxImage() {
    return Container(
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
        height: 70,
        child:
        Padding(padding: 2.paddingAll(), child: Image.asset(Images.logo2)));
  }




   showTopWidget() {
    return Align(
          alignment: Alignment.center,
          child: showText(
              color: Colors.black,
              text: " Order History",
              textSize: 20,
              fontweight: FontWeight.w400,
              maxlines: 1),
        );

  }

  /* showCreateChatButton() {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      child: Visibility(
        visible: controller.noDataFound.value,
        child: CustomButton(context,
            height: 50,
            isBorder: true,
            borderColor: colorPrimary,
            textStyle: TextStyle(fontSize: 16, color: colorPrimary),
            borderRadius: 10,
            text: Strings.creatNewEvent,
            onTap: () async {}),
      ),
    );
  }*/

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
}
