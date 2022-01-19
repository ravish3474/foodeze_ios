import 'dart:async';
import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/base/network/UserRepository.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/CustomTextField.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/OrderChatController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomePage.dart';

class OrderChatWidget extends StatefulWidget {
  String orderId;
  String rider_user_id;
  String from;

//  0=customer(right mesg)
  //1=rider(left msg)

  OrderChatWidget(this.orderId,this.rider_user_id,this.from);

  @override
  _OrderChatWidgetState createState() => _OrderChatWidgetState();
}

class _OrderChatWidgetState extends State<OrderChatWidget> {
  ScrollController _scrollController = new ScrollController();

  OrderChatController orderChatController = Get.put(OrderChatController());

  String userId = "";

  String profileImg = "";
  Timer? timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Strings.riderChatRunning=true;

    _refreshData();

  }


  void _refreshData() async {
    print('_refreshData_called'+" "+widget.orderId+" "+widget.rider_user_id);
    orderChatController.loading.value = true;
    var data = await orderChatController.fetchOrderChatAPI(widget.orderId);
    if (mounted) {
      orderChatController.loading.value = false;
    }
  }

  fetchViewTicketChatAPI(){
    orderChatController.fetchOrderChatAPI(widget.orderId);
  }



  void addChatToTicketAPI(String message) async {


    //orderChatController.sendCustomerToRiderChatAPI(userId,"riderId",widget.orderId,"fromcus", message);
    orderChatController.sendCustomerToRiderChatAPI(customerId: userId, riderId: widget.rider_user_id, orderId: widget.orderId, fromCustomer: "0", message: message);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print('disposeCalled');

    Strings.riderChatRunning=false;

    cancelTimer();
  }

  void cancelTimer() {
    Strings.ChatWindowCLosed = true;

    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    Strings.ChatWindowCLosed = false;
    var _mediaQueryData = MediaQuery.of(context);

    if (!Strings.ChatWindowCLosed) {
      timer = Timer.periodic(
          Duration(seconds: 3),
          (Timer t) => {
                //print('TImer_Running' + Strings.ChatWindowCLosed.toString()),
                if (!Strings.ChatWindowCLosed) fetchViewTicketChatAPI()
              });
    }

    getUserIdLocal();

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          cancelTimer();

          if(widget.from==Strings.notification)
            HomePage("").navigate(isRemove: true);

          else
            Get.back();



          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16.0),
            )),
            backgroundColor: Colors.white,
            leading: Center(
              child: GestureDetector(
                  onTap: () {
                    cancelTimer();

                    if(widget.from==Strings.notification)
                      HomePage("").navigate(isRemove: true);

                    else
                      Get.back();


                  },
                  child: backButton()),
            ),
            title: Row(
              children: [
                Image.asset(Images.profile_image,
                    width: 45, height: 45, fit: BoxFit.fill),
                16.verticalSpace(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Strings.chatRider,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black)),
                    /* Text(
                      'Typing..',
                      style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.39)),
                    ),*/
                  ],
                ),
              ],
            ),
          ),
          body: GetX<OrderChatController>(
              init: OrderChatController(),
              builder: (controller) {
                return DeclarativeRefreshIndicator(
                  refreshing: orderChatController.loading.value,
                  onRefresh: _refreshData,
                  child: Container(
                      child: Column(children: [
                    16.horizontalSpace(),
                    Expanded(
                      child: controller.chatList.length != 0
                          ? Container(
                              padding: 16.paddingVertical(),
                              child: CustomList(
                                  scrollController: _scrollController,
                                  list: controller.chatList,
                                  child: (data, index) {
                                    // return  showMessages(index);

                                    return orderChatController
                                        .chatList[index].fromCustomer ==
                                        "0"
                                        ? rightMessage(index)
                                        : leftMessage(index);
                                  },
                                  shrinkWrap: true),
                            )
                          : orderChatController.noDataFound.value
                              ? noDataFoundWidget(_mediaQueryData.size.height,
                                  Images.error_image, "No Chat Found", false)
                              : Container(),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 4, bottom: 4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 0.5),
                              blurRadius: 1.5,
                            )
                          ]),
                      child: CustomTextField(
                        controller: controller.chatFeildController,
                        activeSufix: Images.send,
                        inActiveSufix: Images.send,
                        onSufficTap: () {
                          var message =
                              controller.chatFeildController.getValue();
                          if (message.isNotEmpty) {
                            controller.updateChatList(
                                message: message, userID: userId);
                            addChatToTicketAPI(message);
                            hideKeyboard(context);

                            controller.chatFeildController.clear();

                            if (_scrollController.hasClients)
                              _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent + 2,
                              duration: Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                            );
                          }
                        },
                        hint: 'Type a message . . .',
                        hintStyle: GoogleFonts.poppins(
                            color: Color(0xff7D7D7D), fontSize: 15),
                      ),
                    ),
                  ])),
                );
              }),
        ),
      ),
    );
  }

  leftMessage(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customCircleImageView(
            margin: 0.marginAll(), image: Images.profile_image),
        12.verticalSpace(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: Color(0xffB2B2B2).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  orderChatController.chatList[index].message!,
                  style: GoogleFonts.poppins(),
                ),
              ),
              4.horizontalSpace(),
              Row(
                children: [
                  8.verticalSpace(),
                  Text(
                    convertDate(orderChatController.chatList[index].chatTime!),
                    style:
                        GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(
                    Icons.done_all,
                    size: 12,
                    color: Colors.grey,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  rightMessage(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: colorPrimary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  orderChatController.chatList[index].message!,
                  maxLines: null,
                  style: GoogleFonts.poppins(),
                ),
              ),
              4.horizontalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  8.verticalSpace(),
                  Text(
                    convertDate(orderChatController.chatList[index].chatTime!).toString(),
                    style:
                        GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(
                    Icons.done_all,
                    size: 12,
                    color: Colors.grey,
                  )
                ],
              ),
            ],
          ),
        ),
        12.verticalSpace(),
        showUsrPic(),
      ],
    );
  }

  showUsrPic() {
    return Container(
        width: 40,
        height: 40,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover, image: new NetworkImage(profileImg))));
  }

  showMessages(int index) async {
    if (orderChatController.chatList[index].customerId == userId)
      return rightMessage(index);
    else
      return leftMessage(index);
  }

  Future<void> getUserIdLocal() async {
    var user = await getUser();

    userId = user!.msg!.id!;
    profileImg = ApiEndpoint.IMAGE_URL + user.msg!.profileImg!;
  }
}
