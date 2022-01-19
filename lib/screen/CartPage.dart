import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/AuthController.dart';
import 'package:foodeze_flutter/controller/CartController.dart';
import 'package:foodeze_flutter/controller/KitchenController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/CartModal.dart';
import 'package:foodeze_flutter/modal/ExtraMenuItemModal.dart';
import 'package:foodeze_flutter/modal/MenuItemPlace.dart';
import 'package:foodeze_flutter/modal/PlaceOrder.dart';
import 'package:foodeze_flutter/screen/AddCardScreen.dart';
import 'package:foodeze_flutter/screen/PayStackPayment.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

import 'map_screen.dart';

class CartPage extends StatefulWidget {
  String from;

  CartPage(this.from);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartController controller = Get.put(CartController());
  late BuildContext globalContext;
  AuthController authController = Get.find();
  var addressId = "";
  var couponId = "";
  KitchenController kitchenController = Get.find();

  var _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('called__Third');

    _refreshData();

    print('CartScreen is inited!');
  }

  Future _refreshData() async {
    print('_refreshData_called');

    await Future.delayed(Duration(milliseconds: 200));
    print('_refreshData_called');

    List<CartModal> data = controller.fetchCartData();
  }

  @override
  Widget build(BuildContext context) {
    this.globalContext = context;

    print('checkCalled');
    return WillPopScope(
      onWillPop: () async {
        if (widget.from == "add") {
          await pressBack(result: "backed");
          return true;
        }

        return false;
      },
      child: Scaffold(

        appBar: showAppBar(),
        backgroundColor: Colors.white,
        body: GetX<CartController>(builder: (controller) {
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Container(
                        padding: 10.paddingAll(),
                        color: Colors.white,
                        child: ShowUp(
                            child:


                            kitchenController.kithcenData.value!=null?
                            kitchenController.kithcenData.value.curfew_status!="1"?
                            Column(children: [
                             // widget.from == "add" ? showTopWithBackWidget() : showTopWidget(Strings.checkout),
                             // widget.from != "add" ? showTopWithBackWidget() : showTopWidget(Strings.checkout),
                              20.horizontalSpace(),
                              showCartList(),
                            ]):Container(
                              height: screenHeight(context),
                              child: showCurfewMessage(
                                screenHeight(context) * .9,
                                Images.error_image,
                                Strings.curfewTitle,
                                Strings.curfewSubTitle,
                              ),
                            ):Container(
                              height: screenHeight(context) * .9,
                              child: noDataFoundWidget(
                                  screenHeight(context) * .8,
                                  Images.error_image,
                                  Strings.went_wrong,
                                  false),
                            ),


                        )),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  showTopWidget(String title) {
    return Align(
      alignment: Alignment.center,
      child: showText(
          color: Colors.black,
          text: title,
          textSize: 20,
          fontweight: FontWeight.w400,
          maxlines: 1),
    );
  }

  Widget showTopWithBackWidget() {
    return Row(
      children: [
        backButton().pressBack(result: "backed"),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: "Checkout",
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );


  }

  Widget showCartList() {
    print('showCartCalled' + controller.cartList.value.length.toString());

    if (controller.cartList.value.length > 0) {
      callGrandTotal("first");
    }

    if (controller.cartList.value.length > 0) {
      return CustomList(
          shrinkWrap: true,
          axis: Axis.vertical,
          list: controller.cartList.value,
          child: (data, i) {
            return Column(
              children: [
                Container(
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
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            new BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(0.5, 0.5),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(flex: 2, child: boxImage(i)),
                                  Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: 2.paddingAll(),
                                        child: Container(
                                          color: Colors.white,
                                          height: 120,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              showItemName(i),
                                              3.horizontalSpace(),
                                              showItemCategory(i),
                                              3.horizontalSpace(),
                                              showPrice(i),
                                              5.horizontalSpace(),
                                              showTotalPrice(i)
                                            ],
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                i == controller.cartList.length - 1
                    ? Container(
                  height: 20,
                )
                    : Container(),
                i == controller.cartList.length - 1
                    ? Column(
                  children: [
                    showMidLayout(),
                    showInstructionWidget(),
                    showTotalPriceLayout()
                  ],
                )
                    : Container(),
                i == controller.cartList.length - 1
                    ? Container(
                  margin: EdgeInsets.only(
                      bottom: 35, left: 10, right: 10, top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomButton(context,
                            height: 50,
                            textStyle: TextStyle(
                                fontSize: 16, color: Colors.white),
                            borderRadius: 35,
                            text: "CHECKOUT",
                            onTap: () async {


                              print('checkout'+(controller.selectedAddress.value == Strings.selectAddress).toString());

                              if (controller.selectedAddress.value == Strings.selectAddress) {
                                Strings.pleaseSelectAddress.toast();
                                return;
                              }
                              else if (double.parse(controller.grandTotal.value) < double.parse(controller.cartList[0].restaurantId!.split("kaif")[1])) {
                                "Minimum order more than "+controller.cartList[0].restaurantId!.split("kaif")[1].toast();
                                return;
                              }
                              else
                              showCardBottomSheet();
                            }),
                      ),
                    ],
                  ),
                )
                    : Container(),
              ],
            );
          });
    } else {
      return showNoCartDataFound();
    }
  }

  Future<void> callGrandTotal(String from) async {
    print('build_draw');
    //  await Future.delayed(Duration(milliseconds: 1));

    getGrandTotal();
  }

  Widget showItemName(int i) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: showText(
              color: Colors.black,
              text: controller.cartList[i].name!,
              textSize: 16,
              fontweight: FontWeight.w500,
              maxlines: 1),
        ),
        Expanded(
          flex: 1,
          child: /*showDeleteIcon(i)*/Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [showAddDeleteButton(controller.cartList[i].quantity!,i)]),
        )
      ],
    );
  }

  Widget showItemCategory(int i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showText(
            color: Colors.black,
            text: controller.cartList.value[i].restaurantName!,
            textSize: 14,
            fontweight: FontWeight.w300,
            maxlines: 1),
      ],
    );
  }

  Widget showTotalPrice(int i) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: 5.paddingTop(),
          child: RichText(
            maxLines: 1,
            text: TextSpan(
              text: "Total  ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: getTotalPrice(i).toString(),
                    style: TextStyle(color: colorPrimary)),
              ],
            ),
          ),
        ),
        Expanded(child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            controller.cartList[i].extraItemList!=null?   Container(
              width:100,
              child: CustomButton(context,
                  height: 35,
                  textStyle: TextStyle(
                      fontSize: 14, color: Colors.white),
                  borderRadius: 35,
                  text: "View Item",
                  onTap: () async {

                    showExtraItemBottomSheet(i);

                  }),
            ):Container()


        ],))


      ],
    );
  }

  Widget showPrice(int i) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: showText(
              color: colorPrimary,
              text: "Item " +
                  controller.cartList.value[i].price! +
                  " * " +
                  controller.cartList.value[i].quantity!,
              textSize: 14,
              fontweight: FontWeight.w500,
              maxlines: 1),
        ),
        Expanded(
          flex: 1,
          child: showText(
              color: colorPrimary,
              text: "Extra item: " + getTotalExtraItemPrice(i).toString(),
              textSize: 14,
              fontweight: FontWeight.w500,
              maxlines: 1),
        ),
      ],
    );
  }

  Widget boxImage(int i) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: CachedNetworkImage(
        imageUrl:
        ApiEndpoint.MENU_ITEM_URL + controller.cartList.value[i].image!,
        imageBuilder: (context, imageProvider) {
          return categoryImageSecond(
              imageProvider, double.infinity, 90, BoxShape.rectangle);
        },
        placeholder: (context, url) {
          return showPlaceholderImage(
            image: Images.cover_placeholder,
            width: double.infinity,
            height: 90,
          );
        },
        errorWidget: (context, url, error) {
          return showPlaceholderImage(
              image: Images.cover_placeholder,
              width: double.infinity,
              height: 90);
        },
      ),
    );
  }

  showDeleteIcon(int i) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          print('delete');

          // callGrandTotal("second");
          controller.deleteParticularItem(controller.cartList[i].rowId!, i);
        },
        child: Image.asset(
          Images.delete_icon,
          height: 25,
          width: 25,
        ),
      ),
    );
  }

  int getTotalExtraItemPrice(int i) {
    var totalExtraItemPrice = 0;

    List<ExtraMenuItemModal>? extraList = controller.cartList.value[i].extraItemList;

    if (extraList != null) {
      for (int i = 0; i < extraList.length; i++) {
        totalExtraItemPrice += int.parse(extraList[i].price!);
      }

      if(int.parse(controller.cartList.value[i].quantity!)>1)
        totalExtraItemPrice=totalExtraItemPrice*int.parse(controller.cartList.value[i].quantity!);
    }

    return totalExtraItemPrice;
  }

  showNoCartDataFound() {
    var _mediaQueryData = MediaQuery.of(context);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: 2,
      itemBuilder: (ctx, index) {
        return index == 0
            ? noDataFoundWidget(_mediaQueryData.size.height, Images.error_image,
            Strings.noCartItem, false)
            : Container(
          height: 50,
        );
      },
    );
  }

  showMidLayout() {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: 5.paddingAll(),
          child: Container(
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
            child: GetX<CartController>(builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showHomePickupButton(),
                  2.horizontalSpace(),
                  controller.isEnableHomeDel.value
                      ? Column(
                    children: [
                      showSelectAddress(),
                      showRiderTipDropDown(),
                      3.horizontalSpace(),
                    ],
                  )
                      : Container(
                    height: 20,
                  ),
                  showCouponWidget()
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  showHomePickupButton() {
    print('isEnablDel' + controller.isEnableHomeDel.value.toString());
    print('isEnablPick' + controller.isEnablePickup.value.toString());

    return GetX<CartController>(builder: (controller) {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: 3.marginAll(),
              child: CustomButton(context,
                  height: 45,
                  isBorder: controller.isEnableHomeDel.value ? false : true,
                  borderColor: controller.isEnableHomeDel.value
                      ? Colors.white
                      : colorPrimary,
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: controller.isEnableHomeDel.value
                          ? colorWhite
                          : colorPrimary),
                  borderRadius: 35,
                  text: Strings.homeDel,
                  onTap: () async {
                    controller.isEnableHomeDel.value = true;
                    controller.isEnablePickup.value = false;

                    print(
                        'delClicked' +
                            controller.isEnableHomeDel.value.toString());
                  }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: 3.marginAll(),
              child: CustomButton(context,
                  height: 45,
                  isBorder: controller.isEnablePickup.value ? false : true,
                  borderColor: controller.isEnablePickup.value
                      ? Colors.white
                      : colorPrimary,
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: controller.isEnablePickup.value
                          ? Colors.white
                          : colorPrimary),
                  borderRadius: 35,
                  text: Strings.pickup,
                  onTap: () async {
                    controller.isEnableHomeDel.value = false;
                    controller.isEnablePickup.value = true;

                    print(
                        'picclicked' +
                            controller.isEnablePickup.value.toString());
                  }),
            ),
          ),
        ],
      );
    });
  }

  showSelectAddress() {
    return Container(
      margin: 3.marginAll(),
      child: CustomButtonScroll(context,
          height: 52,
          isBorder: true,
          borderColor: colorPrimary,
          textStyle: TextStyle(fontSize: 16, color: colorPrimary),
          borderRadius: 35,
          text: controller.selectedAddress.value,
          onTap: () async {
            launchProgress(context: context);

           // var data = await controller.fetchAvailableLocationAPI("28.5847", "77.3159");
            var data = await controller.fetchAvailableLocationAPI(controller.cartList[0].lat!,controller.cartList[0].long!);

            print('fetchAddressAPI' + data!.status.toString());

            disposeProgress();

            if (data.status == "1")
              showFetchAdressBottomSheet();
            else if (data.status == "400")
              Strings.went_wrong.toast();
            else
              Strings.noAddress.toast();
          }),
    );
  }

  showFetchAdressBottomSheet() async {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) =>
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return GetX<CartController>(
                    builder: (controller) {
                      return SingleChildScrollView(
                          child: Container(
                            margin: 10.marginTop(),
                            padding: 20.paddingBootom(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [showAddressList()],
                            ),
                          ));
                    }
                );
              }
          ),
    );
  }


  Widget showAddressList() {
    print('addLength' + controller.addressList.length.toString());

    //vertical list
    return Padding(
      padding: 5.paddingAll(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showAllAddressTop(),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: controller.addressList.length,
            itemBuilder: (_, i) {
              return Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  margin: 5.marginAll(),
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
                  padding: 10.paddingAll(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        controller.addressList.value[i].available=="1"?showAvailableAddress(i):showNonAvailableAddress(i),
                        //i % 2 == 0 ? showAvailableAddress(i) : showNonAvailableAddress(i),

                      ]),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 16,
              );
            },
          ),
        ],
      ),
    );
  }

  // "min_order_price": "50.00",

  showAvailableAddress(int i) {
    return GestureDetector(
      onTap: () {

        controller.selectedAddress.value =
            controller.addressList[i].street! + ", " +
            controller.addressList[i].apartment! + ", " +
            controller.addressList[i].city! + ", " +
                controller.addressList[i].state! + ", " +
                controller.addressList[i].country! + ", " +
                controller.addressList[i].zip!;

        addressId = controller.addressList[i].id!;
        Get.back();

        /*print('selectedAddress'+controller.addressList[i].city!
          +", "+
          controller.addressList[i].state!
          +", "+
          controller.addressList[i].country!
          +", "+
          controller.addressList[i].zip!);*/
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showText(
              color: colorPrimary,
              text: "Available",
              textSize: 16,
              fontweight: FontWeight.w400,
              maxlines: 2),
          5.horizontalSpace(),

          showText(
              color: Colors.black,
              text:
              controller.addressList[i].street! + ", " +
              controller.addressList[i].apartment! + ", " +
              controller.addressList[i].city! + ", " +
                  controller.addressList[i].state!
                  + ", " +
                  controller.addressList[i].country!
                  + ", " +
                  controller.addressList[i].zip!,
              textSize: 16,
              fontweight: FontWeight.w400,
              maxlines: 2),
        ],
      ),
    );
  }

  showNonAvailableAddress(int i) {
    return GestureDetector(
      onTap: (){

      /*  controller.selectedAddress.value =
            controller.addressList[i].street! + ", " +
            controller.addressList[i].apartment! + ", " +
            controller.addressList[i].city! + ", " +
                controller.addressList[i].state! + ", " +
                controller.addressList[i].country! + ", " +
                controller.addressList[i].zip!;

        addressId = controller.addressList[i].id!;
        Get.back();
*/
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          showText(
              color: Colors.black,
              text:
              controller.addressList[i].street! + ", " +
                  controller.addressList[i].apartment! + ", " +
              controller.addressList[i].city!
                  + ", " +
                  controller.addressList[i].state!
                  + ", " +
                  controller.addressList[i].country!
                  + ", " +
                  controller.addressList[i].zip!,
              textSize: 16,
              fontweight: FontWeight.w400,
              maxlines: 2),
          3.horizontalSpace(),

          showText(
              color: Colors.red,
              text: "Order cannot deliver to this address",
              textSize: 14,
              fontweight: FontWeight.w400,
              maxlines: 2),
          5.horizontalSpace(),


        ],
      ),
    );
  }


  Widget showRiderTipDropDown() {
    return Container(
      margin: 7.marginAll(),
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(
          color: colorPrimary,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          iconEnabledColor: colorPrimary,
          isExpanded: true,
          hint: Center(
              child: Text(
                Strings.riderTip,
              )),
          // Not necessary for Option 1
          value: controller.riderTip.value,
          onChanged: (newValue) {
            controller.riderTip.value = newValue as String;

            getRiderTipPrice();

            if (newValue == Strings.selectKitchen)
              controller.dropDownTextStyle.value =
                  TextStyle(color: Colors.black54);
            else
              controller.dropDownTextStyle.value =
                  TextStyle(color: Colors.black);

            hideKeyboard(context);
          },
          items: getRiderTipList().map((location) {
            return DropdownMenuItem(
              child:
              new Text(location, style: controller.dropDownTextStyle.value),
              value: location,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget showCouponWidget() {
    return GetX<CartController>(
        builder: (controller) {
          return Container(
            margin: 5.marginAll(),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      height: 60,
                      margin: 5.marginRight(),
                      child: inputTextFieldWidget(
                          controller: controller.coupanController,
                          title: Strings.couponCode,
                          icon: Icon(
                              Icons.disc_full_outlined, color: colorPrimary),
                          keyboardType: TextInputType.name,
                          isEnable: true),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0)),
                        elevation: 18.0,
                        color: controller.enableApplyCouponButton.value
                            ? colorPrimary
                            : lightGrey,

                        clipBehavior: Clip.antiAlias,
                        // A
                        child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            color: controller.enableApplyCouponButton.value
                                ? colorPrimary
                                : lightGrey,
                            child: new Text(Strings.applycoupon,
                                style: new TextStyle(
                                    fontSize: 16.0, color: Colors.white)),
                            onPressed: () async {
                              if (controller.enableApplyCouponButton.value) {
                                if (controller.coupanController.value.text
                                    .toString()
                                    .isNotEmpty) {
                                  if (await checkInternet()) {
                                    hideKeyboard(context);
                                    launchProgress(context: context);
                                    var res = await controller.getCouponApi(
                                        controller.coupanController.value.text
                                            .toString());
                                    print('reskaif' + res.status!);
                                    disposeProgress();
                                    if (res.status == "1") {

                                      couponId=res.msg![0].id!;
                                      controller.enableApplyCouponButton.value = false;;

                                      callGrandTotal("first");

                                      Strings.couponCodeApplied.toast();


                                      print(
                                          'couponDis' + res.msg![0].discount!);
                                    } else
                                      Strings.couponCodeInvalid.toast();
                                  } else
                                    Strings.checkInternet.toast();
                                } else
                                  Strings.couponCodeEnter.toast();
                              }
                            }),
                      ),
                    )),
              ],
            ),
          );
        }
    );
  }

  Widget showInstructionWidget() {
    return Container(
      margin: 7.marginAll(),
      child: Container(
        height: 60,
        margin: 5.marginRight(),
        child: inputTextFieldWidget(
            controller: controller.instController,
            title: Strings.instructions,
            icon: Icon(Icons.directions, color: colorPrimary),
            keyboardType: TextInputType.multiline,
            isEnable: true),
      ),
    );
  }

  List getRiderTipList() {
    List<String> monthList = [];

    monthList.add("RIDER TIP %");
    for (int i = 1; i < 21; i++)
      monthList.add((5 * i).toString() + " %");

    return monthList;
  }

  showBottomList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (ctx, index) {
        return Column(
          children: [showMidLayout(), showInstructionWidget()],
        );
      },
    );
  }

  showTotalPriceLayout() {
    return GetX<CartController>(builder: (controller) {
      return Container(
        width: double.infinity,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: 5.paddingAll(),
            child: Container(
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showSubTotal(),
                  3.horizontalSpace(),
                  controller.isEnableHomeDel.value
                      ? Column(
                    children: [
                      showDeliveryFre(),
                      3.horizontalSpace(),
                    ],
                  )
                      : Container(),
                  showVat(),
                  3.horizontalSpace(),
                  showRiderTip(),
                  3.horizontalSpace(),
                  showDiscount(),
                  3.horizontalSpace(),
                  showTotal()
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  showSubTotal() {
    return Container(
      margin: 5.marginRight(),
      child: Row(
        children: [
          showText(
              color: Colors.black,
              text: "Sub Total",
              textSize: 16,
              fontweight: FontWeight.w400,
              maxlines: 1),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                showText(
                    color: colorPrimary,
                    text: "R "+double.parse(controller.subTotal.value).toPrecision(2).toString(),
                    textSize: 16,
                    fontweight: FontWeight.w400,
                    maxlines: 1),
              ],
            ),
          )
        ],
      ),
    );
  }

  showVat() {
    return Container(
      margin: 5.marginRight(),
      child: Row(
        children: [
          showText(
              color: Colors.black,
              text: "Vat %",
              textSize: 16,
              fontweight: FontWeight.w400,
              maxlines: 1),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                showText(
                    color: colorPrimary,
                    text: "R "+controller.vat.value,
                    textSize: 16,
                    fontweight: FontWeight.w400,
                    maxlines: 1),
              ],
            ),
          )
        ],
      ),
    );
  }

  showRiderTip() {
    return Container(
      margin: 5.marginRight(),
      child: Row(
        children: [
          showText(
              color: Colors.black,
              text: "Rider Tip",
              textSize: 16,
              fontweight: FontWeight.w400,
              maxlines: 1),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                showText(
                    color: colorPrimary,
                    text:"R "+ controller.riderTipPrice.value,
                    textSize: 16,
                    fontweight: FontWeight.w400,
                    maxlines: 1),
              ],
            ),
          )
        ],
      ),
    );
  }

  showDeliveryFre() {
    return Container(
      margin: 5.marginRight(),
      child: Row(
        children: [
          showText(
              color: Colors.black,
              text: "Delivery Fee",
              textSize: 16,
              fontweight: FontWeight.w400,
              maxlines: 1),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                showText(
                    color: colorPrimary,
                    text: "R "+controller.deliveryFee.value,
                    textSize: 16,
                    fontweight: FontWeight.w400,
                    maxlines: 1),
              ],
            ),
          )
        ],
      ),
    );
  }

  showDiscount() {
    return Container(
      margin: 5.marginRight(),
      child: Row(
        children: [
          showText(
              color: Colors.black,
              text: "Discount",
              textSize: 16,
              fontweight: FontWeight.w400,
              maxlines: 1),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                showText(
                    color: colorPrimary,
                    text: "R "+controller.discount.value,
                    textSize: 16,
                    fontweight: FontWeight.w400,
                    maxlines: 1),
              ],
            ),
          )
        ],
      ),
    );
  }

  showTotal() {
    print('kaifCalled' + controller.grandTotal.value);

    return Container(
      margin: 5.marginRight(),
      child: Row(
        children: [
          showText(
              color: Colors.black,
              text: "Total",
              textSize: 22,
              fontweight: FontWeight.w400,
              maxlines: 1),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                showText(
                    color: colorPrimary,
                    text: "R "+double.parse(controller.grandTotal.value).toPrecision(2).toString(),
                    textSize: 22,
                    fontweight: FontWeight.w400,
                    maxlines: 1),
              ],
            ),
          )
        ],
      ),
    );
  }

  /* num getSize() {
    return widget.from == "add" ? 0.88 : 0.80;
  }

  double getBottomSize() {
    return widget.from == "add" ? 15.0 : 35.0;
  }*/

  showCardBottomSheet() async {
    controller.fetchCardDataOfCard();

    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) =>
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return GetX<CartController>(builder: (controller) {
                  return SingleChildScrollView(
                      child: Container(
                        margin: 10.marginTop(),
                        padding: 20.paddingBootom(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [showList()],
                        ),
                      ));
                });
              }),
    );
  }

  Widget showList() {
    //vertical list
    return Container(
      padding: 5.paddingAll(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showAllCardTop(),
          10.horizontalSpace(),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: controller.cardList.length,
            itemBuilder: (_, i) {
              print(
                  'month' + controller.cardList[i].expiryDate!.substring(0, 2));
              print(
                  'year' + controller.cardList[i].expiryDate!.substring(3, 5));

              return Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  margin: 5.marginAll(),
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
                  padding: 10.paddingAll(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async{

                            PlaceOrderExtraItemModal placeOrderData =await  getPlaceOrderData();

                              Get.back();
                             //   PayStackPayment().callPaymentFunction(from: "cart",placeOrderData,controller.cardList[i], double.parse(controller.grandTotal.value), context);


                                PayStackPayment().callPaymentFunction(  dataString: null,cateringId:"catid",from: Strings.cart,placeOrderData: placeOrderData, modal: controller.cardList[i], amount: double.parse(controller.grandTotal.value),context: context);

                          },
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: showText(
                                        color: Colors.black,
                                        text: controller.cardList[i].cardNumber
                                            .toString(),
                                        textSize: 20,
                                        fontweight: FontWeight.w400,
                                        maxlines: 1),
                                  ),
                                ),
                                15.verticalSpace(),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.deleteParticularItemOfCard(
                                          controller.cardList[i].rowId!, i);
                                    },
                                    child: Image.asset(
                                      Images.delete_icon,
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 16,
              );
            },
          ),
        ],
      ),
    );
  }

  showAllCardTop() {
    return Container(
      padding: 4.paddingAll(),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: showText(
                  color: Colors.black,
                  text: "All Cards",
                  textSize: 20,
                  fontweight: FontWeight.w400,
                  maxlines: 1),
            ),
          ),
          15.verticalSpace(),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () async {
                Get.back();

                PlaceOrderExtraItemModal placeOrderData =await  getPlaceOrderData();


                AddCardScreen(null,"catId",Strings.cart,placeOrderData,double.parse(controller.grandTotal.value)).navigate();

              },
              child: Padding(
                padding: 5.paddingAll(),
                child: Image.asset(
                  Images.addIcon,
                  height: 35,
                  width: 35,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  showAllAddressTop() {
    return Container(
      padding: 4.paddingAll(),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: showText(
                  color: Colors.black,
                  text: Strings.selectAddress,
                  textSize: 20,
                  fontweight: FontWeight.w400,
                  maxlines: 1),
            ),
          ),
          15.verticalSpace(),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Get.back();
                MapScreen(
                    double.parse(authController.latitude.value),
                    double.parse(authController.longitude.value))
                    .navigate();
              },
              child: Padding(
                padding: 5.paddingAll(),
                child: Image.asset(
                  Images.addIcon,
                  height: 35,
                  width: 35,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  showExtraItemBackButton() {
    return Row(
      children: [
        backButton().pressBack(),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text: "Extra Item",
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }

  num getVat() {
    var data = controller.cartList[0].id!.split("tax");
    print('data' + data[1]);

    return int.parse(data[1]) / 100 * getSubTotal();
  }

  getSubTotal() {
    double subTotal = 0.0;
    for (int i = 0; i < controller.cartList.length; i++) {
      subTotal = subTotal + getTotalPrice(i) /*+ getTotalExtraItemPrice(i)*/;
    }
    return subTotal;
  }

  getTotalPrice(int i) {
    var total = int.parse(controller.cartList.value[i].price!) *
        int.parse(controller.cartList.value[i].quantity!) +
        getTotalExtraItemPrice(i);
    return total;
  }

  double getDeliveryFee() => getSubTotal() * 15 / 100;

  double getDiscount() {
    //if disable means , to apply coupon
    if (!controller.enableApplyCouponButton.value) {
      return double.parse(controller.couponRes.value.msg![0].discount!);
    }
    return 0.0;
  }

  double getRiderTipPrice() {
    if (controller.riderTip.value != Strings.riderTip) {

      int value = getSelectedRiderValue();


      print('valuekafi' + value.toString());
      double s = value * getSubTotal() / 100;
      print('salluS' + s.toString());
      controller.riderTipPrice.value = s.toString();
      return s;
    }
    return 0.0;
  }

  int getSelectedRiderValue() {

    if(controller.riderTip.value==Strings.riderTip)
    return 0;
    else
      return (int.parse(controller.riderTip.value.substring(
        0, controller.riderTip.value
        .toString()
        .trim()
        .length - 1)));

  }

  getGrandTotal() async {
    try {
      var subTotal = getSubTotal();
      print('kat_subTotal' + subTotal.toString());
      var deliveryFee = controller.isEnableHomeDel.value
          ? getDeliveryFee()
          : 0.0;
      print('kat_deliveryFee' + deliveryFee.toString());

      var vat = getVat();
      print('kat_vat' + vat.toString());

      var riderTip = getRiderTipPrice();
      print('kat_riderTip' + riderTip.toString());


      var vatDiscount=0.0;
      if (vat > 0) {
         vatDiscount = subTotal * vat / 100;

        print('vatDiscount' + vatDiscount.toString());
      }


      var discount = getDiscount();
      var discountPrice=subTotal*discount/100;
      print('kat_discount' + discount.toString() + "  " + (discount > 0).toString());
      print('discountPrice' + discountPrice.toString());


      print('bhoot');
      print('subTotal' + subTotal.toString());
      print('deliveryFee' + deliveryFee.toString());
      print('vat' + vat.toString());
      print('riderTip' + riderTip.toString());
      print('discountPrice' + discountPrice.toString());

      double grandTotal = subTotal + deliveryFee + vat + riderTip-discountPrice;
      print('kat_grandTotal' + grandTotal.toString());




    /*  if (discount > 0) {
        var couponDiscount = subTotal * discount / 100;

        grandTotal = grandTotal - couponDiscount;

        print('afterCouponDiscount_GrandTotal' + grandTotal.toString());
      }*/






      //  await Future.delayed(Duration(milliseconds: 1));

      if (controller.grandTotal.value != '0.0')
        await Future.delayed(Duration(milliseconds: 1));

      controller.updateBottomPriceValues(
          (subTotal).toString(),
          (deliveryFee).toString(),
          (vat).toString(),
          (riderTip).toString(),
          (discountPrice).toString(),
          (grandTotal).toString());

      /* controller.subTotal.value = (subTotal).toString();
    controller.deliveryFee.value = (deliveryFee).toString();
    controller.vat.value = (vat).toString();
    controller.riderTipPrice.value = (riderTip).toString();
    controller.discount.value = (discount).toString();
    controller.grandTotal.value = (subTotal + deliveryFee + vat + riderTip + discount).toString();*/

      print('grandTotal_first' + controller.grandTotal.value);
    } catch (e) {
      print('calculation_Exception' + e.toString());
      print('grandTotal_second' + controller.grandTotal.value);
    }
  }

  getPlaceOrderData() async {
    print('nnnn'+controller.riderTipPrice.value);
    var modal = PlaceOrderExtraItemModal(
        userId: await getUserId(),
        quantity: getTotalCartQuantity(),
        paymentId: "flag",
        addressId:addressId,
        restaurantId:controller.cartList[0].restaurantId!.split("kaif")[0],
        cod:"1",
        riderTip:controller.riderTipPrice.value,
     /*   tax:controller.cartList[0].id!.split("tax")[1],*/
        tax:controller.vat.value,
        subTotal:controller.subTotal.value,
        instructions:controller.instController.getValue(),
        couponId:couponId,
        device:getDevice(),
        version:await getAppVersion(),
        deliveryFee:controller.deliveryFee.value,
        delivery:controller.isEnableHomeDel.value?"1":"0",
        order_time:_getTime(),
        menuItem:getMenuItem()
    );

    String result = jsonEncode(modal);



    print('result' + result);

    return modal;

  }


   _getTime() {
    final String formattedDateTime = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()).toString();
    print('getTime'+formattedDateTime);

    return  formattedDateTime;

  }

  getTotalCartQuantity() {
    var totalQuanity = 0;
    for (int i = 0; i < controller.cartList.length; i++) {
      totalQuanity += int.parse(controller.cartList[i].quantity!);
    }

    print('totalQuan' + totalQuanity.toString());
    return totalQuanity.toString();
  }




  getMenuItem() {

    List<MenuItem> list=<MenuItem>[];

    for(int i=0;i<controller.cartList.length;i++){

      var extraList=controller.cartList[i].extraItemList;

      List<MenuExtraItem> extraItemList=<MenuExtraItem>[];


      for(int j=0;extraList!=null && j<extraList.length;j++){
        extraItemList.add(MenuExtraItem(menuExtraItemName: extraList[j].name,menuExtraItemQuantity: extraList.length.toString(),menuExtraItemPrice: extraList[j].price));

      }



      var modal=MenuItem(
         menuItemName: controller.cartList[i].name,
        menuItemQuantity: controller.cartList[i].quantity,
        menuItemPrice:controller.cartList[i].price,
        menuExtraItem: extraItemList
      );

      list.add(modal);




    }




   // print('kafiFInalList'+list.toString());


   // String result = jsonEncode(list);

   // print('resultList' + result);



    return list;
  }

  Widget showAddDeleteButton(String qty,int i) {

    return Container(
      width: 75,
      decoration: BoxDecoration(
        color: colorPrimary,
        borderRadius: new BorderRadius.all(Radius.circular(2)),
        boxShadow: [
          BoxShadow(
            color: colorPrimary,
            offset: Offset(0.5, 0.5),
            blurRadius: 0.5,
          ),
        ],
      ),
      child: Row(
        children: [

          GestureDetector(
            onTap: (){
              print('minus_clicked');
              deleteCartQuantity(i);
            },
            child: Icon(Icons.remove,
                size: 25.0, color: Color(0xFF6D72FF)),
          ),
          3.verticalSpace(),
          showText(
              color: Colors.white,
              text: qty,
              textSize: 12,
              fontweight: FontWeight.w300,
              maxlines: 1),
          3.verticalSpace(),
          GestureDetector(
            onTap: (){
              print('plus_clicked');

              addCartQuantity(i);


            },
            child: Icon(Icons.add,
                size: 25.0, color: Color(0xFF6D72FF)),
          )

        ],
      ),
    );

  }

  void deleteCartQuantity(int i) {

    if(int.parse(controller.cartList[i].quantity!)==1)
      controller.deleteParticularItem(controller.cartList[i].rowId!, i);
    else
      controller.cartList[i].quantity= (int.parse(controller.cartList[i].quantity!)-1).toString();

    controller.cartList.refresh();

  }

  void addCartQuantity(int i) {


    controller.cartList[i].quantity= (int.parse(controller.cartList[i].quantity!)+1).toString();
    controller.cartList.refresh();

  }

  


  showExtraItemBottomSheet(int i) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) =>
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return GetX<CartController>(
                    builder: (controller) {
                      return SingleChildScrollView(
                          child: Container(
                            margin: 10.marginTop(),
                            padding: 20.paddingBootom(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [showExtraItemList(i)],
                            ),
                          ));
                    }
                );
              }
          ),
    );
  }


  Widget showExtraItemList(int i) {

    //vertical list
    return Padding(
      padding: 5.paddingAll(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showExtraItemBackButton(),
          10.horizontalSpace(),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount:  controller.cartList[i].extraItemList!.length,
            itemBuilder: (_, index) {
              return Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  margin: 5.marginAll(),
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
                  padding: 5.paddingAll(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        showText(
                            color: Colors.black,
                            text:  controller.cartList[i].extraItemList![index].name!,
                            textSize: 16,
                            fontweight: FontWeight.w400,
                            maxlines: 2)




                      ]),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 16,
              );
            },
          ),
        ],
      ),
    );
  }

/*
  Align(
  alignment: Alignment.center,
  child: showText(
  color: Colors.black,
  text: title,
  textSize: 20,
  fontweight: FontWeight.w400,
  maxlines: 1),
  );
*/

  showAppBar() {
    return  AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: Padding(
    padding: const EdgeInsets.only(left: 15),
    child: widget.from == "add"? backButton().pressBack():Container(),
    ),
      centerTitle:  widget.from == "add"?false:true,
    title:Text(
      Strings.checkout,
    style: TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w400
    ),
    ),

    );

  }



}
