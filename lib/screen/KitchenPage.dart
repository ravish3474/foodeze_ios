import 'package:cached_network_image/cached_network_image.dart';
import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/CustomTextField.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/AuthController.dart';
import 'package:foodeze_flutter/controller/KitchenController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/screen/FetchCateringRequests.dart';
import 'package:foodeze_flutter/screen/SearchRestaurant.dart';
import 'package:foodeze_flutter/screen/ShowRestrauListByCat.dart';
import 'package:foodeze_flutter/screen/ShowVirtualKitchen.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ShowImage.dart';
import 'map_screen.dart';

class KitchenPage extends StatefulWidget {
  @override
  _KitchenPageState createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
  FocusNode messageFocus = FocusNode();

  AuthController controller = Get.find();

  KitchenController kitchenController = Get.put(KitchenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();

    print('called__First');

    if (controller.addressName.value.isEmpty) {
      print('IfInitCalled');

      //"IFRun".toast();

      try {
        takeLocation();
      } catch (e) {
        print('FirstException');
      }
    } else {
      // "elseRun".toast();
      print('elseInitCalled');

      _refreshData();
    }
  }

  Future<void> init() async {
    await Future.delayed(Duration(milliseconds: 200));
  }

  Future _refreshData() async {
    print('kitchen_referesh_called' +
        " " +
        controller.latitude.value +
        " " +
        controller.longitude.value);

    callKitchenAPI(controller.latitude.value, controller.longitude.value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: GetX<KitchenController>(builder: (KitchenController) {
            return DeclarativeRefreshIndicator(
              onRefresh: _refreshData,
              refreshing: kitchenController.loading.value,
              child: SingleChildScrollView(
                child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        showTopWidget(),


                        kitchenController.kithcenData.value != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  kitchenController.kithcenData.value.curfew_status!="1"?



                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [


                                      //show all products categories
                                      kitchenController.kithcenData.value
                                          .categories !=
                                          null &&
                                          kitchenController.kithcenData.value
                                              .categories!.isNotEmpty
                                          ? Column(
                                        children: [
                                          searchWidget(),
                                          headingWidget(Strings.allProducts),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: 120,
                                              child: allProductsList()),
                                        ],
                                      )
                                          : Container(),

                                      //show virtual kitchen promote list
                                      kitchenController
                                          .kithcenData.value.promoted !=
                                          null &&
                                          kitchenController.kithcenData.value
                                              .promoted!.isNotEmpty
                                          ? Column(
                                        children: [
                                          headingWidget(
                                              Strings.virtualKithenPromote),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: 170,
                                              child:
                                              virtualKitchenPromoteList()),
                                        ],
                                      )
                                          : Container(),

                                      //show virtual kitchen new you  list
                                      kitchenController.kithcenData.value
                                          .virtualKitchen !=
                                          null &&
                                          kitchenController.kithcenData.value
                                              .virtualKitchen!.isNotEmpty
                                          ? Column(
                                        children: [
                                          headingWidget(
                                              Strings.virtualKithcennearYou),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: 170,
                                              child:
                                              virtualKitchenNearYouList()),
                                        ],
                                      )
                                          : Container(),

                                      //show whats new   list
                                      kitchenController.kithcenData.value.sliders !=
                                          null &&
                                          kitchenController.kithcenData.value
                                              .sliders!.isNotEmpty
                                          ? Column(
                                        children: [
                                          headingWidget(Strings.whatsNew),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: 128,
                                              child: showSlidersList()),
                                        ],
                                      )
                                          : Container(),

                                      //show favourite    list
                                      kitchenController.kithcenData.value
                                          .favouriteRestaurant !=
                                          null &&
                                          kitchenController.kithcenData.value
                                              .favouriteRestaurant!.isNotEmpty
                                          ? Column(
                                        children: [
                                          headingWidget(Strings.myFvrt),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: 225,
                                              child:
                                              showFavouriteRestrauList()),
                                        ],
                                      )
                                          : Container(
                                        color: Colors.blue,
                                      ),

                                      //show most popular    list
                                      kitchenController.kithcenData.value
                                          .mostPopular !=
                                          null &&
                                          kitchenController.kithcenData.value
                                              .mostPopular!.isNotEmpty
                                          ? Column(
                                        children: [
                                          headingWidget(Strings.mostPopular),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: 225,
                                              child:
                                              showMostPopularRestrauList()),
                                        ],
                                      )
                                          : Container(),


                                  ],):Container(
                                    height: screenHeight(context) * .8,
                                    child: showCurfewMessage(
                                        screenHeight(context) * .7,
                                        Images.error_image,
                                        Strings.curfewTitle,
                                        Strings.curfewSubTitle,
                                        ),
                                  ),



                                ],
                              )
                            : Container(
                                height: screenHeight(context) * .8,
                                child: noDataFoundWidget(
                                    screenHeight(context) * .7,
                                    Images.error_image,
                                    Strings.went_wrong,
                                    false),
                              ),
                      ],
                    )),
              ),
            );
          })),
    );
  }

  Widget showTopWidget() {
    return Container(
      child: Padding(
        padding: 15.paddingAll(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Icon(
                            Icons.location_pin,
                            size: 25,
                          ))),
                  Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => gotoMapScreen(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetX<AuthController>(builder: (controller) {
                              return showText(
                                  color: Colors.black,
                                  text: controller.cityName.value,
                                  textSize: 20,
                                  fontweight: FontWeight.w400,
                                  maxlines: 1);
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              FetchCateringRequests().navigate();
                            },
                            child: Image.asset(Images.plateIcon,width: 33,height: 33,),
                          )
                        ]),
                  ),
                ]),
            Padding(
              padding: 37.paddingLeft(),
              child: GetX<AuthController>(builder: (controller) {
                return GestureDetector(
                  onTap: () => gotoMapScreen(),
                  child: showText(
                      color: Colors.black,
                      text: controller.addressName.value,
                      textSize: 18,
                      fontweight: FontWeight.w300,
                      maxlines: 1),
                );
              }),
            ),
            5.horizontalSpace(),
            Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }

  searchWidget() {
    return GestureDetector(
      onTap: () {
        SearchRestaurant(controller.latitude.value,controller.longitude.value).navigate();
      },
      child: Container(
        margin: 5.marginAll(),
        child: CustomTextField(
          boarder: true,
          autofocus: false,
          enbled: false,
          onTextChanged: (query) {},
          focusNode: messageFocus,
          activePrefix: Images.search,
          inActivePrefix: Images.search,
          hint: 'Search ..',
          textStyle: GoogleFonts.poppins(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget headingWidget(String title) {
    return Padding(
      padding: 15.paddingAll(),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget? allProductsList() {
    return kitchenController.kithcenData.value.categories != null
        ? CustomList(
            shrinkWrap: false,
            axis: Axis.horizontal,
            list: kitchenController.kithcenData.value.categories!,
            child: (data, index) {
              return GestureDetector(
                onTap: () {
                  ShowRestrauListBycat(kitchenController.kithcenData.value.categories![index].cat!,controller.latitude.value,controller.longitude.value).navigate();
                },
                child: Container(
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
                  child: Column(
                    children: [
                      Card(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Container(
                          width: 55,
                          height: 55,
                          child: CachedNetworkImage(
                            imageUrl: ApiEndpoint.IMAGE_URL +
                                kitchenController.kithcenData.value
                                    .categories![index].image!,
                            imageBuilder: (context, imageProvider) {
                              return categoryImage(
                                  imageProvider, 50, 50, BoxShape.circle);
                            },
                            placeholder: (context, url) {
                              return Container(
                                width: 50,
                                height: 50,
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
                                  width: 50,
                                  height: 120);
                            },
                          ),
                        ),
                      ),
                      10.horizontalSpace(),
                      showText(
                          color: Colors.black,
                          text: kitchenController
                              .kithcenData.value.categories![index].cat!,
                          textSize: 16,
                          fontweight: FontWeight.w400,
                          maxlines: 1),
                    ],
                  ),
                ),
              );
            })
        : Container();
  }

  Widget virtualKitchenPromoteList() {
    return kitchenController.kithcenData.value.promoted != null
        ? CustomList(
            shrinkWrap: false,
            axis: Axis.horizontal,
            list: kitchenController.kithcenData.value.promoted!,
            child: (data, index) {
              return GestureDetector(
                onTap: () => ShowVirtualKitchen(kitchenController
                        .kithcenData.value.promoted![index].restaurant!.id!)
                    .navigate(),
                child: Card(
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.all(Radius.circular(2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.5, 0.5),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: ApiEndpoint.IMAGE_URL +
                              kitchenController.kithcenData.value
                                  .promoted![index].restaurant!.image!,
                          imageBuilder: (context, imageProvider) {
                            return categoryImage(
                                imageProvider, 170, 120, BoxShape.rectangle);
                          },
                          placeholder: (context, url) {
                            return Container(
                              width: 170,
                              height: 100,
                              child: showPlaceholderImage(
                                  image: Images.cover_placeholder,
                                  width: 170,
                                  height: 100),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return showPlaceholderImage(
                                image: Images.cover_placeholder,
                                width: 170,
                                height: 100);
                          },
                        ),
                        10.horizontalSpace(),
                        showText(
                            color: Colors.black,
                            text: kitchenController.kithcenData.value
                                .promoted![index].restaurant!.name!,
                            textSize: 16,
                            fontweight: FontWeight.w400,
                            maxlines: 1),
                      ],
                    ),
                  ),
                ),
              );
            })
        : Container();
  }

  Widget virtualKitchenNearYouList() {
    return kitchenController.kithcenData.value.virtualKitchen != null
        ? CustomList(
            shrinkWrap: false,
            axis: Axis.horizontal,
            list: kitchenController.kithcenData.value.virtualKitchen!,
            child: (data, index) {
              return GestureDetector(
                onTap: () => ShowVirtualKitchen(kitchenController.kithcenData
                        .value.virtualKitchen![index].restaurant!.id!)
                    .navigate(),
                child: Card(
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.all(Radius.circular(2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.5, 0.5),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: ApiEndpoint.IMAGE_URL +
                              kitchenController.kithcenData.value
                                  .virtualKitchen![index].restaurant!.image!,
                          imageBuilder: (context, imageProvider) {
                            return categoryImage(
                                imageProvider, 170, 120, BoxShape.rectangle);
                          },
                          placeholder: (context, url) {
                            return showPlaceholderImage(
                                image: Images.cover_placeholder,
                                width: 170,
                                height: 100);
                          },
                          errorWidget: (context, url, error) {
                            return showPlaceholderImage(
                                image: Images.cover_placeholder,
                                width: 170,
                                height: 100);
                          },
                        ),
                        10.horizontalSpace(),
                        showText(
                            color: Colors.black,
                            text: kitchenController.kithcenData.value
                                .virtualKitchen![index].restaurant!.name!,
                            textSize: 16,
                            fontweight: FontWeight.w400,
                            maxlines: 1),
                      ],
                    ),
                  ),
                ),
              );
            })
        : Container();
  }

  Widget showSlidersList() {
    return kitchenController.kithcenData.value.sliders != null
        ? CustomList(
            shrinkWrap: false,
            axis: Axis.horizontal,
            list: kitchenController.kithcenData.value.sliders!,
            child: (data, index) {
              return GestureDetector(
                onTap: () {
                /*  successAlert(
                      true,
                      ApiEndpoint.IMAGE_URL +
                          kitchenController
                              .kithcenData.value.sliders![index].image!,
                      context,
                      Strings.app_name,
                      Images.error_image,
                      Strings.checkInternet);*/

                  ShowImage(ApiEndpoint.IMAGE_URL +
                      kitchenController
                          .kithcenData.value.sliders![index].image!).navigate();

                },
                child: Card(
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.all(Radius.circular(2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.5, 0.5),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: ApiEndpoint.IMAGE_URL +
                              kitchenController
                                  .kithcenData.value.sliders![index].image!,
                          imageBuilder: (context, imageProvider) {
                            return categoryImage(
                                imageProvider, 170, 120, BoxShape.rectangle);
                          },
                          placeholder: (context, url) {
                            return showPlaceholderImage(
                                image: Images.cover_placeholder,
                                width: 170,
                                height: 120);
                          },
                          errorWidget: (context, url, error) {
                            return showPlaceholderImage(
                                image: Images.cover_placeholder,
                                width: 170,
                                height: 120);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
        : Container();
  }

  Widget showFavouriteRestrauList() {
    return kitchenController.kithcenData.value.favouriteRestaurant != null
        ? CustomList(
            shrinkWrap: false,
            axis: Axis.horizontal,
            list: kitchenController.kithcenData.value.favouriteRestaurant!,
            child: (data, index) {
              return GestureDetector(
                onTap: () => ShowVirtualKitchen(kitchenController.kithcenData
                        .value.favouriteRestaurant![index].restaurant!.id!)
                    .navigate(),
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.all(Radius.circular(2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.5, 0.5),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: 5.paddingAll(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              showText(
                                  color: Colors.black,
                                  text: "Best Seller",
                                  textSize: 15,
                                  fontweight: FontWeight.w300,
                                  maxlines: 1),
                              GestureDetector(
                                onTap: () async {
                                  print('favClicked');

                                  if (kitchenController
                                          .kithcenData
                                          .value
                                          .favouriteRestaurant![index]
                                          .restaurantFavourite!
                                          .favourite ==
                                      "0") Strings.addedToFav.toast();

                                  kitchenController.addFavandUnfavAPi(
                                      index,
                                      kitchenController
                                          .kithcenData
                                          .value
                                          .favouriteRestaurant![index]
                                          .restaurant!
                                          .id!,
                                      await getUserId());
                                },
                                child: Image.asset(
                                  kitchenController
                                              .kithcenData
                                              .value
                                              .favouriteRestaurant![index]
                                              .restaurantFavourite!
                                              .favourite ==
                                          "1"
                                      ? Images.like_icon
                                      : Images.unlike_icon,
                                  width: 30,
                                  height: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                        CachedNetworkImage(
                          imageUrl: ApiEndpoint.IMAGE_URL +
                              kitchenController
                                  .kithcenData
                                  .value
                                  .favouriteRestaurant![index]
                                  .restaurant!
                                  .image!,
                          imageBuilder: (context, imageProvider) {
                            return categoryImageSecond(
                                imageProvider, 170, 80, BoxShape.rectangle);
                          },
                          placeholder: (context, url) {
                            return showPlaceholderImage(
                                image: Images.cover_placeholder,
                                width: 170,
                                height: 80);
                          },
                          errorWidget: (context, url, error) {
                            return showPlaceholderImage(
                                image: Images.cover_placeholder,
                                width: 170,
                                height: 80);
                          },
                        ),
                        Padding(
                            padding: 2.paddingAll(),
                            child: Align(
                              alignment: Alignment.center,
                              child: showText(
                                  color: Colors.black,
                                  text: kitchenController
                                      .kithcenData
                                      .value
                                      .favouriteRestaurant![index]
                                      .restaurant!
                                      .name!,
                                  textSize: 16,
                                  fontweight: FontWeight.w400,
                                  maxlines: 1),
                            )),
                        5.horizontalSpace(),
                        Padding(
                          padding: 6.paddingAll(),
                          child: CustomButton(context,
                              height: 35,
                              isBorder: true,
                              textStyle:
                                  TextStyle(fontSize: 15, color: colorPrimary),
                              onTap: () {
                            ShowVirtualKitchen(kitchenController
                                    .kithcenData
                                    .value
                                    .favouriteRestaurant![index]
                                    .restaurant!
                                    .id!)
                                .navigate();
                            print('welcome');
                          }, borderRadius: 15, text: Strings.view),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
        : Container();
  }

  Widget showMostPopularRestrauList() {
    return kitchenController.kithcenData.value.mostPopular != null
        ? CustomList(
            shrinkWrap: false,
            axis: Axis.horizontal,
            list: kitchenController.kithcenData.value.mostPopular!,
            child: (data, index) {
              return GestureDetector(
                onTap: () {
                  try {
                    ShowVirtualKitchen(kitchenController
                            .kithcenData.value.mostPopular![index].restoId)
                        .navigate();
                  } catch (e) {
                    //  e.toString().toast();
                  }
                },
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.all(Radius.circular(2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.5, 0.5),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: 5.paddingAll(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              showText(
                                  color: Colors.black,
                                  text: "Best Seller",
                                  textSize: 15,
                                  fontweight: FontWeight.w300,
                                  maxlines: 1),
                             /* Image.asset(
                                Images.unlike_icon,
                                width: 30,
                                height: 30,
                              )*/
                            ],
                          ),
                        ),
                        CachedNetworkImage(
                          imageUrl: ApiEndpoint.MENU_ITEM_URL +
                              kitchenController.kithcenData.value
                                  .mostPopular![index].dishImage!,
                          imageBuilder: (context, imageProvider) {
                            return categoryImageSecond(
                                imageProvider, 170, 80, BoxShape.rectangle);
                          },
                          placeholder: (context, url) {
                            return showPlaceholderImage(
                                image: Images.cover_placeholder,
                                width: 170,
                                height: 80);
                          },
                          errorWidget: (context, url, error) {
                            return showPlaceholderImage(
                                image: Images.cover_placeholder,
                                width: 170,
                                height: 80);
                          },
                        ),
                        Padding(
                            padding: 2.paddingAll(),
                            child: Align(
                              child: showText(
                                  color: Colors.black,
                                  text: kitchenController.kithcenData.value
                                      .mostPopular![index].dishName!,
                                  textSize: 16,
                                  fontweight: FontWeight.w400,
                                  maxlines: 1),
                            )),
                        Padding(
                            padding: 3.paddingLeft(),
                            child: showText(
                                color: Colors.black,
                                text: kitchenController.kithcenData.value
                                    .mostPopular![index].restoName!,
                                textSize: 14,
                                fontweight: FontWeight.w300,
                                maxlines: 1)),
                        5.horizontalSpace(),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  showText(
                                      color: colorPrimary,
                                      text: "R ",
                                      textSize: 14,
                                      fontweight: FontWeight.w700,
                                      maxlines: 1),
                                  showText(
                                      color: Colors.black,
                                      text: kitchenController.kithcenData.value
                                          .mostPopular![index].dishPrice!,
                                      textSize: 14,
                                      fontweight: FontWeight.w500,
                                      maxlines: 1),
                                ],
                              ),
                              CustomButton(context,
                                  height: 30,
                                  width: 80,
                                  isBorder: true,
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      color: colorPrimary), onTap: () {

                                      try {
                                        ShowVirtualKitchen(kitchenController
                                            .kithcenData.value.mostPopular![index].restoId)
                                            .navigate();
                                      } catch (e) {
                                        //  e.toString().toast();
                                      }




                                print('welcome');
                              }, borderRadius: 15, text: Strings.add),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
        : Container();
  }

  Future<void> takeLocation() async {
    var position = await controller.getLocation(context);
    if (position != null) {
      getLocationData(position);
    } else {
      var position = await controller.getLocation(context);
      if (position != null) {
        getLocationData(position);
      } else {
        var position = await controller.getLocation(context);
        if (position != null) getLocationData(position);
      }
    }
  }

  Future<void> getLocationData(LocationData position) async {
    var longitude = position.longitude;
    var latitude = position.latitude;
    var location = position.location;

    controller.latitude.value = latitude.toString();
    controller.longitude.value = longitude.toString();

    print(
        'getLocationCalled' + latitude.toString() + " " + longitude.toString());

    print('kaifaddress' + position.address);

    controller.updateCityAndAddressName(position.cityName, position.address);

    _refreshData();
  }

  Future<void> callKitchenAPI(String latitude, String longitude) async {
    kitchenController.loading.value = true;

    // "apicalled".toast();

    //var data = await kitchenController.fetchKitchenApi(await getUserId(), 28.6595483.toString(), 77.4501706.toString());
    var data = await kitchenController.fetchKitchenApi(await getUserId(),latitude, longitude);

    // print('kitchenDataRec'+data.categories.length.toString());

    if (mounted) kitchenController.loading.value = false;
  }

  gotoMapScreen() {
    MapScreen(double.parse(controller.latitude.value),
            double.parse(controller.longitude.value))
        .navigate();
  }
}
