import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/CustomerChatTicketController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/CustomerTicketsModal.dart';
import 'package:foodeze_flutter/screen/ChatWidget.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomerChatTicket extends StatefulWidget {
  @override
  _CustomerChatTicketState createState() => _CustomerChatTicketState();
}

class _CustomerChatTicketState extends State<CustomerChatTicket> {
  bool dataFound = false;

  CustomerChatTicketController controller =
      Get.put(CustomerChatTicketController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callAPi();
  }

  void callAPi() async {
    if (await checkInternet()) {
      _refreshData();
    } else {
      controller.loading.value = false;
      controller.noDataFound.value = true;
      print('nonettttt');
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _refreshData() async {
    print('_refreshData_called');

    controller.loading.value = true;

    var data = await controller.fetchCustomerChatTicketsAPI(await getUserId());

    if (mounted) {
      controller.loading.value = false;
    }
  }

  void createTicketAPi(String subject) async {
    launchProgress(context: context);

    var data = await controller.createTicketApi(await getUserId(), subject);

    disposeProgress();

    if (data.status == "1") {
      successAlertSecond(context, "Ticket Successfully Created");

      controller.ticketsList.value.data!.insert(
          0,
          Datum(
              resolved: "0",
              ticketId: data.data!.ticketId,
              subject: subject,
              tickTime: getCurrentDateTime()));
      // controller.ticketsList.refresh();
    }
  }

  getCurrentDateTime() {
    var now = new DateTime.now();
    print("inputDate" + now.toString()); // 2016-01-25

    var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
    String formattedDate = formatter.format(now);
    print("salluDate" + formattedDate); // 2016-01-25

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Get.back();
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GetX<CustomerChatTicketController>(builder: (controller) {
            return DeclarativeRefreshIndicator(
                refreshing: controller.loading.value,
                onRefresh: _refreshData,
                child: SingleChildScrollView(
                  child: Container(
                      padding: 10.paddingAll(),
                      color: Colors.white,
                      child: ShowUp(
                          child: Column(children: [
                        showTopWidget(),
                        40.horizontalSpace(),
                        showCreateChatButton(),
                        getList()
                      ]))),
                ));
          }),
        ),
      ),
    );
  }

  Widget getList() {
    var _mediaQueryData = MediaQuery.of(context);
    if (controller.ticketsList.value.status == null ||
        controller.ticketsList.value.status == "0") {
      if (controller.noDataFound.value)
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (ctx, index) {
            return noDataFoundWidget(_mediaQueryData.size.height,
                Images.error_image, "No Chat Found", false);
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
        list: controller.ticketsList.value.data!,
        child: (data, i) {
          return GestureDetector(
            onTap: () => {
              if (controller.ticketsList.value.data![i].resolved == "0")
                ChatWidget(controller.ticketsList.value.data![i].ticketId!)
                    .navigate()
              else
                Strings.resolved.toast()
            },
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
                                    10.horizontalSpace(),
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
                  text: "#" + controller.ticketsList.value.data![i].ticketId!,
                  style: TextStyle(color: colorPrimary, fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                        text: "  " +
                            controller.ticketsList.value.data![i].subject!,
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.circle,
                    size: 12,
                    color: controller.ticketsList.value.data![i].resolved == "0"
                        ? Colors.green
                        : Colors.grey,
                  ),
                ],
              ),
            )
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

  Widget showDate(int i) {
    return Container(
        child: Padding(
      padding: EdgeInsets.only(top: 2, left: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            color: colorPrimary,
            size: 20,
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                child: showText(
                    color: Colors.black,
                    text: convertDate(
                        controller.ticketsList.value.data![i].tickTime!),
                    textSize: 16,
                    fontweight: FontWeight.w300,
                    maxlines: 1),
                alignment: Alignment(-52.5, -1),
              ),
            ),
          ),
        ],
      ),
    ));
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

  Row showTopWidget() {
    return Row(
      children: [
        backButton().pressBack(),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: " Admin Chat",
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }

  showCreateChatButton() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: CustomButton(context,
          height: 50,
          isBorder: true,
          borderColor: colorPrimary,
          textStyle: TextStyle(fontSize: 16, color: colorPrimary),
          borderRadius: 10,
          text: Strings.creatNewTicket, onTap: () async {
        showCreateNewTicketAlertDialoge();
      }),
    );
  }

  void showCreateNewTicketAlertDialoge() {
    controller.subjectController.text = "";

    return CustomDialog(context,
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
              Text(
                'Create Subject For Chat To Admin',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.47)),
                textAlign: TextAlign.center,
              ),
              30.horizontalSpace(),
              showEnterSubjectTextField(),
              20.horizontalSpace(),
              showAlertBothButton(),
            ],
          ),
        ));
  }

  Row showAlertBothButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: 5.marginAll(),
            child: CustomButton(context,
                height: 50,
                text: 'ADD NEW SUBJECT',
                textStyle: TextStyle(fontSize: 14, color: Colors.white),
                onTap: () async {
              if (controller.subjectController.value.text.isEmpty)
                "Please enter subject".toast();
              else {
                if (await checkInternet()) {
                  createTicketAPi(controller.subjectController.value.text);
                  pressBack();
                } else {
                  Strings.checkInternet.toast();
                  hideKeyboard(context);
                }
              }
            }, width: screenWidth(context)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: 5.marginAll(),
            child: CustomButton(context,
                height: 50,
                text: 'CANCEL',
                isBorder: true,
                textStyle: TextStyle(fontSize: 14, color: colorPrimary),
                onTap: () {
              pressBack();
            }, width: screenWidth(context)),
          ),
        ),
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
}
