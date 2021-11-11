import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RequestScreenController extends GetxController {
  final isLoading = false.obs;
  final profiles = [].obs;
  final specialProfiles = [].obs;
  final sentProfiles = [].obs;

  removeUser(String uid, int profileType) {
    if (profileType == 0) {
      profiles.removeWhere((profile) => profile['uid'] == uid);
    } else {
      specialProfiles
          .removeWhere((specialProfile) => specialProfile['uid'] == uid);
    }
  }

  fetchUserRequest() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    isLoading.toggle();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('friendRequest')) {
        if (val['friendRequest'].length != 0) {
          List<dynamic> myMap = val['friendRequest'];
          print("This is my map : $myMap");
          myMap.forEach((element) {
            if (element['recieved'] != '') {
              if (element['bookay'] != 0) {
                specialProfiles.add({
                  'recieve': element['recieved'],
                  'image': element['image'],
                  'time': element['time'],
                  'uid': element['id'],
                  'bookay': element['bookay'],
                });
              }
              if (element['bookay'] == 0) {
                profiles.add({
                  'recieve': element['recieved'],
                  'image': element['image'],
                  'time': element['time'],
                  'uid': element['id']
                });
              }
            }
          });
        }
      }
    });

    print('Here I fetch special Profiles from controller');
    print(specialProfiles);
    profiles.sort((a, b) => b["time"].compareTo(a["time"]));
    specialProfiles.sort((a, b) => b["bookay"].compareTo(a["bookay"]));
    isLoading.toggle();
  }

  

  @override
  void onInit() {
    // TODO: implement onInit
    fetchUserRequest();
    
    super.onInit();
  }
}
