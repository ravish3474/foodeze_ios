import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:foodeze_flutter/modal/LoginModal.dart';
import 'package:foodeze_flutter/modal/RestrauListByCatModal.dart';
import 'package:foodeze_flutter/modal/UpdateModal.dart';
import 'package:foodeze_flutter/modal/UpdateProfileModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class AddUserController extends GetxController {
  var repo = ApiRepo();
  var profileImage = ''.obs;
  var profileLoaded = false.obs;


  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  void updateProfileImage(String value) {
    profileImage.value = value;
  }

  void updateProfileLoaded(bool value) {
    profileLoaded.value = value;
  }

  Future<UpdateModal> updateProfile(String userId, String fName, String lName,
      String email) async {
    return await repo.updateProfile(
        userId: userId, fName: fName, lName: lName, email: email);
  }

  Future<UpdateProfileModal> updateUserIamge(String userId,
      String image,) async {
    print('updateUserImage_called' + userId + " " + image);

    return await repo.updateUserIamgeRepo(
        userId: userId, image: image);
  }


}
