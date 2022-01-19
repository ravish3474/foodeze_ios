import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/OrderStatusController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/OrderStatusiModal.dart';
import 'package:foodeze_flutter/screen/OrderChatWidget.dart';
import 'package:foodeze_flutter/screen/RateScreen.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';

import 'HomePage.dart';

class OrderStatus extends StatefulWidget {
  String customerOrderId;
  String from;
  String restaurantId='';

  OrderStatus(this.customerOrderId,this.restaurantId,this.from);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  OrderStatusController controller = Get.put(OrderStatusController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshData();
  }

  void _refreshData() async {
    print('_refreshData_called' + widget.customerOrderId+" "+await getUserId()+" "+widget.restaurantId);

    controller.loading.value = true;
    OrderStatusiModal notificationData = await controller.fetchOrderStatusAPI(
        widget.customerOrderId, await getUserId());
    print('OrderStatusiModal' + notificationData.status! + " riderSize_" +
        notificationData.rider!.length.toString());
    print('OrderStatuskkk' + notificationData.data!.orderStatus!);
    if (mounted) controller.loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
          onWillPop: () async {

            if(widget.from==Strings.notification)
              HomePage("").navigate(isRemove: true);

            else
            Get.back();
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: ShowUp(
              child: GetX<OrderStatusController>(builder: (controller) {
                return DeclarativeRefreshIndicator(
                  refreshing: controller.loading.value,
                  onRefresh: _refreshData,
                  child: Container(
                    height: screenHeight(context),
                    padding: 16.paddingAll(),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        showTopWidget(),
                        5.horizontalSpace(),
                        showPlaceholderImage(
                            image: Images.orderImage,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.contain),
                        20.horizontalSpace(),
                        Container(
                          margin: 7.marginAll(),
                          child: CustomButton(context,
                              height: 50,
                              isBorder: false,
                              borderColor: colorPrimary,
                              textStyle:
                              TextStyle(fontSize: 16, color: Colors.white),
                              borderRadius: 35,
                              text: Strings.placedOrder,
                              onTap: () async {}),
                        ),
                        Container(
                          margin: 7.marginAll(),
                          child: CustomButton(context,
                              height: 50,
                              isBorder: true,
                              borderColor: isEnableChat()
                                  ? colorPrimary
                                  : lightGrey,
                              textStyle:
                              TextStyle(fontSize: 16,
                                  color: isEnableChat()
                                      ? colorPrimary
                                      : lightGrey),
                              borderRadius: 35,
                              text: Strings.riderChat,
                              onTap: () async {
                            if(isEnableChat())
                                OrderChatWidget(widget.customerOrderId,controller.orderStatusData.value.rider![0].riderUserId!,Strings.orderStatus)
                                    .navigate();
                              }),
                        ),
                        Container(
                          margin: 7.marginAll(),
                          child: CustomButton(context,
                              height: 50,
                              isBorder: false,
                              borderColor: colorPrimary,
                              textStyle:
                              TextStyle(fontSize: 16, color: Colors.white),
                              borderRadius: 35,
                              text: getOrderStatus(),
                              onTap: () async {}),
                        ),
                        Container(
                          margin: 7.marginAll(),
                          child: CustomButton(context,
                              height: 50,
                              isBorder: true,
                              borderColor: isEnableVKRate()
                                  ? colorPrimary
                                  : lightGrey,
                              textStyle:
                              TextStyle(fontSize: 16, color: isEnableVKRate()
                                  ? colorPrimary
                                  : lightGrey,),
                              borderRadius: 35,
                              text: Strings.kithchenRate,
                              onTap: () async {
                               // if(isEnableVKRate())
                              String result=await   RateScreen(
                                    Strings.vk, widget.customerOrderId, widget.restaurantId)
                                    .navigate(isAwait: true);
                              print('statusRes'+result);

                              if(result=="true")
                                _refreshData();
                      }),
                        ),
                        Container(
                          margin: 7.marginAll(),
                          child: CustomButton(context,
                              height: 50,
                              isBorder: true,
                              borderColor: isEnableRate()
                              ? colorPrimary
                    : lightGrey,
                              textStyle:
                              TextStyle(fontSize: 16, color: isEnableRate()
                ? colorPrimary
                    : lightGrey,),
                              borderRadius: 35,
                              text: Strings.riderRate,
                              onTap: () async {
                          //  if(isEnableRate())

                            String result=await     RateScreen(
                                Strings.rider, widget.customerOrderId, widget.restaurantId)
                                .navigate(isAwait: true);
                            print('statusRes'+result);

                            if(result=="true")
                              _refreshData();

                              }),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ));
  }

  Widget showTopWidget() {
    return Row(
      children: [
        GestureDetector(
            onTap: (){
              if(widget.from==Strings.notification)
                HomePage("").navigate(isRemove: true);

              else
                Get.back();
            },
            child: backButton()),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: Strings.orderStatus,
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }

  getOrderStatus() {
    if (controller.orderStatusData.value.data != null) {
      print(
          'orderStatusKatrina' + controller.orderStatusData.value.data!.orderStatus!);

      if (controller.orderStatusData.value.data!.orderStatus == "0")
        return "Order is pending";
      else if (controller.orderStatusData.value.data!.orderStatus == "1")
        return "Order is accepted";
      else if (controller.orderStatusData.value.data!.orderStatus == "2")
        return "Order has been declined";
      else if (controller.orderStatusData.value.data!.orderStatus == "3")
        return "Order handed to rider";
      else if (controller.orderStatusData.value.data!.orderStatus == "Rider Accepted") {
        if (controller.orderStatusData.value.rider![0].acceptRejectStatus == "0")
          return "Rider is assigned";
        if (controller.orderStatusData.value.rider![0].acceptRejectStatus == "1")
          return "On the way to pickup";
        else
        if (controller.orderStatusData.value.rider![0].acceptRejectStatus == "2")
          return "Order collected";
        else
        if (controller.orderStatusData.value.rider![0].acceptRejectStatus == "3")
          return "Order has been arrived";
        else
        if (controller.orderStatusData.value.rider![0].acceptRejectStatus == "4") return "Order has been delivered";
      }
    }
    else {
      print('orderStatusElse');

      return "Order is pending";
    }
  }

  isEnableChat() {
    if (controller.orderStatusData.value.data != null) {
      if (controller.orderStatusData.value.data!.orderStatus == "Rider Accepted") {
        if (controller.orderStatusData.value.rider!.length > 0) {
          if(controller.orderStatusData.value.rider![0].acceptRejectStatus == "0" ||controller.orderStatusData.value.rider![0].acceptRejectStatus == "1" || controller.orderStatusData.value.rider![0].acceptRejectStatus == "2" ||controller.orderStatusData.value.rider![0].acceptRejectStatus == "3")
            return true;
        }
        else
          return false;
      }

      return false;
    }
    return false;

  }


  isEnableVKRate() {
    if (controller.orderStatusData.value.data != null) {
      if (controller.orderStatusData.value.data!.orderStatus == "Rider Accepted") {
        if (controller.orderStatusData.value.rider![0].acceptRejectStatus == "4" && controller.orderStatusData.value.rider![0].rate_vk=="0") {
          return true;
        }
        else
          return false;
      }

      return false;
    }
    return false;
  }

  isEnableRate() {
    if (controller.orderStatusData.value.data != null) {
      if (controller.orderStatusData.value.data!.orderStatus == "Rider Accepted") {
        if (controller.orderStatusData.value.rider![0].acceptRejectStatus == "4" && controller.orderStatusData.value.rider![0].rate_rider=="0") {
          return true;
        }
        else
          return false;
      }

      return false;
    }
    return false;
  }

}
