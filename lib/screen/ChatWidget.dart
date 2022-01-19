import 'dart:async';

import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/base/network/UserRepository.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/CustomTextField.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/ChatController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

//minus 3.30 time

class ChatWidget extends StatefulWidget {
  String ticketId;

  ChatWidget(this.ticketId);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  ScrollController _scrollController = new ScrollController();

  ChatController chatController = Get.put(ChatController());

  String userId = "";

  String profileImg = "";
  Timer? timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData();

  }
  void _refreshData() async {
    print('_refreshData_called');
    chatController.loading.value = true;
    var data = await chatController.fetchViewTicketChatAPI(widget.ticketId);
    if (mounted) {
      chatController.loading.value = false;
    }
  }

  fetchViewTicketChatAPI(){
    chatController.fetchViewTicketChatAPI(widget.ticketId);
  }



  void addChatToTicketAPI(String message) async {
    chatController.addChatToTicketAPI(widget.ticketId, userId, message);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print('disposeCalled');

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
                print('TImer_Running' + Strings.ChatWindowCLosed.toString()),
                if (!Strings.ChatWindowCLosed) fetchViewTicketChatAPI()
              });
    }

    getUserIdLocal();

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          cancelTimer();

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
                    Text(Strings.adminChat,
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
          body: GetX<ChatController>(
              init: ChatController(),
              builder: (controller) {
                return DeclarativeRefreshIndicator(
                  refreshing: chatController.loading.value,
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

                                    return chatController
                                                .chatList[index].fromCustomer=="1"
                                        ? rightMessage(index)
                                        : leftMessage(index);
                                  },
                                  shrinkWrap: true),
                            )
                          : chatController.noDataFound.value
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
                  chatController.chatList[index].message!,
                  style: GoogleFonts.poppins(),
                ),
              ),
              4.horizontalSpace(),
              Row(
                children: [
                  8.verticalSpace(),
                  Text(
                    convertDate(chatController.chatList[index].chatTime!),
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
                  chatController.chatList[index].message!,
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
                    convertDate(chatController.chatList[index].chatTime!),
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
    if (chatController.chatList[index].customerId == userId)
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
