import 'package:chat/controllers/global_controller.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SingleUserProfileController extends GetxController {
  final isLoading = false.obs;
  final user = UserModel().obs;
  final GlobalController globalController = Get.put(GlobalController());
  final otherUserGender = "".obs;
  final buttonVisible = true.obs;

  buttonVisibility(String otherUid) async {
    print("HEre button visible function called");
    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(otherUid)
        .get()
        .then((value) {
      user.value = UserModel.fromJson(value.data()!);
      print("Here fetch user happen");
      print("***********************************");
    });

    

    await FirebaseFirestore.instance
        .collection("users")
        .doc(globalController.currentAppuser.value.uid)
        .get()
        .then((val) {

          print(val.data()!['gender']);
          
      Map<String, dynamic> myMap = val.data()!;
      if (val.data()!['uid'] == otherUid) {
        buttonVisible.value = false;
        print("Here button is visible false from same uid");
      } else if (user.value.gender ==
          globalController.currentAppuser.value.gender) {
        buttonVisible.value = false;
        print("Button is visible false from same gender");
      } else if (myMap['matchUsers'] != null) {
        for (int i = 0; i < myMap['matchUsers'].length; i++) {
          if (myMap['matchUsers'][i]['friendUid'] == otherUid) {
            buttonVisible.value = false;
            print("Here button is visible false from matching");
          }
        }
      } else if (myMap['friendRequest'] != null) {
        for (int i = 0; i < myMap['friendRequest'].length; i++) {
          if (myMap['friendRequest'][i]['id'] == otherUid) {
            buttonVisible.value = false;
            print("Here button is visible false from friend request");
          }
        }
      }
    });
    isLoading.toggle();
  }

  // fetchUser(String uid) async {
  //   isLoading.toggle();

  //   isLoading.toggle();
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
