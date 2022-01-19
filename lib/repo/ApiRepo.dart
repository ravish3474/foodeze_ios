import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:foodeze_flutter/base/BaseRepository.dart';
import 'package:foodeze_flutter/base/constants/ApiEndpoint.dart';
import 'package:foodeze_flutter/base/network/ApiHitter.dart';
import 'package:foodeze_flutter/modal/ApiResponseNew.dart';
import 'package:foodeze_flutter/modal/AvailableLocModal.dart';
import 'package:foodeze_flutter/modal/CateringFetchRequest.dart';
import 'package:foodeze_flutter/modal/CouponModal.dart';
import 'package:foodeze_flutter/modal/CreateTicketModal.dart';
import 'package:foodeze_flutter/modal/CustomerTicketsModal.dart';
import 'package:foodeze_flutter/modal/EventHistoryModal.dart';
import 'package:foodeze_flutter/modal/EventModal.dart';
import 'package:foodeze_flutter/modal/FetchAddressModal.dart';
import 'package:foodeze_flutter/modal/FetchCateringMenuModal.dart';
import 'package:foodeze_flutter/modal/FetchCateringResModal.dart';
import 'package:foodeze_flutter/modal/FetchOrderChatModal.dart';
import 'package:foodeze_flutter/modal/KitcheModal.dart';
import 'package:foodeze_flutter/modal/LoginModal.dart';
import 'package:foodeze_flutter/modal/NotificationModal.dart';
import 'package:foodeze_flutter/modal/OrderHistoryModal.dart';
import 'package:foodeze_flutter/modal/OrderStatusiModal.dart';
import 'package:foodeze_flutter/modal/RestrauListByCatModal.dart';
import 'package:foodeze_flutter/modal/SearchModal.dart';
import 'package:foodeze_flutter/modal/UpdateModal.dart';
import 'package:foodeze_flutter/modal/UpdateProfileModal.dart';
import 'package:foodeze_flutter/modal/ViewCateringDetails.dart';
import 'package:foodeze_flutter/modal/ViewTicketChatModal.dart';
import 'package:foodeze_flutter/modal/VirtualKitchenModal.dart';
import 'package:path/path.dart';

class ApiRepo extends BaseRepository {
  Future<LoginModal> mobilelogin({
    required String mobileNo,
  }) async {
    var formData = FormData();
    formData.fields.add(MapEntry('mobile', mobileNo));

    var params = ApiEndpoint.LOGIN;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);

      print('mobilelogin' + userdata.toString());

      // var  movieList = LoginModal.fromJson(userdata);
      //print('statuskaif'+movieList.otp.toString());

      if (apiResponse.status == "1") {
        return LoginModal.fromMap(userdata);
      } else {
        return LoginModal(status: '0', otp: -1);
      }
    } catch (error) {
      try {
        return LoginModal(status: '400', otp: -1);
      } catch (e) {
        return LoginModal(status: '400', otp: -1);
      }
    }
  }

  Future<UpdateModal> updateProfile({
    required String userId,
    required String fName,
    required String lName,
    required String email,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('user_id', userId));
    formData.fields.add(MapEntry('first_name', fName));
    formData.fields.add(MapEntry('last_name', lName));
    formData.fields.add(MapEntry('email', email));

    var params = ApiEndpoint.UPDATE_PROFILE;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('updateProfile' + userdata.toString());

      if (apiResponse.status == "1") {
        return UpdateModal.fromMap(userdata);
      } else {
        return UpdateModal(status: '0', msg: "error");
      }
    } catch (error) {
      try {
        return UpdateModal(status: '400', msg: "error");
      } catch (e) {
        return UpdateModal(status: '400', msg: "error");
      }
    }
  }


Future<ApiResponseNew> updateDeviceTokenRepo({
    required String userId,
    required String deviceToken,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('user_id', userId));
    formData.fields.add(MapEntry('device_token', deviceToken));

    var params = ApiEndpoint.UPDATE_DEVICE_TOKEN;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('updateProfile' + userdata.toString());

      if (apiResponse.status == "1") {
        return ApiResponseNew.fromMap(userdata);
      } else {
        return ApiResponseNew(status: '0', );
      }
    } catch (error) {
      try {
        return ApiResponseNew(status: '400', );
      } catch (e) {
        return ApiResponseNew(status: '400', );
      }
    }
  }

  Future<ApiResponse> addAddressRepo({
    required String userId,
    required String street,
    required String apartment,
    required String city,
    required String state,
    required String country,
    required String zipcode,
    required String instructions,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('user_id', userId));
    formData.fields.add(MapEntry('street', street));
    formData.fields.add(MapEntry('apartment', apartment));
    formData.fields.add(MapEntry('city', city));
    formData.fields.add(MapEntry('state', state));
    formData.fields.add(MapEntry('country', country));
    formData.fields.add(MapEntry('zipcode', zipcode));
    formData.fields.add(MapEntry('instructions', instructions));

    var params = ApiEndpoint.ADD_ADDRESS;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('updateProfile' + userdata.toString());
      var status = userdata['status'];
      print('statuskaif' + status);
      if (apiResponse.status == "1") {
        return ApiResponse(status);
      } else {
        return ApiResponse("0");
      }
    } catch (error) {
      try {
        return ApiResponse("400");
      } catch (e) {
        return ApiResponse("400");
      }
    }
  }

  Future<FetchAddressModal> fetchAddressRepo({
    required String userId,
  }) async {
    var formData = FormData();
    formData.fields.add(MapEntry('user_id', userId));

    var params = ApiEndpoint.FETCH_ADDRESSES;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchAddressRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return FetchAddressModal.fromMap(userdata);
      } else {
        return FetchAddressModal(status: '0');
      }
    } catch (error) {
      try {
        return FetchAddressModal(status: '400');
      } catch (e) {
        return FetchAddressModal(status: '400');
      }
    }
  }

  Future<AvailableLocModal> fetchAvailableLocationRepo({
    required String userId,
    required String lat,
    required String long,
  }) async {
    var formData = FormData();
    formData.fields.add(MapEntry('user_id', userId));
    formData.fields.add(MapEntry('lat', lat));
    formData.fields.add(MapEntry('long', long));

    var params = ApiEndpoint.AVAILABLE_LOCATIONS;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchAddressRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return AvailableLocModal.fromMap(userdata);
      } else {
        return AvailableLocModal(status: '0');
      }
    } catch (error) {
      try {
        return AvailableLocModal(status: '400');
      } catch (e) {
        return AvailableLocModal(status: '400');
      }
    }
  }

  Future<CouponModal> getCouponRepo({
    required String couponCode,
  }) async {
    var formData = FormData();
    formData.fields.add(MapEntry('coupon_code', couponCode));

    var params = ApiEndpoint.COUPON_CODE;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('getCouponRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return CouponModal.fromMap(userdata);
      } else {
        return CouponModal(status: '0');
      }
    } catch (error) {
      try {
        return CouponModal(status: '400');
      } catch (e) {
        return CouponModal(status: '400');
      }
    }
  }

  Future<ApiResponse> deleteAddressRepo({
    required String addressId,
  }) async {
    var formData = FormData();
    formData.fields.add(MapEntry('address_id', addressId));

    var params = ApiEndpoint.DELETE_ADDRESS;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('deleteAddressRepo' + userdata.toString());

      var status = userdata['status'];
      print('statuskaif' + status);

      if (apiResponse.status == "1") {
        return ApiResponse(status);
      } else {
        return ApiResponse("0");
      }
    } catch (error) {
      try {
        return ApiResponse("400");
      } catch (e) {
        return ApiResponse("400");
      }
    }
  }

  Future<ApiResponse> riderRateRepo({
    required String orderId,
    required String userId,
    required String riderUserId,
    required String star,
    required String comment,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('order_id', orderId));
    formData.fields.add(MapEntry('user_id', userId));
    formData.fields.add(MapEntry('rider_user_id', riderUserId));
    formData.fields.add(MapEntry('star', star));
    formData.fields.add(MapEntry('comment', comment));

    var params = ApiEndpoint.RATE_DRIVER;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('riderRateRepo' + userdata.toString());

      var status = userdata['status'];
      print('statuskaif' + status);

      if (apiResponse.status == "1") {
        return ApiResponse(status);
      } else {
        return ApiResponse("0");
      }
    } catch (error) {
      try {
        return ApiResponse("400");
      } catch (e) {
        return ApiResponse("400");
      }
    }
  }

  Future<ApiResponse> vkRateRepo({
    required String restaurantId,
    required String userId,
    required String star,
    required String comment,
    required String order_id,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('restaurant_id', restaurantId));
    formData.fields.add(MapEntry('user_id', userId));
    formData.fields.add(MapEntry('star', star));
    formData.fields.add(MapEntry('comment', comment));
    formData.fields.add(MapEntry('order_id', order_id));

    var params = ApiEndpoint.RATE_VK;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('vkRateRepo' + userdata.toString());

      var status = userdata['status'];
      print('statuskaif' + status);

      if (apiResponse.status == "1") {
        return ApiResponse(status);
      } else {
        return ApiResponse("0");
      }
    } catch (error) {
      try {
        return ApiResponse("400");
      } catch (e) {
        return ApiResponse("400");
      }
    }
  }

  Future<UpdateModal> createEventRepo({
    required String userId,
    required String eventTitle,
    required String eventDescription,
    required String kitchenId,
    required String eventDate,
    required String eventHours,
    required String eventMenu,
    required String foodQuantity,
    required String eventLocation,
    required String eventCity,
    required String eventProvince,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('user_id', userId));
    formData.fields.add(MapEntry('event_title', eventTitle));
    formData.fields.add(MapEntry('event_description', eventDescription));
    formData.fields.add(MapEntry('kitchen_id', kitchenId));
    formData.fields.add(MapEntry('event_date', eventDate));
    formData.fields.add(MapEntry('event_hours', eventHours));
    formData.fields.add(MapEntry('event_menu', eventMenu));
    formData.fields.add(MapEntry('food_quantity', foodQuantity));
    formData.fields.add(MapEntry('event_location', eventLocation));
    formData.fields.add(MapEntry('event_city', eventCity));
    formData.fields.add(MapEntry('event_province', eventProvince));

    var params = ApiEndpoint.CREATE_EVENT;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('createEventRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return UpdateModal.fromMap(userdata);
      } else {
        return UpdateModal(status: '0', msg: "error");
      }
    } catch (error) {
      try {
        return UpdateModal(status: '400', msg: "error");
      } catch (e) {
        return UpdateModal(status: '400', msg: "error");
      }
    }
  }

  Future<FetchCateringResModal> fetchCateringRestaurantRepo() async {
    var formData = FormData();

    var params = ApiEndpoint.FETCH_CATERING_RESTAURANT;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchCateringRestaurantRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return FetchCateringResModal.fromJson(userdata);
      } else {
        return FetchCateringResModal(
          status: '0',
        );
      }
    } catch (error) {
      try {
        return FetchCateringResModal(
          status: '400',
        );
      } catch (e) {
        return FetchCateringResModal(
          status: '400',
        );
      }
    }
  }

  Future<ViewCateringDetails> fetchCateringDetailsRepo(
      {required String orderId, required String restaurantId}) async {
    var formData = FormData();

    formData.fields.add(MapEntry('order_id', orderId));
    formData.fields.add(MapEntry('restaurant_id', restaurantId));

    var params = ApiEndpoint.VIEW_CATERING_DETAILS;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchCateringRestaurantRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return ViewCateringDetails.fromJson(userdata);
      } else {
        return ViewCateringDetails(
          code: 0,
        );
      }
    } catch (error) {
      try {
        return ViewCateringDetails(
          code: 400,
        );
      } catch (e) {
        return ViewCateringDetails(
          code: 400,
        );
      }
    }
  }

  Future<ApiResponseNew> payCateringRepo(
      {required String cateringId, required String paymentId}) async {
    var formData = FormData();

    formData.fields.add(MapEntry('catering_id', cateringId));
    formData.fields.add(MapEntry('payment_id', paymentId));

    var params = ApiEndpoint.PAY_CATERING;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('payCateringRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return ApiResponseNew(
          status: "1",
        );
      } else {
        return ApiResponseNew(
          status: "0",
        );
      }
    } catch (error) {
      try {
        return ApiResponseNew(
          status: "0",
        );
      } catch (e) {
        return ApiResponseNew(
          status: "0",
        );
      }
    }
  }


  Future<ApiResponseNew> payEventRepo(
      {
        required String eventId,
        required String customerId,
        required String noOfPerson,
        required String totalAmount,
        required String restaurantId,
        required String referenceNo,
        required String paymentStatus

      }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('event_id', eventId));
    formData.fields.add(MapEntry('customer_id', customerId));
    formData.fields.add(MapEntry('no_of_person', noOfPerson));
    formData.fields.add(MapEntry('total_amount', totalAmount));
    formData.fields.add(MapEntry('restaurant_id', restaurantId));
    formData.fields.add(MapEntry('reference_no', referenceNo));
    formData.fields.add(MapEntry('payment_status', paymentStatus));

    var params = ApiEndpoint.PAY_EVENT;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('payEventRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return ApiResponseNew(
          status: "1",
        );
      } else {
        return ApiResponseNew(
          status: "0",
        );
      }
    } catch (error) {
      try {
        return ApiResponseNew(
          status: "0",
        );
      } catch (e) {
        return ApiResponseNew(
          status: "0",
        );
      }
    }
  }

  Future<FetchCateringMenuModal> fetchCateringMenuRepo(
      {required String restaurantId, required String currentTime}) async {
    var formData = FormData();
    formData.fields.add(MapEntry('restaurant_id', restaurantId));
    formData.fields.add(MapEntry('current_time', currentTime));

    var params = ApiEndpoint.FETCH_CATERING_MENU;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchCateringMenuRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return FetchCateringMenuModal.fromJson(userdata);
      } else {
        return FetchCateringMenuModal(
          status: '0',
        );
      }
    } catch (error) {
      try {
        return FetchCateringMenuModal(
          status: '400',
        );
      } catch (e) {
        return FetchCateringMenuModal(
          status: '400',
        );
      }
    }
  }

  Future<CateringFetchRequest> fetchCateringRequestRepo(
      {required String userId}) async {
    var formData = FormData();
    formData.fields.add(MapEntry('user_id', userId));

    var params = ApiEndpoint.FETCH_CATERING_REQUEST;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchCateringMenuRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return CateringFetchRequest.fromJson(userdata);
      } else {
        return CateringFetchRequest(
          status: '0',
        );
      }
    } catch (error) {
      try {
        return CateringFetchRequest(
          status: '400',
        );
      } catch (e) {
        return CateringFetchRequest(
          status: '400',
        );
      }
    }
  }

  Future<ApiResponseNew> deleteCateringReqRepo(
      {required String orderId}) async {
    var formData = FormData();
    formData.fields.add(MapEntry('order_id', orderId));

    var params = ApiEndpoint.DELETE_CATERING_REQUEST;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchCateringMenuRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return ApiResponseNew(
          status: '1',
        );
      } else {
        return ApiResponseNew(
          status: '0',
        );
      }
    } catch (error) {
      try {
        return ApiResponseNew(
          status: '400',
        );
      } catch (e) {
        return ApiResponseNew(
          status: '400',
        );
      }
    }
  }

  Future<ApiResponseNew> sendCateringRequestRepo(
      {required String eventDescription,
      required String timeDate,
      required String duration,
      required String restaurantId,
      required String eventLocation,
      required String eventCity,
      required String eventProvince,
      required String deliveryPickup,
      required String deliveryTime,
      required String comment,
      required String userId,
      required String androidVersion,
      required String eventTitle,
      required String tax,
      required String subtotal,
      required String jsonCheck}) async {
    var formData = FormData();

    formData.fields.add(MapEntry('event_description', eventDescription));
    formData.fields.add(MapEntry('time_date', timeDate));
    formData.fields.add(MapEntry('duration', duration));
    formData.fields.add(MapEntry('restaurant_id', restaurantId));
    formData.fields.add(MapEntry('event_location', eventLocation));
    formData.fields.add(MapEntry('event_city', eventCity));
    formData.fields.add(MapEntry('event_province', eventProvince));
    formData.fields.add(MapEntry('delivery_pickup', deliveryPickup));
    formData.fields.add(MapEntry('delivery_time', deliveryTime));
    formData.fields.add(MapEntry('comment', comment));
    formData.fields.add(MapEntry('user_id', userId));
    formData.fields.add(MapEntry('android_version', androidVersion));
    formData.fields.add(MapEntry('event_title', eventTitle));
    formData.fields.add(MapEntry('tax', tax));
    formData.fields.add(MapEntry('subtotal', subtotal));
    formData.fields.add(MapEntry('json_check', jsonCheck));

    var params = ApiEndpoint.SEND_CATERING_REQUEST;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchCateringMenuRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return ApiResponseNew(
          status: '1',
        );
      } else {
        return ApiResponseNew(
          status: '0',
        );
      }
    } catch (error) {
      try {
        return ApiResponseNew(
          status: '400',
        );
      } catch (e) {
        return ApiResponseNew(
          status: '400',
        );
      }
    }
  }

  Future<UpdateProfileModal> updateUserIamgeRepo({
    required String userId,
    required String image,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('user_id', userId));
    formData.files.add(MapEntry("profile_pic",
        await MultipartFile.fromFile(image, filename: basename(image))));

    var params = ApiEndpoint.UPDATE_USER_IMAGE;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
    print('updateUserIamgeRepo' + userdata.toString());

    if (apiResponse.status == "1") {
      return UpdateProfileModal.fromMap(userdata);
    } else {
      return UpdateProfileModal();
    }
  }

  Future<dynamic> kitcheRepo({
    required String userId,
    required String latitude,
    required String longitude,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('user_id', userId));
    formData.fields.add(MapEntry('latitude', latitude));
    formData.fields.add(MapEntry('longitude', longitude));

    var params = ApiEndpoint.KITCHEN_LIST;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('kitcheRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return KitcheModal.fromMap(userdata);
      } else {
        return KitcheModal();
      }
    } catch (error) {
      print('kitcheRepo_Excep' + error.toString());
      try {
        return null;
      } catch (e) {
        return null;
      }
    }
  }

  Future<void> addFavandUnfavRepo({
    required String? restaurantId,
    required String? userId,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('restaurant_id', restaurantId!));
    formData.fields.add(MapEntry('user_id', userId!));

    var params = ApiEndpoint.addFavandUNfav;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('FavrouiteResponse' + userdata.toString());
    } catch (error) {
      print('FavrouiteResponse_error');
    }
  }

  Future<NotificationModal> fetchNotificationsRepo() async {
    var formData = FormData();

    var params = ApiEndpoint.FETCH_NOTIFICATION;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);

      print('fetchNotificationsRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return NotificationModal.fromMap(userdata);
      } else {
        return NotificationModal(status: '0');
      }
    } catch (error) {
      try {
        return NotificationModal(status: '400');
      } catch (e) {
        return NotificationModal(status: '400');
      }
    }
  }

  Future<EventModal> fetchAllEventsRepo() async {
    var formData = FormData();

    var params = ApiEndpoint.FETCH_ALL_EVENS;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);

      print('fetchAllEventsRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return EventModal.fromMap(userdata);
      } else {
        return EventModal(status: '0');
      }
    } catch (error) {
      try {
        return EventModal(status: '400');
      } catch (e) {
        return EventModal(status: '400');
      }
    }
  }

  Future<EventHistoryModal> fetchEventsHistoryRepo(String userId) async {
    var formData = FormData();

    formData.fields.add(MapEntry('user_id', userId));
    var params = ApiEndpoint.FETCH_EVENT_TRANSACTION;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);

      print('fetchEventsHistoryRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return EventHistoryModal.fromMap(userdata);
      } else {
        return EventHistoryModal(status: '0');
      }
    } catch (error) {
      try {
        return EventHistoryModal(status: '400');
      } catch (e) {
        return EventHistoryModal(status: '400');
      }
    }
  }

  Future<OrderHistoryModal> fetchCustomerOrdersRepo(String userId) async {
    var formData = FormData();

    formData.fields.add(MapEntry('user_id', userId));
    var params = ApiEndpoint.FETCH_CUSTOMERS_ORDER;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);

      print('fetchCustomerOrdersRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return OrderHistoryModal.fromMap(userdata);
      } else {
        return OrderHistoryModal(status: '0');
      }
    } catch (error) {
      try {
        return OrderHistoryModal(status: '400');
      } catch (e) {
        return OrderHistoryModal(status: '400');
      }
    }
  }

  Future<CustomerTicketsModal> fetchCustomerChatTicketsRepo(
      String customerId) async {
    var formData = FormData();

    formData.fields.add(MapEntry('customer_id', customerId));
    var params = ApiEndpoint.FETCH_CUSTOMER_TICKETS;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);

      print('fetchCustomerChatTicketsRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return CustomerTicketsModal.fromMap(userdata);
      } else {
        return CustomerTicketsModal(status: '0');
      }
    } catch (error) {
      try {
        return CustomerTicketsModal(status: '400');
      } catch (e) {
        return CustomerTicketsModal(status: '400');
      }
    }
  }

  Future<ViewTicketChatModal> fetchViewTicketChatRepo(String ticketId) async {
    var formData = FormData();

    formData.fields.add(MapEntry('ticket_id', ticketId));
    var params = ApiEndpoint.FETCH_VIEW_TICKET_CHAT;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchViewTicketChatRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return ViewTicketChatModal.fromMap(userdata);
      } else {
        return ViewTicketChatModal(status: '0');
      }
    } catch (error) {
      try {
        return ViewTicketChatModal(status: '400');
      } catch (e) {
        return ViewTicketChatModal(status: '400');
      }
    }
  }

  Future<FetchOrderChatModal> fetchOrderChatRepo(String orderId) async {
    var formData = FormData();

    formData.fields.add(MapEntry('order_id', orderId));
    var params = ApiEndpoint.FETCH_ORDER_CHAT;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchOrderChatRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return FetchOrderChatModal.fromMap(userdata);
      } else {
        return FetchOrderChatModal(status: '0');
      }
    } catch (error) {
      try {
        return FetchOrderChatModal(status: '400');
      } catch (e) {
        return FetchOrderChatModal(status: '400');
      }
    }
  }

  Future<OrderStatusiModal> fetchOrderStatusRepo(
      String orderId, String customerId) async {
    var formData = FormData();

    print('cusId'+customerId);

    formData.fields.add(MapEntry('order_id', orderId));
    formData.fields.add(MapEntry('customer_id', customerId));
    var params = ApiEndpoint.fetchOrderStatus;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchOrderStatusRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return OrderStatusiModal.fromJson(userdata);
      } else {
        return OrderStatusiModal(status: '0');
      }
    } catch (error) {
      try {
        return OrderStatusiModal(status: '400');
      } catch (e) {
        return OrderStatusiModal(status: '400');
      }
    }
  }

  Future<ViewTicketChatModal> addChatToTicketRepo(
      String ticketId, String customerId, String message) async {
    var formData = FormData();

    formData.fields.add(MapEntry('ticket_id', ticketId));
    formData.fields.add(MapEntry('customer_id', customerId));
    formData.fields.add(MapEntry('message', message));
    var params = ApiEndpoint.ADD_CHAT_TO_TICKET;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);

      print('addChatToTicketRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return ViewTicketChatModal.fromMap(userdata);
      } else {
        return ViewTicketChatModal(status: '0');
      }
    } catch (error) {
      try {
        return ViewTicketChatModal(status: '400');
      } catch (e) {
        return ViewTicketChatModal(status: '400');
      }
    }
  }

  Future<ViewTicketChatModal> sendCustomerToRiderChatRepo(
    String customerId,
    String riderId,
    String orderId,
    String fromCustomer,
    String message,
  ) async {
    var formData = FormData();

    formData.fields.add(MapEntry('customer_id', customerId));
    formData.fields.add(MapEntry('rider_id', riderId));
    formData.fields.add(MapEntry('order_id', orderId));
    formData.fields.add(MapEntry('from_customer', fromCustomer));
    formData.fields.add(MapEntry('message', message));
    var params = ApiEndpoint.CUSTOMER_RIDER_CHAT;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);

      print('sendCustomerToRiderChat' + userdata.toString());

      if (apiResponse.status == "1") {
        return ViewTicketChatModal.fromMap(userdata);
      } else {
        return ViewTicketChatModal(status: '0');
      }
    } catch (error) {
      try {
        return ViewTicketChatModal(status: '400');
      } catch (e) {
        return ViewTicketChatModal(status: '400');
      }
    }
  }

  Future<CreateTicketModal> createTicketRepo(
      String customerId, String subject) async {
    var formData = FormData();

    formData.fields.add(MapEntry('customer_id', customerId));
    formData.fields.add(MapEntry('subject', subject));
    var params = ApiEndpoint.CREATE_TICKET;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('createTicketRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return CreateTicketModal.fromMap(userdata);
      } else {
        return CreateTicketModal(status: '0');
      }
    } catch (error) {
      try {
        return CreateTicketModal(status: '400');
      } catch (e) {
        return CreateTicketModal(status: '400');
      }
    }
  }

  Future<VirtualKitchenModal> fetchVirtualKitchenRepo({
    required String? restaurant_id,
    required String current_time,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('restaurant_id', restaurant_id!));
    formData.fields.add(MapEntry('current_time', current_time));

    var params = ApiEndpoint.FETCH_MENU;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchVirtualKitchenRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return VirtualKitchenModal.fromMap(userdata);
      } else {
        return VirtualKitchenModal(status: '0');
      }
    } catch (error) {
      try {
        return VirtualKitchenModal(status: '400');
      } catch (e) {
        return VirtualKitchenModal(status: '400');
      }
    }
  }

  Future<RestrauListByCatModal> fetchRestaurantListByCatRepo({
    required String? category,
    required String latitude,
    required String longitude,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('category', category!));
    formData.fields.add(MapEntry('latitude', latitude));
    formData.fields.add(MapEntry('longitude', longitude));

    var params = ApiEndpoint.VIEW_CATEGORY;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchRestaurantListByCatRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return RestrauListByCatModal.fromMap(userdata);
      } else {
        return RestrauListByCatModal(status: "0");
      }
    } catch (error) {
      try {
        return RestrauListByCatModal(status: '400');
      } catch (e) {
        return RestrauListByCatModal(status: '400');
      }
    }
  }

  Future<SearchModal> fetchSearchRestaurantRepo({
    required String? keyword,
    required String latitude,
    required String longitude,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry('keyword', keyword!));
    formData.fields.add(MapEntry('lat', latitude));
    formData.fields.add(MapEntry('long', longitude));

    var params = ApiEndpoint.SEARCH_RESTAURANT;

    ApiResponse apiResponse = await apiHitter.getFormApiResponse(
        ApiEndpoint.BASE_URL,
        params: params,
        data: formData);

    try {
      Map<String, dynamic> userdata = json.decode(apiResponse.msg!.data);
      print('fetchSearchRestaurantRepo' + userdata.toString());

      if (apiResponse.status == "1") {
        return SearchModal.fromMap(userdata);
      } else {
        return SearchModal(status: "0");
      }
    } catch (error) {
      try {
        return SearchModal(status: "400");
      } catch (e) {
        return SearchModal(status: "400");
      }
    }
  }
}
