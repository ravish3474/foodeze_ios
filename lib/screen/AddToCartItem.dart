import 'dart:collection';
import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/AddToItemController.dart';
import 'package:foodeze_flutter/controller/KitchenController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/CartModal.dart';
import 'package:foodeze_flutter/modal/ExtraMenuItemModal.dart';
import 'package:foodeze_flutter/modal/VirtualKitchenModal.dart';
import 'package:foodeze_flutter/screen/CartPage.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:readmore/readmore.dart';
import 'package:uuid/uuid.dart';

class AddToCartItem extends StatefulWidget {
  RestaurantMenuItem modal;
  String? tax;
  String? minOrderPrice;
  String restaurant_id;
  String city;
  String lat;
  String long;
  String restaurantName;
  double rating;

  List<List<ExtraMenuItemModal>> extraItemList =
      <List<ExtraMenuItemModal>>[].obs;

  AddToCartItem(this.minOrderPrice, this.tax, this.restaurant_id, this.modal,
      this.city, this.rating, this.restaurantName, this.lat, this.long);

  @override
  _AddToCartItemState createState() => _AddToCartItemState();
}

class _AddToCartItemState extends State<AddToCartItem> {
  bool dataFound = false;
  late Box<CartModal> cartBox;

  AddToItemController controller = Get.put(AddToItemController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('ResName' + widget.restaurantName);

    callIntialFunctionOfCart("initial");
  }

  void callIntialFunctionOfCart(String from) {
    cartBox = Hive.box<CartModal>('cart');

    if (checkProductIdExist(widget.modal.id!)) {
      fetchParticularItem(widget.modal.id!);
    } else {
      print('Not_Existtttt');

      controller.addToCartText.value = Strings.addToCart;
    }

    print('totalThisProductCount' + getTotalThisProductCount().toString());
    getTotalThisProductExtraList();
    getTotalCartItem();

    if (from == "initial")
      controller.totalPrice.value = int.parse(widget.modal.price!);
    else if (from == "first")
      controller.totalPrice.value =
          int.parse(widget.modal.price!) * controller.totalQty.value;
    else {
      controller.totalPrice.value = int.parse(widget.modal.price!);
      controller.totalCartItem.value = 0;
    }

    getTotalPriceOfParticularItem();
  }

  bool _listsAreEqual(List one, List two) {
    var i = -1;
    return one.every((element) {
      i++;

      return two[i] == element;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<AddToItemController>(builder: (controller) {
      return Scaffold(
        appBar: showAppBar(true, Strings.menuItem),
        backgroundColor: Colors.white,
        body: ShowUp(
          child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight(context) * 0.80,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                         // showTopWidget(true, Strings.menuItem),
                          Column(
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
                              showQuantity(),
                              //  widget.modal.restaurantMenuExtraSection!.length>=1?  showSelectOption():Container(),
                              showTotalPrice(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        2.horizontalSpace(),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: 7.marginAll(),
                                child: CustomButton(context,
                                    height: 50,
                                    textStyle: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                    borderRadius: 35,
                                    text: controller.addToCartText.value,
                                    onTap: () async {
                                  if (controller.addToCartText.value == Strings.addToCart) {
                                    if (!checkSameRestaurantitem())
                                      showDifferenetRestItem();
                                    else
                                      {
                                        controller.totalExtraItemQty.value=controller.totalQty.value+1;
                                        addItemsToCart(null);

                                      }
                                  }
                                }),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: 7.marginAll(),
                                child: CustomButton(context,
                                    height: 50,
                                    isBorder: true,
                                    borderColor: colorPrimary,
                                    textStyle: TextStyle(
                                        fontSize: 16, color: colorPrimary),
                                    borderRadius: 35,
                                    text: Strings.viewCart, onTap: () async {
                                  //  cartBox.clear();

                                  print('view_cart_clicked');

                                  var result = await CartPage("add")
                                      .navigate(isAwait: true);
                                  if (result != null) {
                                    print('Resultcart' + result);

                                    callIntialFunctionOfCart("first");
                                  }
                                }),
                              ),
                            ),
                          ],
                        ),
                        8.horizontalSpace(),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      );
    });
  }

  Container showTotalPrice() {
    return Container(
      padding: 10.paddingAll(),
      margin: 0.marginBottom(),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        showText(
            color: Colors.black,
            text: "Total Price",
            textSize: 17,
            fontweight: FontWeight.w400,
            maxlines: 1),
        Padding(
          padding: 50.paddingRight(),
          child: showText(
              color: colorPrimary,
              text: "R " + controller.totalPrice.value.toString(),
              textSize: 17,
              fontweight: FontWeight.w400,
              maxlines: 1),
        )
      ]),
    );
  }

  Padding showQuantity() {
    return Padding(
      padding: 10.paddingAll(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          showText(
              color: Colors.black,
              text: "QTY",
              textSize: 17,
              fontweight: FontWeight.w400,
              maxlines: 1),
        widget.modal.restaurantMenuExtraSection!.length > 0?  Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width:150,
                  child: CustomButton(context,
                      height: 50,
                      textStyle: TextStyle(
                          fontSize: 16, color: Colors.white),
                      borderRadius: 35,
                      text: "Select Item",
                      onTap: () async {

                        clickToAddIcon("plus");

                      }),
                ),
              ],
            ),
          )
        :Container(
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: new BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: colorPrimary,
                  offset: Offset(0.5, 0.5),
                  blurRadius: 0.5,
                ),
              ],
            ),
            height: 60,
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 130.0,
              height: 60.0,
              child: Material(
                type: MaterialType.canvas,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(20.0),
                color: colorPrimary.withOpacity(0.7),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      left: 10.0,
                      bottom: null,
                      child: GestureDetector(
                          onTap: () {
                            print('minus_clicked' +
                                controller.totalQty.value.toString());

                           /* if (controller.totalQty.value > 0) {
                              if (getLastRowQty() == 1) {
                                deleteParticularItem(
                                    getLastRowIdOfThisProduct());
                              } else {
                                updateCartData((getLastRowQty() - 1).toString(),
                              getLastRowIdOfThisProduct(),"update");
                              }
                            }*/
                            if (controller.totalQty.value > 0) {
                              if (controller.totalQty.value ==1)
                                deleteParticularItem(getLastRowIdOfThisProduct());
                              else
                                updateCartData((getLastRowQty() - 1).toString(), getLastRowIdOfThisProduct(),"repeat");


                            }



                          },
                          child: Icon(Icons.remove,
                              size: 30.0, color: Color(0xFF6D72FF))),
                    ),
                    Positioned(
                        right: 10.0,
                        top: null,
                        child: GestureDetector(
                          onTap: () {
                            print('plus_clicked');

                            clickToAddIcon("plus");



                          },
                          child: Icon(Icons.add,
                              size: 30.0, color: Color(0xFF6D72FF)),
                        )),
                    GestureDetector(
                      child: Material(
                        color: lightGrey,
                        shape: const CircleBorder(),
                        elevation: 5.0,
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  child: child, scale: animation);
                            },
                            child: Text(
                              controller.totalQty.value.toString(),
                              style: TextStyle(
                                  color: Color(0xFF6D72FF), fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void clickToAddIcon(String from) {

    if (widget.modal.restaurantMenuExtraSection!.length > 0) {
      if (!checkSameRestaurantitem())
        showDifferenetRestItem();
      else {
        if (from=="plus" && controller.totalQty.value > 0)
          showRepeatLastAddNewBottomSheet(getLastRowCartItem());
        else
          _showExtraItemBottomSheet();
      }
    } else {
      if (controller.totalQty.value == 0) {
        if (!checkSameRestaurantitem()) {
          if (!checkSameRestaurantitem())
            showDifferenetRestItem();
          else
            showDifferenetRestItem();
        } else {
          if (!checkSameRestaurantitem())
            showDifferenetRestItem();
          else
            {
              controller.totalExtraItemQty.value=controller.totalQty.value+1;
              addItemsToCart(null);
            }
        }
      } else {
        if (!checkSameRestaurantitem())
          showDifferenetRestItem();
        else {


          controller.totalQty.value=controller.totalQty.value+1;

          print('kaifquan'+ widget.modal.id.toString());
           //controller.totalExtraItemQty.value=controller.totalExtraItemQty.value+1;

         // controller.totalExtraItemQty.value = controller.totalExtraItemQty.value + 1;

          updateCartData(
              (controller.totalQty.value).toString(),
              getLastRowIdOfThisProduct(),"update");
        }
      }
    }


  }

  showKitchenImage() {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            getTotalPriceOfParticularItem();
          },
          child: Container(
            child: CachedNetworkImage(
              imageUrl: ApiEndpoint.MENU_ITEM_URL + widget.modal.image!,
              imageBuilder: (context, imageProvider) {
                return categoryImageSecond(
                    imageProvider, double.infinity, 180, BoxShape.rectangle);
              },
              placeholder: (context, url) {
                return Container(
                  width: double.infinity,
                  height: 180,
                  child: CircularProgressIndicator(),
                );
              },
              errorWidget: (context, url, error) {
                return showPlaceholderImage(
                    image: Images.cover_placeholder,
                    width: double.infinity,
                    height: 180);
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 30.0, top: 150.0),
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
                    onTap: () async {
                      if (!controller.liked.value) Strings.addedToFav.toast();

                      KitchenController().addFavandUnfavAPi(
                          -1, widget.modal.id, await getUserId());
                      controller.liked.value = !controller.liked.value;
                    },
                    child: Padding(
                        padding: 5.paddingAll(),
                        child: Image.asset(controller.liked.value
                            ? Images.like_icon
                            : Images.unlike_icon)),
                  )),
            ),
          ),
        ),
      ],
    );
  }

  showAppBar(bool showCart, String title){
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(5),
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
        showCart
            ? GestureDetector(
          onTap: () async {
            print('cart_clicked');

            var result =
            await CartPage("add").navigate(isAwait: true);
            if (result != null) {
              print('Resultcart' + result);

              callIntialFunctionOfCart("first");
            }
          },
          child: Container(
            padding: 5.paddingAll(),
            margin: 2.marginAll(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Badge(
                    animationType: BadgeAnimationType.slide,
                    badgeColor: colorPrimary,
                    badgeContent: Text(
                        controller.totalCartItem.value.toString()),
                    child: Icon(
                      Icons.shopping_cart,
                      size: 30,
                      color: Colors.black54,
                    ),
                  )
                ]),
          ),
        )
            : Container(),
      ],
    );
  }

  Padding showTopWidget(bool showCart, String title) {
    return Padding(
      padding: 10.paddingAll(),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: backButton()),
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
                        text: title,
                        textSize: 20,
                        fontweight: FontWeight.w400,
                        maxlines: 1)
                  ],
                ),
              ),
            ),
            showCart
                ? GestureDetector(
                    onTap: () async {
                      print('cart_clicked');

                      var result =
                          await CartPage("add").navigate(isAwait: true);
                      if (result != null) {
                        print('Resultcart' + result);

                        callIntialFunctionOfCart("first");
                      }
                    },
                    child: Container(
                      padding: 5.paddingAll(),
                      margin: 2.marginAll(),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Badge(
                              animationType: BadgeAnimationType.slide,
                              badgeColor: colorPrimary,
                              badgeContent: Text(
                                  controller.totalCartItem.value.toString()),
                              child: Icon(
                                Icons.shopping_cart,
                                size: 30,
                                color: Colors.black54,
                              ),
                            )
                          ]),
                    ),
                  )
                : Container(),
          ]),
    );
  }

  showRestaurantName() {
    return Padding(
      padding: 10.paddingLeft(),
      child: showText(
          color: Colors.black,
          text: widget.modal.name!,
          textSize: 17,
          fontweight: FontWeight.w400,
          maxlines: 2),
    );
  }

  showRestaurantLocation() {
    return Padding(
      padding: EdgeInsets.only(right: 10, top: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              Images.location_icon,
              width: 25,
              height: 25,
            ),
            showText(
                color: colorPrimary,
                text: widget.city,
                textSize: 17,
                fontweight: FontWeight.w400,
                maxlines: 1),
          ],
        ),
      ),
    );
  }

  showRatingHeading() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 0),
      child: showText(
          color: colorPrimary,
          text: widget.rating.toString() + " Rating",
          textSize: 17,
          fontweight: FontWeight.w400,
          maxlines: 1),
    );
  }

  showRatingBar() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 5),
      child: RatingBar.builder(
        initialRating: widget.rating,
        minRating: 0,
        glowColor: colorPrimary,
        ignoreGestures: true,
        maxRating: 5,
        itemSize: 22,
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
      padding: EdgeInsets.only(left: 10, top: 10),
      child: showText(
          color: Colors.black,
          text: "About Kitchen",
          textSize: 17,
          fontweight: FontWeight.w400,
          maxlines: 1),
    );
  }

  Widget showAboutDescriptioin() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
      child: ReadMoreText(
        widget.modal.description!,
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

  Future<void> _showExtraItemBottomSheet() async {
    print('bottomsheetCalled');

    print('ExtraItemBefore' + widget.extraItemList.toString());

    controller.selectedItems.clear();
    controller.enableAddToItemButton.value = false;
    setTOZeroExtraItemQuantity();

    Future<void> future = showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return GetX<AddToItemController>(builder: (controller) {
          return SingleChildScrollView(
              primary: true,
              child: Container(
                margin: 20.marginTop(),
                padding: 20.paddingBootom(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [showList()],
                ),
              ));
        });
      }),
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    print('closeModal');

    // if (controller.extraItemList.value.isEmpty)
    //  updateCartData(controller.totalQty.value);
  }

  Widget showList() {
    //vertical list
    return Padding(
      padding: 3.paddingAll(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showTopWidget(false, Strings.extraItem),
          10.horizontalSpace(),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: widget.modal.restaurantMenuExtraSection!.length,
            itemBuilder: (_, i) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showExtraMenuTitle(
                        widget.modal.restaurantMenuExtraSection![i].required!,
                        widget.modal.restaurantMenuExtraSection![i].name!),
                    10.horizontalSpace(),
                    Divider(
                      thickness: 1.5,
                      height: 6,
                    ),
                    _horizontalListView(i,
                        widget.modal.restaurantMenuExtraSection![i].required!),
                    10.horizontalSpace(),
                  ]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 16,
              );
            },
          ),
          0.horizontalSpace(),
          Row(
            children: [
              Expanded(flex: 2, child: showExtraItemBottomQuantity()),
              10.verticalSpace(),
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0)),
                    elevation: 18.0,
                    color: controller.enableAddToItemButton.value
                        ? colorPrimary
                        : lightGrey,

                    clipBehavior: Clip.antiAlias,
                    // A
                    child: MaterialButton(
                        minWidth: double.infinity,
                        height: 55,
                        color: controller.enableAddToItemButton.value
                            ? colorPrimary
                            : lightGrey,
                        child: new Text(Strings.addItem,
                            style: new TextStyle(
                                fontSize: 16.0, color: Colors.white)),
                        onPressed: () {
                          if (controller.enableAddToItemButton.value ) {

                            if( controller.totalExtraItemQty.value==0)
                              "Please increase at least 1 quantity".toast();
                            else
                            addExtraItemToList();
                          }        }),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  showExtraMenuTitle(String isRequired, String title) {
    var title2 = isRequired == "1" ? " *" : "";

    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: RichText(
        maxLines: 2,
        text: TextSpan(
          text: title,
          style: TextStyle(color: Colors.black, fontSize: 20),
          children: <TextSpan>[
            TextSpan(text: title2, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  Widget _horizontalListView(int index, String required) {
    //controller.selectedItems.clear();

    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.modal.restaurantMenuExtraSection![index].restaurantMenuExtraItem!.length,
      scrollDirection: Axis.vertical,
      /*itemBuilder: (data_,index) =>_buildBox(color: colorPrimary),*/
      itemBuilder: (_, Horindex) {
        return Padding(
          padding: 5.paddingAll(),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                showMenuExtraItemTitle(
                    widget.modal.restaurantMenuExtraSection![index].restaurantMenuExtraItem!,
                    required,
                    int.parse(
                      widget.modal.restaurantMenuExtraSection![index]
                          .restaurantMenuExtraItem![Horindex].id!,
                    ),
                    Horindex,
                    widget.modal.restaurantMenuExtraSection![index]
                        .restaurantMenuExtraItem![Horindex].name!,
                    3),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      showText(
                          color: colorPrimary,
                          text: "R ",
                          textSize: 14,
                          fontweight: FontWeight.w700,
                          maxlines: 1),
                      Padding(
                        padding: 5.paddingRight(),
                        child: showText(
                            color: Colors.black,
                            text: widget
                                .modal
                                .restaurantMenuExtraSection![index]
                                .restaurantMenuExtraItem![Horindex]
                                .price!,
                            textSize: 15,
                            fontweight: FontWeight.w400,
                            maxlines: 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 10,
        );
      },
    );
  }

  showMenuExtraItemTitle(
  List<RestaurantMenuExtraItem> extraList,String required, int id, int index, String title, int flex) {
    print('titleKaif' + title + " " + required);
    print('selectedIndex' + controller.selectedItems.toString());

    return GetX<AddToItemController>(builder: (controller) {
      return Expanded(
        flex: flex,
        child: GestureDetector(
          onTap: () {

           var a= isAllItemZero(extraList);

           print('isAllItemZero'+a.toString());

            if (controller.selectedItems.contains(id)) {
              print('First');

              controller.selectedItems.removeWhere((val) => val == id);

              //  if(required=="1" && controller.selectedItems.length<=0)
              //  controller.enableAddToItemButton.value=false;

            } else {


            var check=  isThisIdContainedInList(extraList,id);
            print('checkIdContainer'+check.toString());

            if(check && isAllItemZero(extraList) )
              "You can select only 1 item".toast();
            else
              controller.selectedItems.add(id);

              print('kaifkakf' + widget.extraItemList.toString());

              //if(required=="1")
              // controller.enableAddToItemButton.value=true;

            }

            enableAddToItemButton();

            print('selectedIndex' + controller.selectedItems.toString());
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              color: (controller.selectedItems.contains(id))
                  ? colorPrimary.withOpacity(0.5)
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: colorPrimary,
                  offset: Offset(0.5, 0.5),
                  blurRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding: 7.paddingAll(),
              child: showText(
                  color: Colors.black,
                  text: title,
                  textSize: 15,
                  fontweight: FontWeight.w400,
                  maxlines: 5),
            ),
          ),
        ),
      );
    });
  }

  void addExtraItemToList() async {
    // controller.extraItemList.value.clear();
    // newExtraItemList.clear();

    List<ExtraMenuItemModal> newExtraItemList = <ExtraMenuItemModal>[].obs;

    print('loopSelectedList' + controller.selectedItems.toString());

    for (int i = 0; i < widget.modal.restaurantMenuExtraSection!.length; i++) {
      String title = widget.modal.restaurantMenuExtraSection![i].name!;
      String restaurantId =
          widget.modal.restaurantMenuExtraSection![i].restaurantId!;
      String restaurantMenuItemId =
          widget.modal.restaurantMenuExtraSection![i].restaurantMenuItemId!;

      print('outerLoop');
      List<RestaurantMenuExtraItem>? item =
          widget.modal.restaurantMenuExtraSection![i].restaurantMenuExtraItem;

      for (int i = 0; i < item!.length; i++) {
        print('innerLoop');

        if (controller.selectedItems.contains(int.parse(item[i].id!))) {
          print('beforeIf' + controller.selectedItems.toString());

          newExtraItemList.add(ExtraMenuItemModal(
              id: item[i].id,
              name: item[i].name,
              price: item[i].price,
              restaurant_menu_extra_section_id:
                  item[i].restaurantMenuExtraSectionId,
              title: title,
              restaurant_id: restaurantId,
              restaurant_menu_item_id: restaurantMenuItemId));

          //  print('loopRUn' + extraItemList.toString());
        }
      }
    }

    print('ExtraItemBefore' + widget.extraItemList.toString());
    print('NewItemBefore' + newExtraItemList.toString());

    var outerFlag = false;

    for (int i = 0; i < widget.extraItemList.length; i++) {
      List<ExtraMenuItemModal> itemList1 = widget.extraItemList[i];
      print('itemList1_' + itemList1.toString());
      print('newExtraItemList' + newExtraItemList.toString());
      //   print('checkEqual' + _listsAreEqual(itemList1, newExtraItemList).toString());

      print('itemList1_SIZE' + itemList1.length.toString());
      print('newExtraItemList_SIZE' + newExtraItemList.length.toString());

      if (itemList1.length == newExtraItemList.length &&
          _listsAreEqual(itemList1, newExtraItemList)) {
        print('listAreEqual');
        outerFlag = true;
      }

      //duplicate extra item found then update its quantity
      if (outerFlag) {
        print('item_found_duplicate');
        updateCartData(getUpdatePositionId(newExtraItemList)[1],
            getUpdatePositionId(newExtraItemList)[0],"update");

        //  controller.totalQty.value = controller.totalQty.value + 1;

        //  controller.totalPrice.value = int.parse(widget.modal.price!) * controller.totalQty.value;
        print(
            'UpdatedCalledtotalPrice' + controller.totalPrice.value.toString());

        break;
      }
    }

    //new  extra item found then add item to cart

    if (!outerFlag) {
      print('item_found_new');
      widget.extraItemList.add(newExtraItemList);

      if (!checkSameRestaurantitem())
        showDifferenetRestItem();
      else
        addItemsToCart(newExtraItemList);
    }

    if (newExtraItemList.length > 0) Strings.extraItemSuccess.toast();

    Get.back();

    print('ExtraItemAfter' + widget.extraItemList.toString());
    print('NewItemAfter' + newExtraItemList.toString());
  }

  List<String> getUpdatePositionId(newExtraItemList) {
    print('getUpdatePositionId' + newExtraItemList.toString());

    List<String> returnList = [];

    for (int i = 0; i < cartBox.length; i++) {
      CartModal? item = cartBox.getAt(i);

      if (item!.extraItemList!.length == newExtraItemList.length &&
          _listsAreEqual(item.extraItemList!, newExtraItemList)) {
        returnList.add(item.rowId!);
        returnList.add((int.parse(item.quantity!) + 1).toString());

        break;
      }
    }

    print('getUpdatCalled' + returnList.toString());

    return returnList;
  }

  bool checkOneOfitemIsRequired() {
    var flag = false;

    for (int i = 0; i < widget.modal.restaurantMenuExtraSection!.length; i++) {
      List<RestaurantMenuExtraItem>? item =
          widget.modal.restaurantMenuExtraSection![i].restaurantMenuExtraItem;
      String required = widget.modal.restaurantMenuExtraSection![i].required!;
      String name = widget.modal.restaurantMenuExtraSection![i].name!;

      for (int i = 0; i < item!.length; i++) {
        if (required == "1") {
          flag = true;

          break;
        } else
          break;
      }

      if (flag) break;
    }

    if (flag)
      return true;
    else
      return false;
  }

  void enableAddToItemButton() {
    HashMap<String, String> hashMap = new HashMap();
    var flag = false;

    for (int i = 0; i < widget.modal.restaurantMenuExtraSection!.length; i++) {
      List<RestaurantMenuExtraItem>? item =
          widget.modal.restaurantMenuExtraSection![i].restaurantMenuExtraItem;
      String required = widget.modal.restaurantMenuExtraSection![i].required!;
      String name = widget.modal.restaurantMenuExtraSection![i].name!;

      for (int i = 0; i < item!.length; i++) {
        if (required == "1" &&
            controller.selectedItems.contains(int.parse(item[i].id!))) {
          flag = true;
          hashMap[name] = 'Selected';
          break;
        } else if (required == "1" &&
            !controller.selectedItems.contains(int.parse(item[i].id!))) {
          flag = false;
          hashMap[name] = 'notSelected';

          // break;
        }
      }

      // if (flag) break;
    }

    var checkFlag = false;

    for (var k in hashMap.keys) {
      if (hashMap[k] == 'notSelected') {
        checkFlag = true;
        break;
      }
    }

    //required item not selected
    if (checkFlag)
      controller.enableAddToItemButton.value = false;
    else
      controller.enableAddToItemButton.value = true;

    /*  if (flag)
      controller.enableAddToItemButton.value = true;
    else
      controller.enableAddToItemButton.value = false;*/

    print('kaifkakf' + widget.extraItemList.toString());
  }

  void addItemsToCart(List<ExtraMenuItemModal>? list) {
    print('addItemcalled' + widget.lat + " " + widget.long);
    print('extraList' + widget.extraItemList.toString());
    print('Add_totalExtraItemQty' +
        controller.totalExtraItemQty.value.toString());

    late CartModal cartModal;

    var uuid = Uuid();

    var rowId = uuid.v1();

    print('RowId' + rowId);

    //only for first item
    if (controller.totalQty.value == 0) {
      if (checkOneOfitemIsRequired()) {
        if (widget.extraItemList.isEmpty) {
          "Please Add Extra Item".toast();
          return;
        }
      }
    }

    /*if (controller.totalCartItem.value == 0) {
      Strings.selectQty.toast();
      return;
    } else*/

    var tax = widget.tax == null ? '0' : widget.tax;

    cartModal = CartModal(
        id: widget.modal.id! + "tax" + tax!,
        name: widget.modal.name,
        description: widget.modal.description,
        category: widget.modal.category,
        price: widget.modal.price,
        quantity: controller.totalExtraItemQty.value.toString(),
        image: widget.modal.image,
        restaurantMenuId: widget.modal.restaurantMenuId,
        restaurantId: widget.restaurant_id + "kaif" + widget.minOrderPrice!,
        restaurantName: widget.restaurantName,
        rowId: rowId,
        extraItemList: list,
        lat: widget.lat,
        long: widget.long);

    cartBox.add(cartModal);
    Strings.cartSuccess.toast();

    controller.addToCartText.value = Strings.added;
    // controller.totalQty.value=1;

    getTotalThisProductCount();

    print('extra_list_after_add' + widget.extraItemList.toString());

    getTotalCartItem();

    // controller.totalPrice.value = int.parse(widget.modal.price!) * controller.totalQty.value;

    getTotalPriceOfParticularItem();
  }

  getTotalPriceOfParticularItem() {
    final Map<dynamic, CartModal> deliveriesMap = cartBox.toMap();
    // print('fetchCartData_Map' + cartBox.values.toString());
    log('fetchCartData_Map' + cartBox.values.toString());

    print('ItemId' + widget.modal.id!);

    var subTotal = 0;

    for (var f in cartBox.values
        .where((item) => item.id!.split("tax")[0] == widget.modal.id!)) {
      if (f != null) {
        print('salluCalled');

        try {
          List<ExtraMenuItemModal>? extraList = f.extraItemList;
          var totalExtraItemPrice = 0;
          if (extraList != null) {
            for (int i = 0; i < extraList.length; i++) {
              totalExtraItemPrice += int.parse(extraList[i].price!);
            }

            if (int.parse(f.quantity!) > 1)
              totalExtraItemPrice =
                  totalExtraItemPrice * int.parse(f.quantity!);
          }

          subTotal = subTotal +
              int.parse(f.price!) * int.parse(f.quantity!) +
              totalExtraItemPrice;

          controller.totalPrice.value = subTotal;
        } catch (e) {
          print('kaifCalException' + e.toString());
        }
      } else
        print('salluCalledNull');
    }

    print('TotalParTItem' + subTotal.toString());

    if (subTotal == 0) {
      print('kaifPrice' + widget.modal.price!);
      controller.totalPrice.value = 0;
    }

    // getTotalThisProductItemCOunt();
    getTotalThisProductCount();
  }

  showDifferenetRestItem() {
    print('showCalled');
    CustomDialog(context,
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
              Image.asset(
                Images.error_image,
                width: screenWidth(context),
                height: 100,
              ),
              30.horizontalSpace(),
              Text(
                "To add another restaurant item you have to clear existing cart",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.47)),
                textAlign: TextAlign.center,
              ),
              5.horizontalSpace(),
              Text(
                "Do you want to clear you cart?",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorPrimary.withOpacity(0.47)),
                textAlign: TextAlign.center,
              ),
              30.horizontalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(context, height: 50, text: 'No', isBorder: true,
                      onTap: () {
                    pressBack();
                  }, width: screenWidth(context) / 2.8),
                  CustomButton(context, height: 50, text: 'Yes', onTap: () {
                    cartBox.clear();
                    callIntialFunctionOfCart("second");
                    print('cart_clear');
                    Get.back();
                  }, width: screenWidth(context) / 2.8)
                ],
              ),
            ],
          ),
        ));
  }

  void updateCartData(String newQuantity, String rowId,String from) {
    print('updateQuantity' + newQuantity.toString());
    print('updateId' + rowId);
    print('from' + from);
    print('Add_totalExtraItemQty' +
        controller.totalExtraItemQty.value.toString());

    final Map<dynamic, CartModal> deliveriesMap = cartBox.toMap();
    //  print('updateCartData' + deliveriesMap.toString());

    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.rowId == rowId) desiredKey = key;
    });

    print('UpdateParCalled' + desiredKey.toString());

    print('Fistttt');

    CartModal? item = cartBox.get(desiredKey);

    print('seconnddd');

    //  item!.quantity = newQuantity;

    print('f111' + item!.quantity!);
    print('f222' + controller.totalExtraItemQty.value.toString());

    int newQuantity2 = int.parse(item.quantity!) + controller.totalExtraItemQty.value;

    if(from=="update" && controller.totalExtraItemQty.value!=0)
    item.quantity = newQuantity2.toString();
    else
      item.quantity = newQuantity;


    print('newQuantity2' +  item.quantity!);

    // item.extraItemList = controller.extraItemList.value;

    print('thirdddd');

    cartBox.put(desiredKey, item);

    controller.addToCartText.value = Strings.added;

    controller.selectedItems.clear();
    controller.enableAddToItemButton.value = false;

    print('UpdatedCalled' + cartBox.values.toString());

    getTotalPriceOfParticularItem();

    // getTotalThisProductCount();

    //controller.totalQty.value = controller.totalQty.value + 1;
  }

  void deleteParticularItem(String rowId) {
    //delete particular item
    print('deletedRowId' + rowId);
    final Map<dynamic, CartModal> deliveriesMap = cartBox.toMap();
    print('deleteDateMap' + deliveriesMap.toString());

    dynamic desiredKey;

    deliveriesMap.forEach((key, value) {
      if (value.rowId == rowId) desiredKey = key;
    });

    cartBox.delete(desiredKey);

    print('deletecalled' + desiredKey.toString());

    getTotalThisProductCount();
    getTotalThisProductExtraList();
    getTotalCartItem();
    if (controller.totalQty.value == 0)
      controller.addToCartText.value = Strings.addToCart;

    //fetchCartData();

    getTotalPriceOfParticularItem();
  }

  bool checkProductIdExist(String id) {
    bool result = false;
    for (var f
        in cartBox.values.where((item) => item.id!.split("tax")[0] == id)) {
      if (f != null) {
        result = true;
        break;
      }
    }

    return result;
  }

  void fetchParticularItem(String id) {
    //fetch particular items
    cartBox.values
        .where((item) => item.id!.split("tax")[0] == id)
        .forEach((item) => {
              controller.totalQty.value = int.parse(item.quantity!),
              // controller.totalPrice.value =int.parse(widget.modal.price!) * int.parse(item.quantity!),
              controller.addToCartText.value = Strings.added
            });
  }

  void fetchCartData() {
    final Map<dynamic, CartModal> deliveriesMap = cartBox.toMap();
    print('fetchCartData_Map' + cartBox.values.toString());

    print('fetchCartdataCalled' + cartBox.length.toString());

    for (int i = 0; i < cartBox.length; i++) {
      CartModal? item = cartBox.getAt(i);

      print("Cartitem" + item.toString()); // Dave - 22

    }
  }

  Future<int> getTotalThisProductCount() async {
    // print('getTotalCartCalled' + cartBox.values.toString());

    int total = 0;
    for (var f in cartBox.values
        .where((item) => item.id!.split("tax")[0] == widget.modal.id!)) {
      if (f != null) {
        total = total + int.parse(f.quantity!);
      }
    }

    print('getTotalCalled' + total.toString());
    await Future.delayed(Duration(milliseconds: 100));

    controller.totalQty.value = total;

    return total;
  }

  int getTotalThisProductItemCOunt() {
    print('getTotalCartCalled' + cartBox.values.toString());

    int total = 0;
    for (var f in cartBox.values
        .where((item) => item.id!.split("tax")[0] == widget.modal.id!)) {
      if (f != null) {
        total++;
      }
    }

    print('getTotalThisProductItemCOunt' + total.toString());

    controller.totalQty.value = total;

    return total;
  }

  int? getTotalThisProductExtraList() {
    if (widget.extraItemList.isNotEmpty) widget.extraItemList.clear();

    for (var f in cartBox.values
        .where((item) => item.id!.split("tax")[0] == widget.modal.id!)) {
      if (f != null) {
        print('chhh' + f.extraItemList.toString());

        try {
          widget.extraItemList.add(f.extraItemList!);
        } catch (e) {
          print('katExc' + e.toString());
        }
      }
    }

    print('getTotalExtraListCalled' + widget.extraItemList.length.toString());
  }

  String getLastRowIdOfThisProduct() {
    int total = 0;
    var rowId="";
    for (var f in cartBox.values
        .where((item) => item.id!.split("tax")[0] == widget.modal.id!)) {
      if (f != null) {
        total++;
        rowId=f.rowId!;
        break;
      }
    }

   // return cartBox.getAt(total - 1)!.rowId!;
    return rowId;
  }

  getTotalCartItem() {
    controller.totalCartItem.value = cartBox.length;
  }

  bool checkSameRestaurantitem() {
    if (cartBox.length > 0) {
      String cartAddedRestName = cartBox.getAt(0)!.restaurantName!;
      String newRestName = widget.restaurantName;

      print('cartAddedRestName' + cartAddedRestName);
      print('newRestName' + newRestName);
      print('newRestName' + newRestName);

      if (cartAddedRestName == newRestName)
        return true;
      else
        return false;
    } else
      return true;
  }

 /* int getLastRowQty() {
    var lastRowQty = cartBox.getAt(cartBox.length - 1)!.quantity!;
    print('lastRowQty' + lastRowQty);
    return int.parse(lastRowQty);
  }*/


  int getLastRowQty() {
    int total = 0;
    var quantity=-1;
    for (var f in cartBox.values
        .where((item) => item.id!.split("tax")[0] == widget.modal.id!)) {
      if (f != null) {
        total++;
        quantity=int.parse(f.quantity!);
        break;
      }
    }

    // return cartBox.getAt(total - 1)!.rowId!;
    return quantity;
  }



  CartModal getLastRowCartItem() {
    return cartBox.getAt(cartBox.length - 1)!;
  }

  Widget showExtraItemBottomQuantity() {
    return Container(
      decoration: BoxDecoration(
        color: colorPrimary,
        borderRadius: new BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: colorPrimary,
            offset: Offset(0.5, 0.5),
            blurRadius: 0.5,
          ),
        ],
      ),
      height: 60,
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 80.0,
        height: 50.0,
        child: Material(
          type: MaterialType.canvas,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20.0),
          color: colorPrimary.withOpacity(0.7),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: 10.0,
                bottom: null,
                child: GestureDetector(
                    onTap: () {
                      print('minus_clicked' +
                          controller.totalExtraItemQty.value.toString());

                      if (controller.totalExtraItemQty.value > 0)
                        controller.totalExtraItemQty.value =
                            controller.totalExtraItemQty.value - 1;
                    },
                    child: Icon(Icons.remove,
                        size: 20.0, color: Color(0xFF6D72FF))),
              ),
              Positioned(
                  right: 10.0,
                  top: null,
                  child: GestureDetector(
                    onTap: () {
                      print('plus_clicked');
                      controller.totalExtraItemQty.value =
                          controller.totalExtraItemQty.value + 1;
                    },
                    child:
                        Icon(Icons.add, size: 20.0, color: Color(0xFF6D72FF)),
                  )),
              GestureDetector(
                child: Material(
                  color: lightGrey,
                  shape: const CircleBorder(),
                  elevation: 5.0,
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(child: child, scale: animation);
                      },
                      child: Text(
                        controller.totalExtraItemQty.value.toString(),
                        style:
                            TextStyle(color: Color(0xFF6D72FF), fontSize: 12.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setTOZeroExtraItemQuantity() async {
    await Future.delayed(Duration(milliseconds: 100));
    controller.totalExtraItemQty.value = 0;
  }

  //show repeat last or add new bottom sheet
  Future<void> showRepeatLastAddNewBottomSheet(
      CartModal lastRowCartItem) async {
    var extraText = """ """;
    print('bbbb'+lastRowCartItem.toString());

    if (lastRowCartItem.extraItemList != null) {
      for (int i = 0; i < lastRowCartItem.extraItemList!.length; i++) {
        extraText = extraText + lastRowCartItem.extraItemList![i].name! + "\n";
        print('kaifText'+extraText);
      }
    }

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
          builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      showText(
                          color: Colors.black,
                          text: "Repeat last used customization?",
                          textSize: 20,
                          fontweight: FontWeight.w400,
                          maxlines: 1),
                      15.horizontalSpace(),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: colorPrimary,
                            size: 12,
                          ),
                          5.verticalSpace(),
                          Expanded(
                            child: showText(
                                color: Colors.black,
                                text: lastRowCartItem.name!,
                                textSize: 16,
                                fontweight: FontWeight.w400,
                                maxlines: 2),
                          )
                        ],
                      ),
                      Container(
                        margin: 15.marginLeft(),
                        child: showText(
                            color: Colors.black,
                            text: extraText,
                            textSize: 14,
                            fontweight: FontWeight.w300,
                            maxlines: 5),
                      ),
                      20.horizontalSpace(),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: 7.marginAll(),
                                    child: CustomButton(context,
                                        height: 50,
                                        textStyle: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                        borderRadius: 35,
                                        text: Strings.addNew,
                                        onTap: () async {
                                      Get.back();
                                          clickToAddIcon("addNew");

                                        }),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: 7.marginAll(),
                                    child: CustomButton(context,
                                        height: 50,
                                        isBorder: true,
                                        borderColor: colorPrimary,
                                        textStyle: TextStyle(
                                            fontSize: 16, color: colorPrimary),
                                        borderRadius: 35,
                                        text: Strings.repeatLast,
                                        onTap: () async {
                                          Get.back();
                                          updateCartData(
                                              (getLastRowQty()+1).toString(),
                                              getLastRowIdOfThisProduct(),"repeat");


                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              )));

    }

  bool isAllItemZero(List<RestaurantMenuExtraItem> extraList) {

    var flag=false;

    for(int i=0;i<extraList.length;i++)
      {
        if(int.parse(extraList[i].price!)!=0)
          {
            flag=true;
            break;
          }

      }

    //all item price is zero
    if(flag)
      return false;
    else
      return true;


  }

  bool isThisIdContainedInList(List<RestaurantMenuExtraItem> extraList,int id ) {
    var flag = false;
    for (int i = 0; i < extraList.length; i++) {

      for(int j=0;j<controller.selectedItems.length;j++)
        {

          if(controller.selectedItems[j]==int.parse(extraList[i].id!))
            {
              flag=true;
              break;
            }


        }

      if(flag)
        break;


    }


    if(flag)
      return true;
    else
      return false;

  }


}
