import 'package:chat/controllers/authController.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final currentAppuser = UserModel().obs;
  final gender = ''.obs;
  final profileUrl = ''.obs;
  final isLoading = false.obs;
  String newNotificationToken = '';
  final User? _user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  getCurrentUser() async {
    isLoading.toggle();
    Get.find<AuthController>().firebaseUser.value =
        FirebaseAuth.instance.currentUser;
    UserModel? user = await DataBaseMethods().getCurrentLoggedInUser(
        Get.find<AuthController>().firebaseUser.value!.uid);
    currentAppuser.value = user ?? UserModel();
    gender.value = currentAppuser.value.gender!;
    profileUrl.value = currentAppuser.value.imgUrl!;

    await FirebaseMessaging.instance.getToken().then((token) {
      newNotificationToken = token!;
      print('this is token: $newNotificationToken');
    });
    if (currentAppuser.value.notificationTokens == null ||
        currentAppuser.value.notificationTokens == [] ||
        !currentAppuser.value.notificationTokens!
            .contains(newNotificationToken)) {
      final List notificationTokens = currentAppuser.value.notificationTokens!;
      notificationTokens.add(newNotificationToken);
      print("__________________________________");
      print(notificationTokens);
      print(user!.uid);
      if (newNotificationToken != '') {
        print("enter in if block to new token");
        await FirebaseFirestore.instance
            .collection("users")
            .doc(_user!.uid)
            .update({'notificationTokens': notificationTokens});
      }
    }
    isLoading.toggle();
    print('Here is loading value: $isLoading');
    print('This is from build method: ${currentAppuser.value.imgUrl}');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getCurrentUser();
    super.onInit();
  }
}
