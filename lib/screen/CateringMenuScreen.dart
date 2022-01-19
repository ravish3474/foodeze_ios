import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:declarative_refresh_indicator/declarative_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/CateringMenuController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/modal/CateringExtraMenuItemModal.dart';
import 'package:foodeze_flutter/modal/CateringModal.dart';
import 'package:foodeze_flutter/modal/FetchCateringMenuModal.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class CateringMenuScreen extends StatefulWidget {
  String? restaurantId;
  String? restaurantName;
  String restaurantTax;
  String restaurantMinorder;

   List<CateringMenuExtraSection> originalExtraList=[];
   List<CateringExtraMenuItemModal> newExtraItemList=[];

  CateringMenuScreen(this.restaurantId, this.restaurantName, this.restaurantTax, this.restaurantMinorder);

  @override
  _CateringMenuScreenState createState() => _CateringMenuScreenState();
}



class _CateringMenuScreenState extends State<CateringMenuScreen> {
  CateringMenuController controller = Get.put(CateringMenuController());
  late Box<CateringModal> cartBox;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    cartBox = Hive.box<CateringModal>('catering');

    _refreshData();
  }

  void _refreshData() async {
    print('_refreshData_called');

    controller.loading.value = true;
    await controller.fetchCateringMenuAPI(
        widget.restaurantId!, "2020-08-17 23:59:00");
    if (mounted) controller.loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pressBack(result: cartBox.length.toString());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GetX<CateringMenuController>(builder: (controller) {
            return GestureDetector(
              onTap: () {
                final Map<dynamic, CateringModal> deliveriesMap = cartBox.toMap();
                print('CaterinDB' + deliveriesMap.toString());

                //test();
              },
              child: Container(
                color: Colors.white,
                  padding: 10.paddingAll(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: screenHeight(context) * 0.82,
                        child: DeclarativeRefreshIndicator(
                          refreshing: controller.loading.value,
                          onRefresh: _refreshData,
                          child: SingleChildScrollView(
                            primary: true,
                            child: Column(
                              children: [
                                showTopWidget(Strings.cateringMenu),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [20.horizontalSpace(), showList()],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          10.horizontalSpace(),
                          Container(
                            height: 55,
                            margin: 5.marginAll(),
                            child: CustomButton(context,
                                height: 55,
                                textStyle: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                borderRadius: 35,
                                text: Strings.addToCateringReq,
                                onTap: () async {

                              if(cartBox.length<=0)
                                Strings.pleaseSelectCateringItem.toast();
                              else
                                //Get.back();
                              await pressBack(result: cartBox.length.toString());


                                }),
                          ),
                        ],
                      ),
                    ],
                  )),
            );
          }),
        ),
      ),
    );
  }

  Widget showTopWidget(String title) {
    return Padding(
      padding: 5.paddingAll(),
      child: Row(
        children: [
          backButton().pressBack(result: cartBox.length.toString()),
          15.verticalSpace(),
          GestureDetector(
            onTap: () {
              print('clearData');
              cartBox.clear();
            },
            child: showText(
                color: Colors.black,
                text: title,
                textSize: 20,
                fontweight: FontWeight.w400,
                maxlines: 1),
          )
        ],
      ),
    );
  }

  Widget showList() {
    //vertical list
    if (controller.cateringMenuResData.value.data != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: controller
                .cateringMenuResData.value.data![0].cateringMenu!.length,
            itemBuilder: (_, i) {
              print('printk' +
                  controller.cateringMenuResData.value.data![0].cateringMenu![i]
                      .index!);

              return Card(
                elevation: 5,
                child: Container(
                  padding: 1.paddingAll(),
                  child: Column(children: [
                    showTitleWidget(
                        i,
                        controller.cateringMenuResData.value.data![0]
                            .cateringMenu![i].name!,
                        20),
                    controller.cateringMenuResData.value.data![0]
                                .cateringMenu![i].index ==
                            "1"
                        ? 10.horizontalSpace()
                        : 0.horizontalSpace(),
                    controller.cateringMenuResData.value.data![0]
                                .cateringMenu![i].index ==
                            "1"
                        ? _horizontalListView(i)
                        : empty(),
                    10.horizontalSpace(),
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
      );
    } else {
      return Container();
    }
  }

  Widget _horizontalListView(int index) {
    return SizedBox(
      height: 170,
      child: ListView.separated(
        itemCount: controller.cateringMenuResData.value.data![0]
            .cateringMenu![index].cateringMenuItem!.length,
        scrollDirection: Axis.horizontal,
        /*itemBuilder: (data_,index) =>_buildBox(color: colorPrimary),*/
        itemBuilder: (_, horIndex) {
          return Container(
            margin: 10.marginLeft(),
            width: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: ApiEndpoint.CATERING_MENU_ITEM_URL +
                            controller
                                .cateringMenuResData
                                .value
                                .data![0]
                                .cateringMenu![index]
                                .cateringMenuItem![horIndex]
                                .image!,
                        imageBuilder: (context, imageProvider) {
                          return categoryImageSecond(imageProvider,
                              double.infinity, 80, BoxShape.rectangle);
                        },
                        placeholder: (context, url) {
                          return showPlaceholderImage(
                              image: Images.cover_placeholder,
                              width: double.infinity,
                              height: 80);
                        },
                        errorWidget: (context, url, error) {
                          return showPlaceholderImage(
                              image: Images.cover_placeholder,
                              width: double.infinity,
                              height: 80);
                        },
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: showText(
                            color: Colors.black,
                            text: controller
                                .cateringMenuResData
                                .value
                                .data![0]
                                .cateringMenu![index]
                                .cateringMenuItem![horIndex]
                                .name!,
                            textSize: 14,
                            fontweight: FontWeight.w400,
                            maxlines: 2),
                      ),
                      5.horizontalSpace(),
                      Center(
                        child: CustomButton(context,
                            height: 30,
                            width: 80,
                            isBorder: true,
                            textStyle:
                                TextStyle(fontSize: 15, color: colorPrimary),
                            onTap: () {

                              widget.originalExtraList = controller
                                  .cateringMenuResData
                                  .value
                                  .data![0]
                                  .cateringMenu![index]
                                  .cateringMenuItem![horIndex]
                                  .cateringMenuExtraSection!;


                              print('ceckRquiredItem'+checkOneOfitemIsRequired().toString());



                              if(checkOneOfitemIsRequired())
                                _showExtraListBottomSheet(
                                    controller
                                        .cateringMenuResData
                                        .value
                                        .data![0]
                                        .cateringMenu![index]
                                        .cateringMenuItem![horIndex]
                                        .cateringMenuExtraSection!,
                                    controller
                                        .cateringMenuResData
                                        .value
                                        .data![0]
                                        .cateringMenu![index]
                                        .cateringMenuItem![horIndex]);


                              else {


                                widget.newExtraItemList = <CateringExtraMenuItemModal>[];

                                showItemBottomSheet(controller
                                    .cateringMenuResData
                                    .value
                                    .data![0]
                                    .cateringMenu![index]
                                    .cateringMenuItem![horIndex]);
                              }



                          print('welcome');
                        }, borderRadius: 15, text: Strings.view),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      widget.originalExtraList = controller
                          .cateringMenuResData
                          .value
                          .data![0]
                          .cateringMenu![index]
                          .cateringMenuItem![horIndex]
                          .cateringMenuExtraSection!;


                      print('ceckRquiredItem'+checkOneOfitemIsRequired().toString());


                      if(  widget.originalExtraList.length>0)
                        _showExtraListBottomSheet(
                          controller
                              .cateringMenuResData
                              .value
                              .data![0]
                              .cateringMenu![index]
                              .cateringMenuItem![horIndex]
                              .cateringMenuExtraSection!,
                          controller
                              .cateringMenuResData
                              .value
                              .data![0]
                              .cateringMenu![index]
                              .cateringMenuItem![horIndex]);
                      else
                        {
                          widget.newExtraItemList = <CateringExtraMenuItemModal>[];

                          showItemBottomSheet(controller
                              .cateringMenuResData
                              .value
                              .data![0]
                              .cateringMenu![index]
                              .cateringMenuItem![horIndex]);
                        }


                    },
                    child: Padding(
                      padding: 40.paddingTop(),
                      child: Image.asset(
                        Images.addIcon,
                        height: 35,
                        width: 35,
                      ),
                    ),
                  ),
                ),
              ],
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

  Widget showTitleWidget(int i, String title, double size) {
    return GestureDetector(
      onTap: () {
        controller.cateringMenuResData.value.data![0].cateringMenu![i].index =
            controller.cateringMenuResData.value.data![0].cateringMenu![i]
                        .index ==
                    "1"
                ? "0"
                : "1";
        controller.cateringMenuResData.refresh();

        print('value' +
            controller
                .cateringMenuResData.value.data![0].cateringMenu![i].index!);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        shadowColor: Colors.black,
        elevation: 3,
        color: lightGrey,
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Padding(
            padding: 5.paddingAll(),
            child: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Center(
                      child: showText(
                          color: Colors.black,
                          text: title,
                          textSize: 15,
                          fontweight: FontWeight.w400,
                          maxlines: 1),
                    )),
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  empty() {
    return Container();
  }

  Future<void> _showExtraListBottomSheet(
      List<CateringMenuExtraSection> list, CateringMenuItem item) async {
    print('bottomsheetCalled');

    widget.originalExtraList = list;

   // print('ExtraItemBefore' + widget.extraItemList.toString());

    controller.selectedItems.clear();
    controller.enableAddToItemButton.value = false;

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
        return GetX<CateringMenuController>(builder: (controller) {
          return SingleChildScrollView(
              primary: true,
              child: Container(
                margin: 20.marginTop(),
                padding: 20.paddingBootom(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [showExtraList(list, item)],
                ),
              ));
        });
      }),
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    print('closeModal');
  }

  Widget showExtraList(
      List<CateringMenuExtraSection> list, CateringMenuItem item) {
    //vertical list
    return Padding(
      padding: 3.paddingAll(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showTopWidget(Strings.extraItem),
          10.horizontalSpace(),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (_, i) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showExtraMenuTitle(list[i].required!, list[i].name!),
                    10.horizontalSpace(),
                    Divider(
                      thickness: 1.5,
                      height: 6,
                    ),
                    _horizontalListViewBottom(list[i].required!, i, list),
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
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
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
                      style:
                          new TextStyle(fontSize: 16.0, color: Colors.white)),
                  onPressed: () {
                    if (controller.enableAddToItemButton.value)
                      addExtraItemToList(list, item);
                  }),
            ),
          )
        ],
      ),
    );
  }

  void addExtraItemToList(List<CateringMenuExtraSection> originalList,
      CateringMenuItem itemOriginal) async {
    widget.newExtraItemList = <CateringExtraMenuItemModal>[];

    print('loopSelectedList' + controller.selectedItems.toString());

    for (int i = 0; i < originalList.length; i++) {
      String title = originalList[i].name!;
      String restaurantId = originalList[i].restaurantId!;
      String restaurantMenuItemId = originalList[i].restaurantMenuItemId!;

      print('outerLoop');
      List<CateringMenuExtraItem>? item = originalList[i].cateringMenuExtraItem;

      for (int i = 0; i < item!.length; i++) {
        print('innerLoop');

        if (controller.selectedItems.contains(int.parse(item[i].id!))) {
          print('beforeIf' + controller.selectedItems.toString());

          widget.newExtraItemList.add(CateringExtraMenuItemModal(
            id: item[i].id,
            menuExtraItemName: item[i].name,
            menuExtraItemPrice: item[i].price,
            menuExtraItemQuantity: "1",
          ));

          //  print('loopRUn' + extraItemList.toString());
        }
      }
    }

    var compareCateringModal = CateringModal(
        id: itemOriginal.id,
        name: itemOriginal.name,
        price: itemOriginal.price,
        quantity:"1",
        extraItemList: widget.newExtraItemList);
    List<CateringModal> compareCateringList = [];
    compareCateringList.add(compareCateringModal);

    var flag = true;

    for (int i = 0; i < cartBox.length; i++) {
      CateringModal dbItem = cartBox.getAt(i)!;
      List<CateringModal> dbCateringList = [];
dbCateringList.add(dbItem);


    //  print('check'+ checkDuplicateItem(compareCateringModal,dbItem).toString());

      print('firstList'+compareCateringList.toString());
      print('secondList'+dbCateringList.toString());


      var check= compareCateringList[0].extraItemList!.length==dbCateringList[0].extraItemList!.length && _listsAreEqual(compareCateringList, dbCateringList);

      print('check2'+ check.toString());



      //duplicate item found
      if (checkDuplicateItem(compareCateringModal,dbItem,compareCateringList,dbCateringList)) {
        print('item_found_duplicate');
        flag = false;
        //update item of db
        updateCateringData(dbItem.id!);

        break;
      }



    }
    Get.back();
    //add new item to db; new item found
    if (flag) {
      print('item_found_new'+widget.newExtraItemList.length.toString());

      // addItemToDb(itemOriginal, widget.newExtraItemList);
      showItemBottomSheet(itemOriginal);
    }
  }



 bool checkDuplicateItem(CateringModal compareCateringModal,CateringModal dbItem, List<CateringModal> compareCateringList, List<CateringModal> dbCateringList){
   print('compareName'+compareCateringModal.name!);
   print('compareId'+compareCateringModal.id!);
   print('dbName'+dbItem.name!);
   print('dbID'+dbItem.id!);
   print('compareList'+compareCateringList[0].extraItemList.toString());
   print('dbList'+dbCateringList[0].extraItemList.toString());

    if(compareCateringModal.name==dbItem.name && compareCateringModal.id==dbItem.id  && compareCateringList[0].extraItemList!.length==dbCateringList[0].extraItemList!.length &&  _listsAreEqual(compareCateringList[0].extraItemList!, dbCateringList[0].extraItemList!)){
     return true;
   }

   return false;


   }


  bool _listsAreEqual(List one, List two) {
    var i = -1;
    return one.every((element) {
      i++;

      return two[i] == element;
    });
  }

  Widget _horizontalListViewBottom(
      String required, int i, List<CateringMenuExtraSection> list) {
    //controller.selectedItems.clear();

    return ListView.separated(
      shrinkWrap: true,
      primary: false,
    itemCount: list[i].cateringMenuExtraItem!.length,
      scrollDirection: Axis.vertical,
      /*itemBuilder: (data_,index) =>_buildBox(color: colorPrimary),*/
      itemBuilder: (_, index) {
        return Padding(
          padding: 5.paddingAll(),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                showMenuExtraItemTitle(
                    list,
                    required,
                    int.parse(
                      list[i].cateringMenuExtraItem![index].id!,
                    ),
                    i,
                    list[i].cateringMenuExtraItem![index].name!,
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
                            text: list[i].cateringMenuExtraItem![index].price!,
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

  showMenuExtraItemTitle(List<CateringMenuExtraSection> list, String required,
      int id, int index, String title, int flex) {
    print('titleKaif' + title + " " + required);
    print('selectedIndex' + controller.selectedItems.toString());

    return GetX<CateringMenuController>(builder: (controller) {
      return Expanded(
        flex: flex,
        child: GestureDetector(
          onTap: () {
            if (controller.selectedItems.contains(id)) {
              print('First');

              controller.selectedItems.removeWhere((val) => val == id);

              //  if(required=="1" && controller.selectedItems.length<=0)
              //  controller.enableAddToItemButton.value=false;

            } else {
              print('second');

              controller.selectedItems.add(id);

             // print('kaifkakf' + widget.extraItemList.toString());

              //if(required=="1")
              // controller.enableAddToItemButton.value=true;

            }

            enableAddToItemButton(list);

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

  void enableAddToItemButton(List<CateringMenuExtraSection> list) {
    HashMap<String, String> hashMap = new HashMap();
    var flag = false;

    for (int i = 0; i < list.length; i++) {
      List<CateringMenuExtraItem>? item = list[i].cateringMenuExtraItem;
      String required = list[i].required!;
      String name = list[i].name!;

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

   // print('kaifkakf' + widget.extraItemList.toString());
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

/*
  int getTotalThisProductCount(String? id) {
    int total = 0;
    for (var f in cartBox.values.where((item) => item.id! == id)) {
      if (f != null) {
        total++;
      }
    }

    print('getTotalCalled' + total.toString());

    controller.totalQty.value = total;

    return total;
  }
*/


  void showItemBottomSheet(CateringMenuItem item) {
    print('secondBottomCalled');

    //getTotalThisProductCount(item.id);
    controller.totalQty.value=0;


    Future<void> future = showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: false,
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
        return GetX<CateringMenuController>(
          builder: (controller) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              child: Padding(
                padding: 5.paddingAll(),
                child: Container(
                  height: 220,
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
                          Expanded(flex: 2, child: boxImage(item.image!)),
                          SizedBox(width: 10),
                          Expanded(
                              flex: 3,
                              child: Container(
                                height: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    showRestaurantName(item.name!),
                                    5.horizontalSpace(),
                                    showRestaurantPrice(item.price!),
                                    5.horizontalSpace(),
                                    showRestaurantDescription(item.description!),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      20.horizontalSpace(),
                      Row(
                        children: [
                          Expanded(flex: 1, child: showQuantity()),
                          Expanded(
                            flex: 1,
                            child: CustomButton(context,
                                height: 60,
                                textStyle:
                                    TextStyle(fontSize: 16, color: Colors.white),
                                borderRadius: 35,
                                text: Strings.add, onTap: () async {
                              addItemToDb(item, widget.newExtraItemList);
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }),
    );
    future.then((void value) => _closeModal(value));
  }

  Padding showQuantity() {
    return Padding(
      padding: 5.paddingAll(),
      child: Container(
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
                        if(controller.totalQty.value>0) {
                          controller.totalQty.value -= 1;
                          print('minus_clicked' + controller.totalQty.value
                              .toString());
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
                        controller.totalQty.value+=1;
                        print('plus_clicked'+controller.totalQty.value.toString());

                      },
                      child:
                          Icon(Icons.add, size: 30.0, color: Color(0xFF6D72FF)),
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
    );
  }

  Widget showRestaurantName(String name) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 0, left: 6.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: showText(
                color: colorPrimary,
                text: name,
                textSize: 20,
                fontweight: FontWeight.w600,
                maxlines: 1)),
      ),
    );
  }

  Widget showRestaurantPrice(String price) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 0, left: 6.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: RichText(
            maxLines: 1,
            text: TextSpan(
              text: "Price: ",
              style: TextStyle(color: Colors.black, fontSize: 16),
              children: <TextSpan>[
                TextSpan(
                    text: "R " + price, style: TextStyle(color: colorPrimary)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showRestaurantDescription(String description) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 0, left: 6.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: RichText(
            maxLines: 1,
            text: TextSpan(
              text: "Description: ",
              style: TextStyle(color: Colors.black, fontSize: 16),
              children: <TextSpan>[
                TextSpan(
                    text: description, style: TextStyle(color: colorPrimary)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget boxImage(String image) {
    return Container(
      margin: 5.marginAll(),
      child: CachedNetworkImage(
        imageUrl: ApiEndpoint.CATERING_MENU_ITEM_URL + image,
        imageBuilder: (context, imageProvider) {
          return categoryImage(
              imageProvider, double.infinity, 100, BoxShape.rectangle);
        },
        placeholder: (context, url) {
          return showPlaceholderImage(
              image: Images.cover_placeholder,
              width: double.infinity,
              height: 100);
        },
        errorWidget: (context, url, error) {
          return showPlaceholderImage(
              image: Images.cover_placeholder,
              width: double.infinity,
              height: 100);
        },
      ),
    );
  }

  void updateCateringData(String id) {
    print('updateId' + id);
    final Map<dynamic, CateringModal> deliveriesMap = cartBox.toMap();
    //  print('updateCartData' + deliveriesMap.toString());

    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.id == id) desiredKey = key;
    });

    print('UpdateParCalled' + desiredKey.toString());


    CateringModal? item = cartBox.get(desiredKey);


    item!.quantity = (int.parse(item.quantity!)+1).toString();

    print('newQuantity'+item.quantity!);

    // item.extraItemList = controller.extraItemList.value;

    print('thirdddd');

    cartBox.put(desiredKey, item);

    Strings.itemAdded.toast();


  }

  void addItemToDb(CateringMenuItem item,
      List<CateringExtraMenuItemModal> newExtraItemList) {
    print('addItemcalled');
    print('extraList' + widget.newExtraItemList.toString());
    print('newExtraItemList' + newExtraItemList.toString());

    late CateringModal cartModal;

    var uuid = Uuid();

    var rowId = uuid.v1();

    print('RowId' + rowId);

  /*  //only for first item
    if (controller.totalQty.value == 0) {
      if (checkOneOfitemIsRequired()) {
        if (widget.extraItemList.isEmpty) {
          "Please Add Extra Item".toast();
          return;
        }
      }
    }
*/
    if (controller.totalQty.value<=0) {
     Strings.selectQty.toast();
      return;
    }

    print('totalQty' + controller.totalQty.value.toString());



    cartModal = CateringModal(
        id: item.id!,
        name: item.name,
        price: item.price,
        quantity: controller.totalQty.value.toString(),
        extraItemList: newExtraItemList);

    cartBox.add(cartModal);
    Strings.itemAdded.toast();

    // controller.addToCartText.value = Strings.added;
    // controller.totalQty.value=1;

    print('extra_list_after_add' + newExtraItemList.toString());

    Get.back();

   // widget.newExtraItemList.clear();

  }

  bool checkOneOfitemIsRequired() {
    var flag = false;

    for (int i = 0; i < widget.originalExtraList.length; i++) {
      List<CateringMenuExtraItem>? item = widget.originalExtraList[i].cateringMenuExtraItem;
      String required = widget.originalExtraList[i].required!;
      String name = widget.originalExtraList[i].name!;

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

}
