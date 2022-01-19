import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/CustomTextField.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/controller/ProfileDetailController.dart';
import 'package:foodeze_flutter/controller/SearchController.dart';
import 'package:foodeze_flutter/controller/ShowRestrauByListController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/screen/HomePage.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ShowVirtualKitchen.dart';

class SearchRestaurant extends StatefulWidget {

  //String latitude = "28.6595483";
  //String longitude = "77.4501706";
 String latitude = "";
  String longitude = "";

  SearchRestaurant(this.latitude,this.longitude);

  @override
  _SearchRestaurantState createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {

  bool dataFound = false;
  FocusNode messageFocus = FocusNode();

  SearchController controller = Get.put(SearchController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }



  void callSearchApi(String keyword) async {
    controller.fetchSearchRestaurantAPi(keyword,widget.latitude,widget.longitude);

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
          body: GetX<SearchController>(builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                  padding: 10.paddingAll(),
                  color: Colors.white,
                  child: Column(children: [showTopWidget(),showSearchView(), getList()])),
            );
          }),
        ),
      ),
    );
  }

  Widget getList() {
    var _mediaQueryData = MediaQuery.of(context);
    if (controller.searchList.value.status == null ||
        controller.searchList.value.status == "0") {
      if (controller.noDataFound.value)
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (ctx, index) {
            return noDataFoundWidget(_mediaQueryData.size.height, Images.error_image,
                "No Restaurant Found");
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
        list: controller.searchList.value.data!,
        child: (data, i) {


          return GestureDetector(
            onTap: ()=>ShowVirtualKitchen(controller.searchList.value.data![i].id!).navigate(),

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
                text: controller.searchList.value.data![i].name!,
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
                        .searchList.value.data![i].minOrderPrice!,
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
                    text: controller.searchList.value.data![i].phone!,
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
            controller.searchList.value.data![i].coverImage!,
        imageBuilder: (context, imageProvider) {
          return categoryImage(imageProvider, 140, 130, BoxShape.rectangle);
        },
        placeholder: (context, url) {
          return showPlaceholderImage(
              image: Images.cover_placeholder, width: 140, height: 120);
        },
        errorWidget: (context, url, error) {
          return showPlaceholderImage(
              image: Images.cover_placeholder, width: 140, height: 120);
        },
      ),
    );
  }

  static Widget noDataFoundWidget(
      double height, String imagePath, String errorMsg) {
    height = height - (height * 20) / 100;
    return Container(
      height: height,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                errorMsg,
                style: TextStyle(color: Colors.red, fontSize: 16),
              )
            ],
          ),
        ),
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
            text:  " Search Restaurant",
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }

  showSearchView() {
    return  Container(
      margin: EdgeInsets.only(top: 20),
      child: CustomTextField(
        boarder: true,
        autofocus: true,
        onTextChanged: (query) {
         /* var list = codes();
          var flist = list.where((a) => a.countryCode!.toUpperCase().contains(query.toUpperCase()) || a.countryName!.toUpperCase().contains(query.toUpperCase() ));
          setState(() {
            countries = flist.toList();
          });*/

          print('query'+query);
          callSearchApi(query);

        },
        focusNode: messageFocus,
        activePrefix: Images.search,
        inActivePrefix: Images.search,
        hint: 'Search ..',
        textStyle: GoogleFonts.poppins(
            fontSize: 14, color: colorPrimary, fontWeight: FontWeight.bold),
      ),
    );
  }
}
