import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RequestScreenController extends GetxController {
  final isLoading = false.obs;
  final profiles = [].obs;
  final specialProfiles = [].obs;

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
        List<dynamic> myMap = val['friendRequest'];
        myMap.forEach((element) {
          if (element['recieved'] != '') {
            print("________________________________________");
            print(element['recieved']);
            print(element['bookay']);
            if (element['bookay'] != 0) {
              specialProfiles.add({
                'recieve': element['recieved'],
                'image': element['image'],
                'time': element['time'],
                'email': element['email'],
                'bookay': element['bookay'],
              });
            }
            if(element['bookay'] == 0) {
              profiles.add({
              'recieve': element['recieved'],
              'image': element['image'],
              'time': element['time'],
              'email': element['email']
            });
            }
            
          }
        });
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
