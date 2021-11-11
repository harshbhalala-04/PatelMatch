import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SentScreenController extends GetxController {
  final isLoading = false.obs;
  final sentProfiles = [].obs;

  fetchUserSent() async {
    isLoading.toggle();

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('friendRequest')) {
        if (val['friendRequest'].length != 0) {
          List<dynamic> myMap = val['friendRequest'];
          myMap.forEach((element) {
            if (element['sent'] != '') {
              sentProfiles.add({
                'sent': element['sent'],
                'image': element['image'],
                'time': element['time'],
                'email': element['email'],
                'bookay': element['bookay']
              });
            }
          });
        }
      }
    });
    print('Sent Profiles');
    print("This is sent profile screen controller_______________");
    sentProfiles.sort((a, b) => b["time"].compareTo(a["time"]));

    

    isLoading.toggle();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchUserSent();
    super.onInit();
  }
}
