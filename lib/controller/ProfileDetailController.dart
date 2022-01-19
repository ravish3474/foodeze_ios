import 'package:flutter/cupertino.dart';
import 'package:foodeze_flutter/modal/UpdateModal.dart';
import 'package:foodeze_flutter/repo/ApiRepo.dart';
import 'package:get/get.dart';

class ProfileDetailController extends GetxController {
  var repo = ApiRepo();

  var userId = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var uPic = "https://miro.medium.com/max/560/1*MccriYX-ciBniUzRKAUsAw.png".obs;
  var profileLoaded = false.obs;

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  // TODO: implement onDelete
  get onDelete => super.onDelete;

  Future<UpdateModal> updateProfile(
      String userId, String fName, String lName, String email) async {
    return await repo.updateProfile(
        userId: userId, fName: fName, lName: lName, email: email);
  }
}
