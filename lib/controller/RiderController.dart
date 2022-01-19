import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:foodeze_flutter/base/network/ApiHitter.dart';
import 'package:foodeze_flutter/common/Strings.dart';

import 'package:foodeze_flutter/modal/LoginModal.dart';
import 'package:foodeze_flutter/modal/RestrauListByCatModal.dart';
import 'package:foodeze_flutter/modal/UpdateModal.dart';
import 'package:foodeze_flutter/modal/UpdateProfileModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class RiderController extends GetxController {
  var repo = ApiRepo();


  TextEditingController commentController = TextEditingController();
  var rating=0.0.obs;



  Future<ApiResponse> rateDriverAPI(
      String from,
   String orderId,
   String restaurantId,
   String userId,
   String riderUserId,
   String star,
   String comment,) async {

  if(from==Strings.rider) {
    print('firstRun');
      return await repo.riderRateRepo(
        orderId: orderId,
        userId: userId,
        riderUserId: riderUserId,
        star: star,
        comment: comment,
      );
  }

  print('SecondRun'+restaurantId+" "+userId+" "+star+" "+comment  );

  return await repo.vkRateRepo(restaurantId: restaurantId,userId: userId,star: star,comment: comment,order_id:orderId);

  }




}
