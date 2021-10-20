import 'package:chat/controllers/authController.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final currentAppuser = UserModel().obs;
  final gender = ''.obs;
  final isLoading = false.obs;

  getCurrentUser() async {
    isLoading.toggle();
    print('This is get current user function');
    Get.find<AuthController>().firebaseUser.value =
        FirebaseAuth.instance.currentUser;
    UserModel? user = await DataBaseMethods().getCurrentLoggedInUser(
        Get.find<AuthController>().firebaseUser.value!.uid);
    currentAppuser.value = user ?? UserModel();
    gender.value = currentAppuser.value.gender!;
    print('This is current app loggedin user name');
    print(currentAppuser.value.username);
    print('This is current app loggedin gender');
    print(currentAppuser.value.gender);
    print('_________________________________________');

    isLoading.toggle();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getCurrentUser();
    super.onInit();
  }
}
