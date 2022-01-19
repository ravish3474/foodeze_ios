import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodeze_flutter/animations/ShowUp.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/common/Strings.dart';
import 'package:foodeze_flutter/screen/PhoneWidget.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return WillPopScope(
      onWillPop: ()async{
        closeAPP();
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [

            Container(
              color: Colors.white,
              height: screenHeight(context),
              padding: 16.paddingAll(),
              width: screenWidth(context),
              child: ShowUp(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Image.asset(
                      Images.logo,
                      height: screenWidth(context) / 1.7,
                    ),
                    30.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.welcome),
                        16.horizontalSpace(),
                        Text(
                          Strings.appName,
                          style: GoogleFonts.poppins(
                              fontSize: 35, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),


                    Expanded(
                      child: ShowUp(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(context, height: 65,onTap: () {
                              print('welcome');
                              PhoneWidget().navigate();

                            },
                                icon: Images.phone,
                                borderRadius: 35,
                                text: Strings.continue_with_Number),

                            16.horizontalSpace(),



                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
