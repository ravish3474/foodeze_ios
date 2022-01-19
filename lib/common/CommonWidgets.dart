import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeze_flutter/base/network/UserRepository.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/screen/CreateEvent.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';

import 'Strings.dart';

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    print("NO_InterNEt");
    return false;
  }
  print("InterNEt");
  return true;
}

class inputTextFieldWidget extends StatefulWidget {
  TextEditingController controller;
  String title;
  Icon icon;
  TextInputType keyboardType;
  bool isEnable;
  double? height;

  inputTextFieldWidget({
    required this.controller,
    required this.title,
    required this.icon,
    required this.keyboardType,
    required this.isEnable,
     this.height,
  });

  @override
  _inputTextFieldWidgetState createState() => _inputTextFieldWidgetState();
}

class _inputTextFieldWidgetState extends State<inputTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff707070)),
          borderRadius: BorderRadius.circular(12)),
      child: TextField(
        onEditingComplete: () => getNode(context).nextFocus(),
        enabled: widget.isEnable,
        keyboardType: widget.keyboardType,
        maxLines: 1,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.title,
          labelStyle: TextStyle(color: Colors.black54),
          prefixIcon: widget.icon,
          hintText: widget.title,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

getNode(BuildContext context) {
  return FocusScope.of(context);
}

Widget noDataFoundWidget(
    double height, String imagePath, String errorMsg, bool showCreteButton) {
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
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                errorMsg,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            20.horizontalSpace(),
            showCreteButton
                ? Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: CustomButton(Get.context!,
                        height: 50,
                        isBorder: true,
                        borderColor: colorPrimary,
                        textStyle: TextStyle(fontSize: 16, color: colorPrimary),
                        borderRadius: 10,
                        text: Strings.creatNewEvent, onTap: () async {

                    }),
                  )
                : Container()
          ],
        ),
      ),
    ),
  );
}

Widget showCurfewMessage(
    double height, String imagePath, String title,String subTitle) {
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
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: colorPrimary, fontSize: 16),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20, right: 20,top: 10),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),

          ],
        ),
      ),
    ),
  );
}

Widget backButton() {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: colorPrimary,
      borderRadius: new BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: colorPrimary,
          offset: Offset(0.5, 0.5),
          blurRadius: 0.5,
        ),
      ],
    ),
    child: Padding(
        padding: 5.paddingAll(),
        child: Image.asset(
          Images.back,
          color: Colors.white,
          width: 40,
          height: 40,
        )),
  );
}

categoryImage(
  ImageProvider imageProvider,
  double width,
  double height,
  BoxShape shape,
) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      shape: shape,
      image: DecorationImage(
        image: imageProvider,
        fit: BoxFit.fill,
      ),
    ),
  );
}

categoryImageSecond(
  ImageProvider imageProvider,
  double width,
  double height,
  BoxShape shape,
) {
  return Container(
    margin: 3.marginAll(),
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: new BorderRadius.all(Radius.circular(5)),
      image: DecorationImage(
        image: imageProvider,
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget customIcon(
    {required IconData icon,
    Function? onTap,
    Color color = Colors.black,
    double margin = 8.0,
    double? size}) {
  return GestureDetector(
    onTap: () {
      onTap!();
    },
    child: Container(
        margin: EdgeInsets.all(margin),
        child: Icon(
          icon,
          color: color,
          size: size,
        )),
  );
}

Text showText(
    {required Color color,
    required String text,
    required double textSize,
    required FontWeight fontweight,
    required int maxlines}) {
  return Text(
    text,
    maxLines: maxlines,
    style: GoogleFonts.poppins(
        fontSize: textSize, fontWeight: fontweight, color: color),
  );
}

Image showPlaceholderImage(
    {required String image,
    required double width,
    required double height,
    BoxFit? fit}) {
  return Image.asset(
    image,
    width: width,
    height: height,
    fit: fit == null ? BoxFit.cover : BoxFit.fill,
  );
}


 showPlaceholderCircleImage(){
  return  ClipRRect(
    borderRadius: BorderRadius.circular(60.0),
    child: showPlaceholderImage(
      image: Images.cover_placeholder,
      width:double.infinity,
      height: 90,),
  );
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());

  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

void closeAPP() {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}


Widget CustomButton(BuildContext context,
    {String text = '',
      Function? onTap,
      String? icon,
      bool isActive = true,
      bool isBorder = false,
      Color? borderColor,
      bool isSingleColor = false,
      Color? color,
      double? width,
      double height = 45,
      EdgeInsetsGeometry margin = const EdgeInsets.all(0.0),
      TextStyle? textStyle,
      double borderRadius = 25.0}) {
  return InkWell(
    onTap: () {
      if (isActive) onTap!();
    },
    child: Container(
      height: height,
      margin: margin,
      child: Center(
        child: Row(
          mainAxisAlignment:
          icon == null ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            SizedBox(width: icon == null ? 0.0 : 45),
            icon == null ? SizedBox() : SvgPicture.asset(icon),
            SizedBox(width: icon == null ? 0.0 : 35),
            Padding(
              padding: 2.paddingAll(),
              child: Text(
                text,
                style: textStyle == null
                    ? GoogleFonts.poppins(
                    color: isBorder ? colorPrimary : Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0)
                    : textStyle,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: color,
        gradient: !isBorder
            ? color == null
            ? new LinearGradient(
            colors: [
              colorSecondPrimary,
              colorPrimary,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp)
            : null
            : null,
        border:
        isBorder ? Border.all(color: borderColor ?? colorPrimary) : null,
        borderRadius: new BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: !isBorder
            ? [
          BoxShadow(
            color: colorPrimary,
            offset: Offset(0, 3),
            blurRadius: 15,
          ),
        ]
            : null,
      ),
      width: width == null ? screenWidth(context) : width,
    ),
  );
}


Widget CustomButtonScroll(BuildContext context,
    {String text = '',
      Function? onTap,
      String? icon,
      bool isActive = true,
      bool isBorder = false,
      Color? borderColor,
      bool isSingleColor = false,
      Color? color,
      double? width,
      double height = 45,
      EdgeInsetsGeometry margin = const EdgeInsets.all(0.0),
      TextStyle? textStyle,
      double borderRadius = 25.0}) {


  return InkWell(
    onTap: () {
      if (isActive) onTap!();
    },
    child: Container(
      height: height,
      margin: margin,
      child: Center(
        child: Row(
          mainAxisAlignment:
          icon == null ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            SizedBox(width: icon == null ? 0.0 : 45),
            icon == null ? SizedBox() : SvgPicture.asset(icon),
            SizedBox(width: icon == null ? 0.0 : 35),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Padding(
                  padding: 2.paddingAll(),
                  child: Text(
                    text,
                    style: textStyle == null
                        ? GoogleFonts.poppins(
                        color: isBorder ? colorPrimary : Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0)
                        : textStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: color,
        gradient: !isBorder
            ? color == null
            ? new LinearGradient(
            colors: [
              colorSecondPrimary,
              colorPrimary,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp)
            : null
            : null,
        border:
        isBorder ? Border.all(color: borderColor ?? colorPrimary) : null,
        borderRadius: new BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: !isBorder
            ? [
          BoxShadow(
            color: colorPrimary,
            offset: Offset(0, 3),
            blurRadius: 15,
          ),
        ]
            : null,
      ),
      width: width == null ? screenWidth(context) : width,
    ),
  );
}


getAppVersion()async {
  PackageInfo packageInfo = PackageInfo(
    appName: 'foodeze',
    packageName: 'Unknown',
    version: '1.0',
    buildNumber: 'Unknown',
  );

  print('appVersion'+packageInfo.version);


  return  packageInfo.version;
}

getDevice() {

  if(Platform.isAndroid)
    return "android";

  return "ios";

}


customAlertDialog(BuildContext context,
    {Widget content = const Text('Pass sub widgets'),
    Function? function,
    String title = "",
    bool isActionButtonVisible = true,
    String actionText = 'OK',
    String canelText = 'Cancel'}) {
  if (Platform.isIOS)
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => new CupertinoAlertDialog(
              title: Text(title),
              content: Container(child: content),
              actions: isActionButtonVisible
                  ? <Widget>[
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        isDefaultAction: true,
                        child: Text(
                          canelText,
                          style: TextStyle(color: colorPrimary),
                        ),
                      ),
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                          function!();
                        },
                        isDefaultAction: true,
                        child: Text(
                          actionText,
                          style: TextStyle(color: colorPrimary),
                        ),
                      ),
                    ]
                  : <Widget>[],
            ));
  else
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => new AlertDialog(
            title: Text(title),
            actions: isActionButtonVisible
                ? <Widget>[
                    TextButton(
                      child: Text(
                        canelText,
                        style: TextStyle(color: colorPrimary),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                    TextButton(
                      child: Text(
                        actionText,
                        style: TextStyle(color: colorPrimary),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        function!();
                      },
                    ),
                  ]
                : <Widget>[],
            content: content));
}

successAlert(bool isImage, String fullImagePath, BuildContext context,
    String title, String image, String description) {
  CustomDialog(context,
      widget: !isImage
          ? Container(
              padding: 20.paddingAll(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 30.0,
                          color: Colors.black.withOpacity(0.47))),
                  16.horizontalSpace(),
                  Image.asset(
                    image,
                    width: screenWidth(context),
                    height: 150,
                  ),
                  30.horizontalSpace(),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.withOpacity(0.47)),
                    textAlign: TextAlign.center,
                  ),
                  30.horizontalSpace(),
                  CustomButton(context, height: 50, text: 'Ok', onTap: () {
                    Get.back();
                  }, width: screenWidth(context) / 2.8)
                ],
              ),
            )
          : Container(
              height: 290,
              padding: 10.paddingAll(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Padding(
                            padding: 3.paddingAll(),
                            child: Image.asset(Images.close_icon)),
                      )),
                  CachedNetworkImage(
                    imageUrl: fullImagePath,
                    imageBuilder: (context, imageProvider) {
                      return categoryImage(imageProvider, screenWidth(context),
                          230, BoxShape.rectangle);
                    },
                    placeholder: (context, url) {
                      return Container(
                        width: screenWidth(context),
                        height: 230,
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return showPlaceholderImage(
                          image: Images.cover_placeholder,
                          width: screenWidth(context),
                          height: 230);
                    },
                  ),
                ],
              ),
            ));
}

Widget CustomCircleImageView(
    {String? image,
    bool isNetwork = false,
    File? file,
    double height = 40,
    double width = 40,
    Function? function,
    EdgeInsets margin = const EdgeInsets.all(8.0),
    bool isCircle = true}) {
  return GestureDetector(
    child: Container(
        margin: margin,
        width: width,
        height: height,
        child: file != null
            ? CircleAvatar(
                radius: 30.0,
                backgroundImage: FileImage(file),
                backgroundColor: Colors.transparent,
              )
            : SizedBox(),
        decoration: file == null
            ? new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.cover, image: new AssetImage(image!)))
            : BoxDecoration()),
  );
}

Widget CustomNetworkCircleImageView(
    {required String image,
    bool isNetwork = false,
    double height = 40,
    double width = 40,
    Function? function,
    EdgeInsets margin = const EdgeInsets.all(2.0),
    bool isCircle = true}) {
  return GestureDetector(
    /* onTap: () {

      function();
    },*/
    child: Container(
        margin: margin,
        width: width,
        height: height,
        child: isNetwork
            ? CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(image),
                backgroundColor: Colors.transparent,
              )
            : SizedBox(),
        decoration: !isNetwork
            ? new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.cover, image: new AssetImage(image)))
            : BoxDecoration()),
  );
}

CustomDialog(BuildContext context,
    {bool barrierDismissible = true,
    var isLoader = false,
    Widget widget = const Text('Pass sub widgets'),
    int durationmilliseconds = 200}) async {
  await showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: barrierDismissible,
    barrierColor: textColor.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: durationmilliseconds),
    context: context,
    pageBuilder: (_, __, ___) {
      return isLoader
          ? widget
          : Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: getstatusBarHeight(context) * 2),
                child: Card(
                  child: widget,
                  margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}

successAlertSecond(context, String successMsg) {
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
              Images.done,
              width: screenWidth(context),
              height: 150,
            ),
            30.horizontalSpace(),
            Text(
              successMsg,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.withOpacity(0.47)),
              textAlign: TextAlign.center,
            ),
            30.horizontalSpace(),
            CustomButton(context, height: 50, text: 'Ok', onTap: () {
              hideKeyboard(context);
              Get.back();
            }, width: screenWidth(context) / 2.8)
          ],
        ),
      ));
}

Widget customCircleImageView(
    {String? image,
    bool isNetwork = false,
    File? file,
    double height = 40,
    double width = 40,
    Function? function,
    EdgeInsets margin = const EdgeInsets.all(8.0),
    bool isCircle = true}) {
  return GestureDetector(
    onTap: () {
      function!();
    },
    child: Container(
        margin: margin,
        width: width,
        height: height,
        child: file != null
            ? CircleAvatar(
                radius: 30.0,
                backgroundImage: FileImage(file),
                backgroundColor: Colors.transparent,
              )
            : SizedBox(),
        decoration: file == null
            ? new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.cover, image: new AssetImage(image!)))
            : BoxDecoration()),
  );
}

getUserId() async {
  var user = await getUser();

  return user!.msg!.id;
}

getUserProfile() async {
  var user = await getUser();

  return user!.msg!.profileImg;
}


getUserEmail() async {
  var user = await getUser();

  return user!.msg!.marketingMail;
}

getUserMobile() async {
  var user = await getUser();

  return user!.msg!.phone;
}

getUserName() async {
  var user = await getUser();

  return user!.msg!.firstName + " " + user.msg!.lastName;
}

CustomList<T>(
    {required Widget Function(T, int) child,
    @required List<T> list = const [],
    double itemSpace = 16,

    required bool shrinkWrap,
    ScrollController? scrollController,
    EdgeInsets padding = const EdgeInsets.all(0.0),
    Axis axis = Axis.vertical}) {
  return ListView.separated(
    padding: padding,
    controller: scrollController,
    shrinkWrap: shrinkWrap,
    clipBehavior: Clip.none,
    physics: BouncingScrollPhysics(),
    scrollDirection: axis,
    separatorBuilder: (contex, index) => SizedBox(
      width: axis == Axis.vertical ? 0 : itemSpace,
      height: axis == Axis.horizontal ? 0 : itemSpace,
    ),
    itemBuilder:
        (context, index) => //ViewWidget(snapshot.data.docments[index]),
            Container(child: child(list[index], index)),
    itemCount: list.length,
    //controller: listScrollController,
  );
}




