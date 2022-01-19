import 'package:cached_network_image/cached_network_image.dart';
import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/EventController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/screen/EventDetailsScreen.dart';
import 'package:foodeze_flutter/screen/EventHistory.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  bool dataFound = false;

  EventController controller = Get.put(EventController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('called__Fourth');

    _refreshData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _refreshData() async {
    print('_refreshData_called');
    controller.loading.value = true;

    var data = await controller.fetchAllEvents();

    if (mounted) controller.loading.value = false;
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
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: GetX<EventController>(builder: (controller) {
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
                        20.horizontalSpace(),
                        //showCreateChatButton(),
                        getList(),
                      ]))),
                ));
          }),
        ),
      ),
    );
  }

  Widget getList() {
    var _mediaQueryData = MediaQuery.of(context);
    if (controller.eventsList.value.status == null ||
        controller.eventsList.value.status == "0") {
      if (controller.noDataFound.value)
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          physics: BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            return index == 0
                ? noDataFoundWidget(_mediaQueryData.size.height,
                    Images.error_image, Strings.noEventFound, false)
                : Container(
                    height: 50,
                  );
          },
        );
      else
        return Container(
          color: Colors.white,
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
        list: controller.eventsList.value.data!,
        child: (data, i) {
          return GestureDetector(
            onTap: () {},
            child: GestureDetector(
              onTap: ()=>EventDetailsScreen(controller.eventsList.value.data![i],Strings.event).navigate(),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                child: Padding(
                  padding: 5.paddingAll(),
                  child: Container(
                    height: 100,
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
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      showTitle(
                                          controller.eventsList.value.data![i]
                                              .event_title!,
                                          14,
                                          colorPrimary,
                                          Alignment.topLeft),
                                      5.horizontalSpace(),
                                      showTitle(
                                          convertDate2(controller.eventsList.value.data![i]
                                              .event_date!),
                                          12,
                                          Colors.black54,
                                          Alignment.topLeft),
                                      5.horizontalSpace(),
                                      showTitle(
                                          controller.eventsList.value.data![i]
                                              .event_time!,
                                          12,
                                          Colors.black54,
                                          Alignment.topLeft),
                                      5.horizontalSpace(),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      showTitleRichText(
                                          "Location : ",
                                          controller.eventsList.value.data![i]
                                              .location!,
                                          null),
                                      5.horizontalSpace(),

                                      showTitleRichText(
                                          "Tax : ",
                                          "R " +
                                              controller
                                                  .eventsList.value.data![i].tax!,
                                          null),
                                      5.horizontalSpace(),
                                      showTitleRichText(
                                          "Seats : ",
                                          controller.eventsList.value.data![i]
                                              .quantity!,
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
            ),
          );
        });
  }

  Widget boxImage(int i) {
    return Container(
      margin: 1.marginAll(),
      child: CachedNetworkImage(
        imageUrl:ApiEndpoint.EVENT_URL +
            controller.eventsList.value.data![i].event_banner!,
        imageBuilder: (context, imageProvider) {
          return categoryImage(
              imageProvider, double.infinity, 80, BoxShape.circle);
        },
        placeholder: (context, url) {
          return Container(
            width:double.infinity,
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
            width:double.infinity,
            height: 80,);
        },
      ),
    );
  }

  Widget showTitle(
      String title, double size, Color color, Alignment alignment) {
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
          style: TextStyle(
              color: color == null ? Colors.black : color, fontSize: 12),
          children: <TextSpan>[
            TextSpan(
                text: title,
                style: TextStyle(color: color == null ? colorPrimary : color)),
          ],
        ),
      ),
    );
  }

  Row showTopWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 3,
          child: showText(
              color: Colors.black,
              text: " Event",
              textSize: 20,
              fontweight: FontWeight.w400,
              maxlines: 1),
        ),
        Expanded(
          flex: 1,
          child: CustomButton(context,
              width: 20,
              height: 50,
              isBorder: true,
              borderColor: colorPrimary,
              textStyle: TextStyle(fontSize: 16, color: colorPrimary),
              borderRadius: 10,
              text: "My Event", onTap: () async {
            EventHistory().navigate();
          }),
        )
      ],
    );
  }
}
