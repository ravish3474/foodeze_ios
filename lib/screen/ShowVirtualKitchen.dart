import 'package:cached_network_image/cached_network_image.dart';
import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/KitchenController.dart';
import 'package:foodeze_flutter/controller/VIrtualKitchController.dart';
import 'package:foodeze_flutter/screen/AddToCartItem.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:get/get.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:readmore/readmore.dart';

import 'FetchCateringRequests.dart';
import 'ShowImage.dart';

class ShowVirtualKitchen extends StatefulWidget {

  String? restaurant_id = "";

  ShowVirtualKitchen(this.restaurant_id);

  @override
  _ShowVirtualKitchenState createState() => _ShowVirtualKitchenState();
}

class _ShowVirtualKitchenState extends State<ShowVirtualKitchen> {

  String current_time = "11:00";

  bool dataFound = false;

  VIrtualKitchController controller = Get.put(VIrtualKitchController());

  Future _refreshData() async {
    print('_refreshData_called');

    controller.loading.value=true;
   var data=await controller.fetchVirtualKitchenApi(widget.restaurant_id!, current_time);

    if(mounted)
      controller.loading.value=false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: backButton().pressBack(),
        ),
        title:Text(
          "Virtual Kitchen Near",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w400
          ),
        ),
        actions: [
          GestureDetector(
                  onTap: () {
                    FetchCateringRequests().navigate();
                  },
                  child: Image.asset(Images.plateIcon,width: 33,height: 33,),
                )
        ],
      ),
      body: GetX<VIrtualKitchController>(builder: (controller) {
          return DeclarativeRefreshIndicator(
            refreshing: controller.loading.value,
            onRefresh: _refreshData,
            child:  SingleChildScrollView(
                primary: true,
                child: ShowUp(
                  child: Container(
                    color: Colors.white,
                    child:


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //showTopWidget(),

                        controller.virtualKitchendata.value.data != null ?   Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            showKitchenImage(),
                            showRestaurantName(),
                            showRestaurantLocation(),
                            showRatingHeading(),
                            showRatingBar(),
                            showAboutKitchenHeading(),
                            showAboutDescriptioin(),
                            10.horizontalSpace(),
                            Padding(
                              padding: 10.paddingLeft(),
                              child: getList(),
                            )
                          ],
                        ):Container(height: 100),
                      ],
                    ),


                  ),
                ),
              )

          );
        }
      ),
    );
  }

  Widget getList() {
    print('NoDataFound' + controller.noDataFound.value.toString());


      if (controller.noDataFound.value)
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (ctx, index) {
            return noDataFoundWidget(250, Images.error_image,
                "No Virtual Kitchen Item Found");
          },
        );
       /* return Container(
          height: 100,
          color: Colors.red,
        );*/

     else {
      return showList();
    }
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

  Widget _horizontalListView(int index) {
    print('salllu' +
        controller.virtualKitchendata.value.data![0].restaurantMenu![index]
            .restaurantMenuItem!.length
            .toString());

    return SizedBox(
      height: 245,
      child: ListView.separated(
        itemCount: controller.virtualKitchendata.value.data![0]
            .restaurantMenu![index].restaurantMenuItem!.length,
        scrollDirection: Axis.horizontal,
        /*itemBuilder: (data_,index) =>_buildBox(color: colorPrimary),*/
        itemBuilder: (_, Horindex) {
          return GestureDetector(
            onTap: (){

              var rating = 0.0;

              if (controller.virtualKitchendata.value.rating != null)
                rating = double.parse(controller.virtualKitchendata.value.rating!).toPrecision(0);

             if(controller.virtualKitchendata.value.data![0].restaurantMenu![index].restaurantMenuItem![Horindex].outOfOrder!="1")
              AddToCartItem(
                  controller.virtualKitchendata.value.data![0].restaurant!.minOrderPrice!,
                  controller.virtualKitchendata.value.data![0].tax!.tax,
                widget.restaurant_id!,
                  controller.virtualKitchendata.value.data![0].restaurantMenu![index].restaurantMenuItem![Horindex],
                  controller.virtualKitchendata.value.data![0].mainData!.restaurantLocation!.city!,
                  rating,
                  controller.virtualKitchendata.value.data![0].restaurant!.name!,
                controller.virtualKitchendata.value.data![0].mainData!.restaurantLocation!.lat!,
                controller.virtualKitchendata.value.data![0].mainData!.restaurantLocation!.long!,
              ).navigate();

            },
            child: Card(
              elevation: 5,
              child: Container(
                width: 200,
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
                          Image.asset(
                            Images.unlike_icon,
                            width: 30,
                            height: 30,
                          )
                        ],
                      ),
                    ),
                    CachedNetworkImage(
                      imageUrl: ApiEndpoint.MENU_ITEM_URL +
                          controller.virtualKitchendata.value.data![0]
                              .restaurantMenu![index].restaurantMenuItem![Horindex].image!,
                      imageBuilder: (context, imageProvider) {
                        return categoryImageSecond(
                            imageProvider, 200, 100, BoxShape.rectangle);
                      },
                      placeholder: (context, url) {
                        return showPlaceholderImage(
                            image: Images.cover_placeholder,
                            width: 200,
                            height: 100);
                      },
                      errorWidget: (context, url, error) {
                        return showPlaceholderImage(
                            image: Images.cover_placeholder,
                            width: 200,
                            height: 100);
                      },
                    ),
                    Padding(
                        padding: 2.paddingAll(),
                        child: showText(
                            color: Colors.black,
                            text: controller
                                .virtualKitchendata
                                .value
                                .data![0]
                                .restaurantMenu![index]
                                .restaurantMenuItem![Horindex]
                                .name!,
                            textSize: 16,
                            fontweight: FontWeight.w400,
                            maxlines: 1)),
                    Padding(
                        padding: 3.paddingLeft(),
                        child: showText(
                            color: Colors.black,
                            text: controller.virtualKitchendata.value.data![0]
                                .restaurant!.name!,
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
                                  text: controller
                                      .virtualKitchendata
                                      .value
                                      .data![0]
                                      .restaurantMenu![index]
                                      .restaurantMenuItem![Horindex]
                                      .price!,
                                  textSize: 14,
                                  fontweight: FontWeight.w500,
                                  maxlines: 1),
                            ],
                          ),
                          CustomButton(context,
                              height: 30,
                              width: 100,
                              isBorder: true,
                              borderColor: controller
                                  .virtualKitchendata
                                  .value
                                  .data![0]
                                  .restaurantMenu![index]
                                  .restaurantMenuItem![Horindex]
                                  .outOfOrder=="1"?Colors.red:colorPrimary,

                              textStyle: TextStyle(fontSize: 15, color: controller
                                  .virtualKitchendata
                                  .value
                                  .data![0]
                                  .restaurantMenu![index]
                                  .restaurantMenuItem![Horindex]
                                  .outOfOrder=="1"?  Colors.red:colorPrimary ),

                              onTap: () {





                            print('welcome');
                          }, borderRadius: 15, text: controller
                                  .virtualKitchendata
                                  .value
                                  .data![0]
                                  .restaurantMenu![index]
                                  .restaurantMenuItem![Horindex]
                                  .outOfOrder=="1"? "Out of Stock": "In Stock"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 10,
          );
        },
      ),
    );
  }

  Widget showHorizontalMenuList(int index) {
    return controller.virtualKitchendata.value.data![0].restaurantMenu![index]
                .restaurantMenuItem !=
            null
        ? CustomList(
            shrinkWrap: true,
            axis: Axis.horizontal,
            list: controller.virtualKitchendata.value.data![0]
                .restaurantMenu![index].restaurantMenuItem!,
            child: (data, index) {
              return Card(
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
                            Image.asset(
                              Images.unlike_icon,
                              width: 30,
                              height: 30,
                            )
                          ],
                        ),
                      ),
                      CachedNetworkImage(
                        imageUrl: ApiEndpoint.MENU_ITEM_URL +
                            controller.virtualKitchendata.value.data![0]
                                .restaurantMenu![index].image!,
                        imageBuilder: (context, imageProvider) {
                          return categoryImageSecond(
                              imageProvider, 170, 80, BoxShape.rectangle);
                        },
                        placeholder: (context, url) {
                          return  showPlaceholderImage(
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
                          child: showText(
                              color: Colors.black,
                              text: controller.virtualKitchendata.value.data![0]
                                  .restaurantMenu![index].name!,
                              textSize: 16,
                              fontweight: FontWeight.w400,
                              maxlines: 1)),
                      Padding(
                          padding: 3.paddingLeft(),
                          child: showText(
                              color: Colors.black,
                              text: controller.virtualKitchendata.value.data![0]
                                  .restaurant!.name!,
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
                                    text: controller
                                        .virtualKitchendata
                                        .value
                                        .data![0]
                                        .restaurantMenu![index]
                                        .restaurantMenuItem![index]
                                        .price!,
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
                              print('welcome');
                            }, borderRadius: 15, text: Strings.add),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
        : Container();
  }

  Widget showTitleWidget(String title, double size) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: CustomButton(context,
          height: 40,
          width: double.infinity,
          isBorder: true,
          textStyle: TextStyle(fontSize: 15, color: colorPrimary), onTap: () {
        print('welcome');
      }, borderRadius: 10, text: title),
    );
  }

  Padding showTopWidget() {
    return Padding(
      padding: 10.paddingAll(),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: backButton().pressBack(),
            ),
            Expanded(
              flex: 7,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showText(
                        color: Colors.black,
                        text: "   Virtual Kitchen Near",
                        textSize: 20,
                        fontweight: FontWeight.w400,
                        maxlines: 1)
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                  onTap: () {
                    FetchCateringRequests().navigate();
                  },
                  child: Image.asset(Images.plateIcon,width: 33,height: 33,),
                )
              ]),
            ),
          ]),
    );
  }

  showKitchenImage() {
    var imageURl = "";

    if (controller.virtualKitchendata.value.data != null)
      imageURl = ApiEndpoint.IMAGE_URL +
          controller.virtualKitchendata.value.data![0].restaurant!.coverImage!;

    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: ()=>    ShowImage(imageURl).navigate(),
          child: Container(
            child: CachedNetworkImage(
              imageUrl: imageURl,
              imageBuilder: (context, imageProvider) {
                return categoryImage(
                    imageProvider, double.infinity, 200, BoxShape.rectangle);
              },
              placeholder: (context, url) {
                return showPlaceholderImage(
                    image: Images.cover_placeholder,
                    width: double.infinity,
                    height: 200);
              },
              errorWidget: (context, url, error) {
                return showPlaceholderImage(
                    image: Images.cover_placeholder,
                    width: double.infinity,
                    height: 200);
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 30.0, top: 170.0),
            child: Card(
              elevation: 10,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
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
                  width: 40,
                  height: 40,
                  child: GestureDetector(
                    onTap: ()async{

                      if(!controller.liked.value)
                        Strings.addedToFav.toast();


                      KitchenController().addFavandUnfavAPi(-1, widget.restaurant_id, await getUserId());
                      controller.liked.value=!controller.liked.value;


                    },
                    child: Padding(
                        padding: 5.paddingAll(),
                        child: Image.asset(controller.liked.value?   Images.like_icon: Images.unlike_icon)


                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }

  showRestaurantName() {
    var name = ".............";

    if (controller.virtualKitchendata.value.data != null)
      name = controller.virtualKitchendata.value.data![0].restaurant!.name!;

    return Padding(
      padding: 10.paddingLeft(),
      child: showText(
          color: Colors.black,
          text: name,
          textSize: 20,
          fontweight: FontWeight.w400,
          maxlines: 1),
    );
  }


 showRestaurantLocation() {
    var name = ".............";

    if (controller.virtualKitchendata.value.data != null)
      name = controller.virtualKitchendata.value.data![0].mainData!.restaurantLocation!.city!;

    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

              Image.asset(Images.location_icon,width: 25,height: 25,),
                showText(
                color: colorPrimary,
                text: name,
                textSize: 20,
                fontweight: FontWeight.w400,
                maxlines: 1),
              ],
        ),
      ),
    );
  }

  showRatingHeading() {

    var rating = 0.0;

    if (controller.virtualKitchendata.value.rating != null)
      rating = double.parse(controller.virtualKitchendata.value.rating!);


    return Padding(
      padding: EdgeInsets.only(left: 10, top: 20),
      child: showText(
          color: colorPrimary,
          text: rating.toString()+" Rating",
          textSize: 20,
          fontweight: FontWeight.w400,
          maxlines: 1),
    );
  }

  showRatingBar() {
    var rating = 0.0;

    if (controller.virtualKitchendata.value.rating != null)
      rating = double.parse(controller.virtualKitchendata.value.rating!);

    return Padding(
      padding: EdgeInsets.only(left: 10, top: 5),
      child: RatingBar.builder(
        initialRating: rating,
        minRating: 1,
        glowColor: colorPrimary,
        ignoreGestures: true,
        maxRating: 5,
        itemSize: 25,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        tapOnlyMode: false,
        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: colorPrimary,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      ),
    );
  }

  showAboutKitchenHeading() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 30),
      child: showText(
          color: Colors.black,
          text: "About Kitchen",
          textSize: 20,
          fontweight: FontWeight.w400,
          maxlines: 1),
    );
  }

  Widget showAboutDescriptioin() {
    var about = ".............";

    if (controller.virtualKitchendata.value.data != null)
      about = controller.virtualKitchendata.value.data![0].restaurant!.about!;

    return Padding(
      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
      child: ReadMoreText(
        about,
        trimLines: 3,
        colorClickableText: Colors.blue,
        trimMode: TrimMode.Line,
        trimCollapsedText: '...more',
        trimExpandedText: '  less',
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
      ),
    );
  }

  showMenuHeading() {
    return Padding(
      padding: EdgeInsets.only(left: 0, top: 20),
      child: showText(
          color: Colors.black,
          text: "Our Items",
          textSize: 20,
          fontweight: FontWeight.w400,
          maxlines: 1),
    );
  }

  Widget showList() {
    //vertical list
    if (controller.virtualKitchendata.value.data != null &&
            controller.virtualKitchendata.value.data![0].restaurantMenu != null && controller.virtualKitchendata.value.data![0].restaurantMenu!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            showMenuHeading(),
            20.horizontalSpace(),

              ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: controller
                    .virtualKitchendata.value.data![0].restaurantMenu!.length,
                itemBuilder: (_, i) {
                  return Column(children: [
                    showTitleWidget(
                        controller.virtualKitchendata.value.data![0]
                            .restaurantMenu![i].name!,
                        20),
                    10.horizontalSpace(),
                    //showHorizontalMenuList(i)
                    _horizontalListView(i),
                    10.horizontalSpace(),
                  ]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 16,
                  );
                },
              ),
            ],
        );
    } else {
      return noDataFoundWidget(250, Images.error_image,
          "No Virtual Kitchen Item Found");
    }
  }
}
