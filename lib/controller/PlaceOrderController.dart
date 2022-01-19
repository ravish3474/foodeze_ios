import 'dart:convert';
import 'dart:io';

import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/modal/ApiResponseNew.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class PlaceOrderController extends GetxController {
  var repo = ApiRepo();

  Future<dynamic> placeOrderAPI(
    String data,
  ) async {
    print('input' + data);

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse(ApiEndpoint.BASE_URL2));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(data));
    HttpClientResponse response = await request.close();

    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    //  print('salluRes' + reply);

    httpClient.close();
    return reply;
  }

  Future<ApiResponseNew> payCateringAPI(
      {required String cateringId, required String paymentId}) async {
    print('payCateringAPI_called' + cateringId + " " + paymentId);
    var dataRes = await repo.payCateringRepo(
        cateringId: cateringId, paymentId: paymentId);

    return dataRes;
  }

  Future<ApiResponseNew> payEventAPI(
      { required String eventId,
        required String customerId,
        required String noOfPerson,
        required String totalAmount,
        required String restaurantId,
        required String referenceNo,
        required String paymentStatus}) async {
    print('payEventAPI_called');
    print('eventId'+eventId);
    print('customerId'+customerId);
    print('noOfPerson'+noOfPerson);
    print('totalAmount'+totalAmount);
    print('restaurantId'+restaurantId);
    print('referenceNo'+referenceNo);
    print('paymentStatus'+paymentStatus);
    var dataRes = await repo.payEventRepo(
        eventId: eventId,
        customerId: customerId,
        noOfPerson: noOfPerson,
        totalAmount: totalAmount,
        restaurantId: restaurantId,
        referenceNo: referenceNo,
        paymentStatus: paymentStatus);

    return dataRes;
  }
}
