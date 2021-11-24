import 'package:chat/controllers/global_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FeedProfileController extends GetxController {
  final isLoading = false.obs;
  final reqRecieve = false.obs;

  checkUserExistInRequest(String userid) async {
    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(Get.find<GlobalController>().currentAppuser.value.uid)
        .get()
        .then((val) {
    
      Map<String, dynamic> tmpMap = val.data()!;
      List<dynamic> friendRequest = tmpMap['friendRequest'];
      for (int i = 0; i < friendRequest.length; i++) {
        print("here value: ${friendRequest[i]['id']}");

        if (friendRequest[i]['id'] == userid) {
          reqRecieve.value = true;
        }
      }
    });
    isLoading.toggle();
  }
}
