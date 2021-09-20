import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  final reply = ''.obs;

  fetchUserCommunity() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('community')) {
        print("init state");
        reply.value = val['community'];
      }
    });
  }

  changeCommunity(String val) {
    reply.value = val;
  }

  void showCustomDialog() {
    Get.defaultDialog(
      middleText: "Plese Select Your Community",
      title: "",
      middleTextStyle: TextStyle(fontSize: 20),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Close'),
                style:
                    TextButton.styleFrom(textStyle: TextStyle(fontSize: 16))),
          ],
        )
      ],
      barrierDismissible: false,
    );
  }
}
