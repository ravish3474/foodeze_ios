import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/base/constants/PrefConstant.dart';
import 'package:foodeze_flutter/base/network/ApiHitter.dart';
import 'package:foodeze_flutter/base/network/UserRepository.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/CustomTextField.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/controller/AuthController.dart';
import 'package:foodeze_flutter/controller/ProfileDetailController.dart';
import 'package:foodeze_flutter/controller/RiderController.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';
import 'package:foodeze_flutter/screen/CountryListDialog.dart';
import 'package:foodeze_flutter/screen/HomePage.dart';
import 'package:foodeze_flutter/screen/OTPVerification.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RateScreen extends StatefulWidget {

  String from;
  String restaurantId;
  String customerOrderId;

  RateScreen(this.from,this.customerOrderId,this.restaurantId);

  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  RiderController controller = Get.put(RiderController());

var successStatus=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('resId'+widget.restaurantId);

    setDefaultCommentAndRate();
  }

  void setDefaultCommentAndRate() {
    controller.commentController.text=" ";
    controller.rating.value=0.0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{

          pressBack(result: successStatus.toString());
          return true;

      },
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,

            body: GetX<RiderController>(
              builder: (controller) {
                return Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      height: screenHeight(context),
                      padding: 16.paddingAll(),
                      width: screenWidth(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          showTopWidget(),
                          ShowUp(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.horizontalSpace(),
                                Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(Images.logo)),
                                10.horizontalSpace(),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    Strings.placedOrder,
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),

                                10.horizontalSpace(),

                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    Strings.kindlyRate,
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, fontWeight: FontWeight.bold,color: colorPrimary),
                                  ),
                                ),

                                10.horizontalSpace(),
                                showRatingBar(),

                                20.horizontalSpace(),

                                commentWidget(),
                                20.horizontalSpace(),





                              ],
                            ),
                          ),
                          20.horizontalSpace(),
                          Expanded(
                            child: ShowUp(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  35.horizontalSpace(),
                                  CustomButton(context,
                                      height: 55,
                                      borderRadius: 35,
                                      text: Strings.submit,
                                      onTap: () async {
                                        print('submittt');
                                    if (validate()) {
                                      if (await checkInternet()) {
                                        launchProgress(context: context);



                                       var  res = await controller.rateDriverAPI(
                                          widget.from,
                                            widget.customerOrderId,
                                         widget.from==Strings.rider? "restua_id":widget.restaurantId,
                                          await getUserId(),
                                          "2",
                                          controller.rating.value.toString(),
                                          controller.commentController.getValue());




                                        print('resultkaif' + res.status.toString());
                                        disposeProgress();
                                        if (res.status == "1") {


                                          successAlert(context);
                                        }
                                        else {

                                          hideKeyboard(context);
                                          Strings.went_wrong.toast();
                                        }
                                      }
                                      else
                                        Strings.checkInternet.toast();
                                    }

                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
            )),
      ),
    );
  }

  showRatingBar() {


    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.center,
        child: RatingBar.builder(
          initialRating: controller.rating.value,
          minRating: 1,
          glowColor: colorPrimary,
          ignoreGestures: false,
          maxRating: 5,
          itemSize: 45,
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
            controller.rating.value=rating;
          },
        ),
      ),
    );
  }

  Widget  showTopWidget()  {
    return Row(
      children: [
        backButton().pressBack(result:  successStatus.toString()),
        15.verticalSpace(),
        showText(
            color: Colors.black,
            text:widget.from==Strings.rider?Strings.riderRate:Strings.kithchenRate,
            textSize: 20,
            fontweight: FontWeight.w400,
            maxlines: 1)
      ],
    );
  }

  Widget commentWidget() {



  return   Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
    decoration: BoxDecoration(
        border: Border.all(color: Color(0xff707070)),
        borderRadius: BorderRadius.circular(12)),
    child: TextField(
      controller:  controller.commentController,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: Strings.comment,
          labelStyle: TextStyle(color: Colors.black54),
          hintText: Strings.comment,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
  );

  }




  bool validate() {
    String comment = controller.commentController.getValue();


    if (controller.rating.value<=0.0) {
      "Please give rating".toast();
      return false;
    }

    if (comment.trim().isEmpty) {
      "Please enter comment".toast();
      return false;
    }


    return true;
  }




  successAlert(context) {
    CustomDialog(context,
        barrierDismissible: false,
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
               Strings.success_rate,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.withOpacity(0.47)),
                textAlign: TextAlign.center,
              ),
              30.horizontalSpace(),
              CustomButton(context, height: 50, text: 'Ok', onTap: () {



                hideKeyboard(context);

                successStatus=true;

                Get.back();
                Get.back(result: successStatus.toString());

              //  setDefaultCommentAndRate();


              }, width: screenWidth(context) / 2.8)

            ],
          ),
        ));
  }



}
