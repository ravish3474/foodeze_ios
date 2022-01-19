import 'package:cached_network_image/cached_network_image.dart';
import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/controller/ProfileDetailController.dart';
import 'package:foodeze_flutter/controller/ShowRestrauByListController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/screen/HomePage.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';

import 'ShowVirtualKitchen.dart';

class ShowRestrauListBycat extends StatefulWidget {
  String category;
  /*String latitude = "28.6595483";
  String longitude = "77.4501706";*/
 String latitude = "";
  String longitude = "";

  ShowRestrauListBycat(this.category,this.latitude,this.longitude);

  @override
  _ShowRestrauListBycatState createState() => _ShowRestrauListBycatState();
}

class _ShowRestrauListBycatState extends State<ShowRestrauListBycat> {

  bool dataFound = false;

  ShowRestrauByListController controller = Get.put(ShowRestrauByListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshData();

    print('CatCalled'+controller.restauListByCat.value.status.toString());
  }


  Future _refreshData() async {
    print('_refreshData_called');
    controller.loading.value=true;

    var listData = await controller.fetchRestaurantListBYCat(widget.category.toLowerCase(), widget.latitude,  widget.longitude);
    var status = int.parse(listData.status.toString());
    if (status == 1)
      print('success');
    else
      print('failed');

    if (status == 1)
      controller.updateDataFound(false);
    else
      controller.updateDataFound(true);


    if(mounted)
      controller.loading.value=false;



  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{

        Get.back();
        return    true;

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
            widget.category + " Restaurant List",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w400
            ),
          ),

        ),
        backgroundColor: Colors.white,
        body: GetX<ShowRestrauByListController>(builder: (controller) {
            return DeclarativeRefreshIndicator(
              refreshing: controller.loading.value,
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                  child: Container(
                      padding: 10.paddingAll(),
                      color: Colors.white,
                      child: ShowUp(child: Column(children: [
                        //showTopWidget(),
                         getList()]))),
                )

            );
          }
        ),
      ),
    );
  }

  Widget getList() {
    var _mediaQueryData = MediaQuery.of(context);
    if (controller.restauListByCat.value.status == null ||
        controller.restauListByCat.value.status == "0") {
      if (controller.noDataFound.value)
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (ctx, index) {
            return noDataFoundWidget(_mediaQueryData.size.height, Images.error_image,
                "No Restaurant Found",false);
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
        list: controller.restauListByCat.value.data!,
        child: (data, i) {


          return GestureDetector(
            onTap: ()=>ShowVirtualKitchen(controller.restauListByCat.value.data![i].restaurantId!).navigate(),

            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              child: Padding(
                padding: 5.paddingAll(),
                child: Container(
                  height: 140,
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
                        children: [
                          Expanded(flex: 2, child: boxImage(i)),
                          SizedBox(width: 10),
                          Expanded(
                              flex: 3,
                              child: Container(
                                height: 140,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    showRestaurantName(i),
                                    5.horizontalSpace(),
                                    showPhoneText(i),
                                    5.horizontalSpace(),
                                    showMinOrder(i)
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

  Widget showRestaurantName(int i) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 0, left: 6.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: showText(
                color: Colors.black,
                text: controller.restauListByCat.value.data![i].restoName!,
                textSize: 20,
                fontweight: FontWeight.w400,
                maxlines: 1)),
      ),
    );
  }

  Widget showMinOrder(int i) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 6.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                showText(
                    color: Colors.black,
                    text: "Min Order ",
                    textSize: 16,
                    fontweight: FontWeight.w400,
                    maxlines: 1),
                showText(
                    color: colorPrimary,
                    text: controller
                        .restauListByCat.value.data![i].minOrderPrice!,
                    textSize: 16,
                    fontweight: FontWeight.w600,
                    maxlines: 1),
              ],
            )),
      ),
    );
  }

  Widget showPhoneText(int i) {
    return Container(
        child: Padding(
      padding: EdgeInsets.only(top: 10, left: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.phone,
            color: colorPrimary,
            size: 20,
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                child: showText(
                    color: Colors.black,
                    text: controller.restauListByCat.value.data![i].phone!,
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

  Widget boxImage(int i) {
    return Container(
      margin: 5.marginAll(),
      child: CachedNetworkImage(
        imageUrl: ApiEndpoint.IMAGE_URL +
            controller.restauListByCat.value.data![i].coverImage!,
        imageBuilder: (context, imageProvider) {
          return categoryImage(imageProvider, 140, 130, BoxShape.rectangle);
        },
        placeholder: (context, url) {
          return Container(
            width: 140,
            height: 100,
            child: CircularProgressIndicator(),
          );
        },
        errorWidget: (context, url, error) {
          return showPlaceholderImage(
              image: Images.cover_placeholder, width: 140, height: 120);
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
            text: widget.category + " Restaurant List",
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }
}
